//
//  SectionStyle.swift
//  
//
//  Created by Raghava Dokala on 07/08/24.
//

import Foundation
import SwiftUI

public struct SectionStyle {
    public let backgroundColor: Color?
    public let headerBackgroundColor: Color?
    public let headerFont: Font?
    public let headerColor: Color?
    public let headerPadding: EdgeInsets?
    public let shadow:CGFloat?
    
    public init(
        backgroundColor: Color? = .white,
        headerBackgroundColor: Color? = .clear,
        headerFont: Font? = nil,
        headerColor: Color? = .gray,
        headerPadding: EdgeInsets? = nil,
        shadow:CGFloat? = 0
    ) {
        self.backgroundColor = backgroundColor
        self.headerBackgroundColor = headerBackgroundColor
        self.headerFont = headerFont
        self.headerColor = headerColor
        self.headerPadding = headerPadding
        self.shadow = shadow
    }
}
