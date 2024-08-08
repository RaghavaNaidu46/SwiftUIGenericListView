//
//  HorizontalSectionView.swift
//
//
//  Created by Raghava Dokala on 03/08/24.
//

import SwiftUI

public struct HorizontalSectionView: View {
    let items: [AnyView]
    let centerAlign: Bool
    var contentHeight: CGFloat = 0
    let canMagnify: Bool
    var selectedItem: Int?
    let action: ((Int) -> Void)?
    
    @State private var selectedIndex: Int? = nil
    
    public var body: some View {
        VStack {
            CenteringScrollView(shouldCenter: centerAlign) {
                HStack(spacing: 20) {
                    ForEach(0..<items.count, id: \.self) { index in
                        items[index]
                            .ifTrue(canMagnify){
                                $0.scaleEffect(selectedIndex == index ? 1.1 : 1.0)
                                    .padding(selectedIndex == index ? 10 : 0) // Adjust padding based on selection
                            }
                            .animation(.easeInOut(duration: 0.2), value: selectedIndex)
                            .onTapGesture {
                                selectedIndex = index
                                action?(index)
                            }
                    }
                }
            }
        }.onAppear(perform: {
            selectedIndex = selectedItem
        })
    }
}

extension View {
    func ifTrue<T: View>(_ condition: Bool, apply: (Self) -> T) -> some View {
        if condition {
            return AnyView(apply(self))
        } else {
            return AnyView(self)
        }
    }
}
