//
//  HelpView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/26.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 5) {
                    Text("할 일 목록")
                        .font(.title2.weight(.semibold))
                    VStack(alignment: .leading) {
                        Text("해야할 일과 진행 상태를 관리할 수 있습니다. 제목과 간단한 설명을 작성할 수 있고, 마감일을 설정하여 추적할 수 있습니다. 또한 카테고리를 설정하여 분류하면 더욱 쉽게 관리할 수 있습니다.")
                    }
                    .font(.subheadline)
                    Divider()
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("카테고리 관리")
                        .font(.title2.weight(.semibold))
                    VStack(alignment: .leading) {
                        Text("할 일을 분류하기 위해 카테고리를 생성하거나 삭제할 수 있습니다.")
                    }
                    .font(.subheadline)
                    Divider()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .navigationTitle("도움말")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HelpView()
        }
    }
}
