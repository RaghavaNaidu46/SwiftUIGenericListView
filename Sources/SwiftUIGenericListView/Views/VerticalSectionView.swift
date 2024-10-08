//
//  VerticalSectionView.swift
//
//
//  Created by Raghava Dokala on 03/08/24.
//

import SwiftUI


struct VerticalSectionView: View {
    let items: [AnyView]
    let action: ((Int) -> Void)?
    let vSpacing: CGFloat?
    var body: some View {
        ForEach(0..<items.count, id: \.self) { index in
            items[index]
                .padding(.vertical, vSpacing)
                .onTapGesture {
                    action?(index)
                }
        }
    }
}
