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
    public let canMagnify: Bool?
    public let selectedItem: Int?
    public let backgroundColor: Color?
    public let sectionStyle: SectionStyle?
    public let action: ((Int) -> Void)?
    
    public init(
        title: String? = nil,
        items: ListItem,
        centerAlignHorizontal: Bool? = false,
        canMagnify: Bool? = false,
        selectedItem: Int? = nil,
        backgroundColor: Color? = nil,
        sectionStyle: SectionStyle? = nil,
        action: ((Int) -> Void)? = nil
    ) {
        self.title = title
        self.items = items
        self.centerAlignHorizontal = centerAlignHorizontal
        self.canMagnify = canMagnify
        self.backgroundColor = backgroundColor
        self.sectionStyle = sectionStyle
        self.action = action
        self.selectedItem = selectedItem
    }
}
