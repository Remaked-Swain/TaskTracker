//
//  DataService.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/14.
//

import Foundation
import CoreData

class DataService {
    static let shared = DataService()
    
    private let persistentContainer: NSPersistentContainer
    
    private init() {
        self.persistentContainer = NSPersistentContainer(name: "TaskTracker")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("persistentStore error: \(error)")
            }
        }
    }
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let error = error as NSError
                fatalError("saveContext error: \(error)")
            }
        }
    }
    
    func saveTask(_ task: TaskModel) {
        viewContext.perform { [weak self] in
            guard let context = self?.viewContext else { return }
            
            let newTask = TaskEntity(context: context)
            newTask.id = task.id
            newTask.title = task.title
            newTask.taskDescription = task.taskDescription
            newTask.deadline = task.deadline
            newTask.isCompleted = task.isCompleted
            
            self?.saveContext()
        }
    }
    
    func updateTask(_ task: TaskModel) {
        viewContext.perform { [weak self] in
            let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
            
            do {
                if let result = try self?.viewContext.fetch(request).first {
                    result.title = task.title
                    result.taskDescription = task.taskDescription
                    result.deadline = task.deadline
                    result.isCompleted = task.isCompleted
                    self?.saveContext()
                }
            } catch let error {
                print("Failed to update task: \(error)")
            }
        }
    }
    
    func deleteTask(_ task: TaskModel) {
        viewContext.perform { [weak self] in
            let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
            
            do {
                if let result = try self?.viewContext.fetch(request).first {
                    self?.viewContext.delete(result)
                    self?.saveContext()
                }
            } catch let error {
                print("Failed to delete task: \(error)")
            }
        }
    }
    
    func fetchTasks(completion: @escaping ([TaskModel]) -> Void) {
        viewContext.perform { [weak self] in
            let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
            
            do {
                let taskEntities = try self?.viewContext.fetch(request)
                let tasks = taskEntities?.map { taskEntity in
                    TaskModel(
                        id: taskEntity.id ?? UUID(),
                        title: taskEntity.title ?? "새로운 할 일",
                        taskDescription: taskEntity.taskDescription,
                        deadline: taskEntity.deadline,
                        isCompleted: taskEntity.isCompleted
                    )
                } ?? []
                completion(tasks)
            } catch let error {
                print("Failed to fetch tasks: \(error)")
                completion([])
            }
        }
    }
}
