//
//  File.swift
//  
//
//  Created by Raghava Dokala on 07/08/24.
//

import Foundation
import SwiftUI

public protocol GenericListViewSectionStyle {
    associatedtype Body: View
    @ViewBuilder func body(content: AnyView) -> Body
}

public struct GenericListSectionModifier<Style: GenericListViewSectionStyle>: ViewModifier {
    let style: Style
    
    public func body(content: Content) -> some View {
        style.body(content: AnyView(content))
    }
}

extension View {
    public func customSectionStyle<Style: GenericListViewSectionStyle>(_ style: Style) -> some View {
        self.modifier(GenericListSectionModifier(style: style))
    }
}
