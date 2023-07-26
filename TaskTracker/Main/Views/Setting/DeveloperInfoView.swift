//
//  DeveloperInfoView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/26.
//

import SwiftUI

struct DeveloperInfoView: View {
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground).ignoresSafeArea()
            
            HStack {
                Image("dev-jeans")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text("SwainYun")
                        .font(.headline)
                    Text("destap@naver.com")
                    Link(destination: URL(string: "https://github.com/Remaked-Swain")!) {
                        Text("GitHub")
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .background(RoundedRectangle(cornerRadius: 25).foregroundColor(.white))
            .padding()
        }
        .navigationTitle("개발자 정보")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DeveloperInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DeveloperInfoView()
        }
    }
}
