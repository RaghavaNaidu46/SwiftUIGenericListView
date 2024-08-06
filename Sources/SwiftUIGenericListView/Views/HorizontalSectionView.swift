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
         
    public var body: some View {
        VStack {
            CenteringScrollView(shouldCenter: centerAlign) {
                HStack(spacing: 20) {
                    ForEach(0..<items.count, id: \.self) { index in
                        items[index]
                    }
                }
            }
        }
    }
}

