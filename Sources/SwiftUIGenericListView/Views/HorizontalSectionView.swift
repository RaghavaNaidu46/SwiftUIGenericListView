//
//  HorizontalSectionView.swift
//  
//
//  Created by Raghava Dokala on 03/08/24.
//

import SwiftUI

struct HorizontalSectionView: View {
    let items: [AnyView]
    let centerAlign: Bool
         
    @State private var contentHeight: CGFloat = 0
         
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    if centerAlign {
                        Spacer(minLength: max((geometry.size.width - totalWidth(in: geometry)) / 2, 0))
                    }
                    ForEach(0..<items.count, id: \.self) { index in
                        items[index]
                            .background(HeightReader())
                            .onPreferenceChange(ContentHeightKey.self) { height in
                                contentHeight = max(contentHeight, height)
                            }
                    }
                    if centerAlign {
                        Spacer(minLength: max((geometry.size.width - totalWidth(in: geometry)) / 2, 0))
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(height: contentHeight)
    }
         
    private func totalWidth(in geometry: GeometryProxy) -> CGFloat {
        let totalWidth = items.reduce(0) { sum, item in
            let itemSize = UIHostingController(rootView: item).view.intrinsicContentSize
            return sum + itemSize.width
        }
        return totalWidth
    }
}
