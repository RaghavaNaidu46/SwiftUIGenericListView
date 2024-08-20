//
//  StretchableBackground.swift
//  
//
//  Created by Raghava Dokala on 07/08/24.
//

import Foundation
import SwiftUI

struct StretchableBackground: View {
    let bgImage: String
    var minHeight: CGFloat?  // Add a variable for minimum height

    var body: some View {
        GeometryReader { geometry in
            Image(bgImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width, height: max(geometry.size.height + geometry.frame(in: .global).minY, minHeight ?? 0))
                .offset(y: -geometry.frame(in: .global).minY)
        }
        .frame(height: minHeight ?? 0)  // Use minHeight here
    }
}
