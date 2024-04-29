//
//  StageTab.swift
//  TaskTracker
//
//  Created by Swain Yun on 3/31/24.
//

import SwiftUI

struct StageTab: View {
    @EnvironmentObject private var coreViewModel: DefaultCoreViewModel
    @Binding var isMenuPresented: Bool
    @Binding var selectedStage: StageType
    
    var body: some View {
        TabView(selection: $selectedStage) {
            
        }
    }
}
