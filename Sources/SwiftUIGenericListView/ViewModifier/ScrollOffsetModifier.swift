//
//  ScrollOffsetModifier.swift
//
//
//  Created by Raghava Dokala on 07/08/24.
//

import Foundation
import SwiftUI

struct ScrollOffsetModifier: ViewModifier {
    @Binding var offset: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(GeometryReader { proxy in
                Color.clear
                    .preference(key: HeightPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
            })
            .onPreferenceChange(HeightPreferenceKey.self) { value in
                offset = value
            }
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
