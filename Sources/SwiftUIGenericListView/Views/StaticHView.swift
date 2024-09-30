//
//  StaticHView.swift
//
//
//  Created by Raghava Dokala on 12/08/24.
//

import SwiftUI

struct StaticHView: View {
    let items: [AnyView]
    let centerAlign: Bool
    let highlightStyle:HighlightStyle
    let action: ((Int) -> Void)?
    @State var selectedItem: Int? = nil
    
    var body: some View {
        HStack() {
            ForEach(0..<items.count, id: \.self) { index in
                items[index]
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(selectedItem == index ? Color(UIColor(highlightStyle.border ?? .clear)) : Color.gray, lineWidth: 1))
                    .background(selectedItem == index ? 
                                highlightStyle.selectedBackground : highlightStyle.initialBackground)
                    .foregroundColor(.red)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        selectedItem = index
                        action?(index)
                    }
                if index < (items.count - 1){
                    Spacer()
                        .frame(maxWidth: 30)
                }
            }
        }
        .padding(5)
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

