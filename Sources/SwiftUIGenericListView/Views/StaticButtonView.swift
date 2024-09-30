//
//  StaticButtonView.swift
//
//
//  Created by Raghava Dokala on 20/08/24.
//

import SwiftUI

public struct StaticButtonView: View {
    let items: AnyView
    let centerAlign: Bool
    let action: ((Int) -> Void)?
    
    public var body: some View {
        items
            .clipped(antialiased: true)
            .onTapGesture {
                action?(0)
            }
    }
}
