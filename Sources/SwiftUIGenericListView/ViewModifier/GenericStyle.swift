//
//  SectionStyle.swift
//  
//
//  Created by Raghava Dokala on 07/08/24.
//

import Foundation
import SwiftUI

public struct GenericStyle {
    public let sectionStyle:SectionStyle?
    public let rowStyle:SectionRowStyle?
    public let highlightStyle: HighlightStyle?
    
    public init(sectionStyle:SectionStyle? = nil, rowStyle:SectionRowStyle? = nil, highlightStyle:HighlightStyle? = nil) {
        self.rowStyle = rowStyle
        self.sectionStyle = sectionStyle
        self.highlightStyle = highlightStyle
    }
}

public struct SectionStyle{
    public let backgroundColor: Color?
    public let headerBackgroundColor: Color?
    public let headerWidth: CGFloat?
    public let headerTextAlignment: TextAlignment?
    public let headerFont: Font?
    public let headerColor: Color?
    public let headerPadding: EdgeInsets?
    public let shadow:CGFloat?

    public init(
        backgroundColor: Color? = .white,
        headerBackgroundColor: Color? = .clear,
        headerTextAlignment: TextAlignment? = .leading,
        headerFont: Font? = nil,
        headerColor: Color? = .gray,
        headerPadding: EdgeInsets? = nil,
        shadow:CGFloat? = 0,
        headerWidth: CGFloat? = .zero
        
    ) {
        self.backgroundColor = backgroundColor
        self.headerBackgroundColor = headerBackgroundColor
        self.headerFont = headerFont
        self.headerColor = headerColor
        self.headerPadding = headerPadding
        self.shadow = shadow
        self.headerTextAlignment = headerTextAlignment
        self.headerWidth = headerWidth
    }
}


public struct SectionRowStyle{
    public let rowBackgroundColor: Color?
    public let selectedRowBackgroundColor: Color?
    public let rowTextAlignment: TextAlignment?
    public let rowFont: Font?
    public let rowBorderColor: Color?
    public let selectedRowBorderColor: Color?
    public let selectedFontColor: Color?
    public let rowPadding: EdgeInsets?
    public let rowShadow:CGFloat?
    public let rowBorderWidth:CGFloat?

    public init(
        rowBackgroundColor: Color? = .clear,
        selectedRowBackgroundColor: Color? = .clear,
        rowTextAlignment: TextAlignment? = .leading,
        rowFont: Font? = nil,
        rowBorderColor: Color? = .gray,
        selectedRowBorderColor: Color? = .clear,
        selectedFontColor: Color? = .clear,
        rowPadding: EdgeInsets? = nil,
        rowShadow:CGFloat? = 0,
        rowBorderWidth:CGFloat? = 0
    ) {
        self.rowBackgroundColor = rowBackgroundColor
        self.selectedRowBackgroundColor = selectedRowBackgroundColor
        self.rowFont = rowFont
        self.rowBorderColor = rowBorderColor
        self.selectedRowBorderColor = selectedRowBorderColor
        self.rowPadding = rowPadding
        self.rowShadow = rowShadow
        self.rowTextAlignment = rowTextAlignment
        self.rowBorderWidth = rowBorderWidth
        self.selectedFontColor = selectedFontColor
        
    }
}

public struct HighlightStyle {
    let background: Color?
    let border: Color?
    let textColor: Color?
    
    public init(background: Color? = .clear, border: Color? = .clear, textColor: Color? = .black) {
        self.background = background
        self.border = border
        self.textColor = textColor
    }
}
