//
//  AppDependencyContainer.swift
//  TaskTracker
//
//  Created by Swain Yun on 4/11/24.
//

import Foundation

protocol DependencyResolvable {
    func resolve<T>(for type: T.Type) -> T
}

protocol DependencyRegistrable {
    func register<T>(for type: T.Type, with instance: T)
    func register<T>(for type: T.Type, _ handler: @escaping (DependencyResolvable) -> T)
}

typealias DependencyContainer = DependencyResolvable & DependencyRegistrable

final class DefaultDependencyContainer {
    private var container: [String: Any] = [:]
}

// MARK: DependencyContainer Confirmation
extension DefaultDependencyContainer: DependencyContainer {
    func register<T>(for type: T.Type, with instance: T) {
        let key = String(describing: type)
        container[key] = instance
    }
    
    func register<T>(for type: T.Type, _ handler: @escaping (DependencyResolvable) -> T) {
        let key = String(describing: type)
        container[key] = handler
    }
    
    func resolve<T>(for type: T.Type) -> T {
        let key = String(describing: type)
        
        if let value = container[key] as? T {
            return value
        } else if let handler = container[key] as? (DependencyResolvable) -> T {
            return handler(self)
        } else {
            fatalError("Can not resolve dependency for \(type)")
        }
    }
}
