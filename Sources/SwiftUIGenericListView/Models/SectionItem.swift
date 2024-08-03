//
//  SectionItem.swift
//  
//
//  Created by Raghava Dokala on 03/08/24.
//
import SwiftUI

public struct SectionItem: Identifiable {
    public let id = UUID()
    public let title: String
    public let items: ListItem
    public let centerAlignHorizontal: Bool

    public init(title: String, items: ListItem, centerAlignHorizontal: Bool) {
        self.title = title
        self.items = items
        self.centerAlignHorizontal = centerAlignHorizontal
    }
}
