//
//  CoreView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/15.
//

import SwiftUI

struct StagingView: View {
    @StateObject private var stagingVM: StagingViewModel = StagingViewModel()
    @Namespace var animation
    
    var body: some View {
        ZStack {
            // Background Layer
            Color(.secondarySystemBackground).ignoresSafeArea()
            
            // Side Menu
            VStack(alignment: .leading, spacing: 30) {
                // App display name
                Text("Task Tracker")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                VStack(alignment: .leading, spacing: 10) {
                    // Profile picture
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 70, height: 70)
                        .padding(.top)
                    
                    Spacer()
                    
                    // Destinations
                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(stagingVM.stages) { stage in
                            MenuButton(stage: stage, animation: animation)
                                .environmentObject(stagingVM)
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct StagingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StagingView()
        }
    }
}
