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
    let action: ((Int) -> Void)?
    @State private var selectedItem: Int? = nil

    var body: some View {
        CenteringScrollView(shouldCenter: centerAlign) {
            HStack {
                ForEach(0..<items.count, id: \.self) { index in
                    items[index]
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(selectedItem == index ? Color.green : Color.gray, lineWidth: 1))
                        .background(selectedItem == index ? (Color.green.opacity(0.2)) : Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            selectedItem = index
                            action?(index)
                        }
                }
            }
        }
    }
}
