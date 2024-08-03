//
//  SectionItem.swift
//  
//
//  Created by Raghava Dokala on 03/08/24.
//
import SwiftUI

struct SectionItem: Identifiable {
    let id = UUID()
    let title: String
    let items: ListItem
    let centerAlignHorizontal: Bool
}

