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
    let canMagnify: Bool
    let canHighlight: Bool
    @State var selectedItem: Int? = nil
    let action: ((Int) -> Void)?
    
    @State private var selectedIndex: Int? = nil
    
    public var body: some View {
        VStack {
            CenteringScrollView(shouldCenter: centerAlign) {
                HStack(spacing: 20) {
                    ForEach(0..<items.count, id: \.self) { index in
                        items[index]
                            .ifTrue(canHighlight) {
                                $0.overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedItem == index ? Color.green : Color.gray, lineWidth: 1))
                                .background(selectedItem == index ? (Color.green.opacity(0.2)) : Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .ifTrue(canMagnify) {
                                $0.scaleEffect(selectedIndex == index ? 1.1 : 1.0)
                                    .padding(selectedIndex == index ? 10 : 0)
                            }
                            
                            
                            .animation(.easeInOut(duration: 0.2), value: selectedIndex)
                            .onTapGesture {
                                selectedIndex = index
                                action?(index)
                            }
                    }
                }
            }
        }
        .onAppear {
            selectedIndex = selectedItem
        }
    }
}

extension View {
    func ifTrue<T: View>(_ condition: Bool, apply: (Self) -> T) -> some View {
        condition ? AnyView(apply(self)) : AnyView(self)
    }
}
