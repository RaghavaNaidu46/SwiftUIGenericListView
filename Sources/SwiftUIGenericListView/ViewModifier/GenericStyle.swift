//
//  SectionStyle.swift
//  
//
//  Created by Raghava Dokala on 07/08/24.
//

import Foundation
import SwiftUI

public struct GenericStyle {
    public let backgroundColor: Color?
    public let headerBackgroundColor: Color?
    public let headerTextAlignment: TextAlignment?
    public let headerFont: Font?
    public let headerColor: Color?
    public let headerPadding: EdgeInsets?
    public let shadow:CGFloat?
    public let rowStyle:SectionRowStyle?
    public init(
        backgroundColor: Color? = .white,
        headerBackgroundColor: Color? = .clear,
        headerTextAlignment: TextAlignment? = .leading,
        headerFont: Font? = nil,
        headerColor: Color? = .gray,
        headerPadding: EdgeInsets? = nil,
        shadow:CGFloat? = 0,
        rowStyle:SectionRowStyle? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.headerBackgroundColor = headerBackgroundColor
        self.headerFont = headerFont
        self.headerColor = headerColor
        self.headerPadding = headerPadding
        self.shadow = shadow
        self.headerTextAlignment = headerTextAlignment
        self.rowStyle = rowStyle
    }
}

public struct SectionRowStyle{
    public let rowBackgroundColor: Color?
    public let rowTextAlignment: TextAlignment?
    public let rowFont: Font?
    public let rowBorderColor: Color?
    public let rowPadding: EdgeInsets?
    public let rowShadow:CGFloat?

    public init(
        rowBackgroundColor: Color? = .clear,
        rowTextAlignment: TextAlignment? = .leading,
        rowFont: Font? = nil,
        rowBorderColor: Color? = .gray,
        rowPadding: EdgeInsets? = nil,
        rowShadow:CGFloat? = 0
    ) {
        self.rowBackgroundColor = rowBackgroundColor
        self.rowFont = rowFont
        self.rowBorderColor = rowBorderColor
        self.rowPadding = rowPadding
        self.rowShadow = rowShadow
        self.rowTextAlignment = rowTextAlignment
    }
}
