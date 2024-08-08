//
//  StretchableBackground.swift
//  
//
//  Created by Raghava Dokala on 07/08/24.
//

import Foundation
import SwiftUI

struct StretchableBackground: View {
    public var bgImage: String
    var body: some View {
        GeometryReader { geometry in
            Image(bgImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width,
                       height: max(geometry.size.height + geometry.frame(in: .global).minY, 300))
                .offset(y: -geometry.frame(in: .global).minY)
        }
        .frame(height: 300)
    }
}
