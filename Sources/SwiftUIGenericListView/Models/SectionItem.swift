//
//  SectionItem.swift
//
//
//  Created by Raghava Dokala on 03/08/24.
//
import SwiftUI

public struct SectionItem: Identifiable {
    public let id = UUID()
    public let title: String?
    public let items: ListItem
    public let centerAlignHorizontal: Bool?
    public let backgroundColor: Color?
    public let sectionStyle: SectionStyle?
    
    public init(
        title: String? = nil,
        items: ListItem,
        centerAlignHorizontal: Bool? = false,
        backgroundColor: Color? = nil,
        sectionStyle: SectionStyle? = nil) {
            self.title = title
            self.items = items
            self.centerAlignHorizontal = centerAlignHorizontal
            self.backgroundColor = backgroundColor
            self.sectionStyle = sectionStyle
        }
}
