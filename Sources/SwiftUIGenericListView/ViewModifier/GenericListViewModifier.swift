//
//  GenericListViewModifier.swift
//  
//
//  Created by Raghava Dokala on 06/08/24.
//

import Foundation
import SwiftUI

public protocol GenericListViewStyle {
    associatedtype Body: View
    @ViewBuilder func body(content: AnyView) -> Body
}


public struct GenericListViewModifier<Style: GenericListViewStyle>: ViewModifier {
    let style: Style
    
    public func body(content: Content) -> some View {
        style.body(content: AnyView(content))
    }
}

extension View {
    public func customListStyle<Style: GenericListViewStyle>(_ style: Style) -> some View {
        self.modifier(GenericListViewModifier(style: style))
    }
}
