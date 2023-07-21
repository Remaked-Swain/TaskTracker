//
//  SectionHeaderView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/21.
//

import SwiftUI

struct FoldableSectionHeader: View {
    @Binding var isExpanded: Bool
    
    let text: String
    let label: Image
    
    init(isExpanded: Binding<Bool>, text: String, label: Image = Image(systemName: "chevron.up")) {
        self._isExpanded = isExpanded
        self.text = text
        self.label = label
    }
    
    var body: some View {
        HStack {
            Text(text)
            
            Spacer()
            
            Button {
                withAnimation(.spring()) {
                    isExpanded.toggle()
                }
            } label: {
                label
                    .rotationEffect(Angle(degrees: isExpanded ? 0 : 180))
                    .tint(.accentColor)
            }
        }
    }
}
