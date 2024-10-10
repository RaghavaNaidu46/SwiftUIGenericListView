//
//  HeightReader.swift
//  
//
//  Created by Raghava Dokala on 03/08/24.
//

import SwiftUI

struct HeightReader: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: HeightPreferenceKey.self, value: geometry.size.height)
        }
    }
}

struct ContentHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
