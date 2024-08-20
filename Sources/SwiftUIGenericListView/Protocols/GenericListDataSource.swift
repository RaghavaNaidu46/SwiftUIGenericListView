//
//  GenericListDataSource.swift
//
//
//  Created by Raghava Dokala on 03/08/24.
//

import Foundation

public protocol GenericListDataSource {
    func fetchSections() -> [SectionItem]
    mutating func addItems(_ items: [SectionItem]) throws -> [SectionItem]
}

extension GenericListDataSource {
    mutating func addItems(_ items: [SectionItem]) -> [SectionItem] {
        // Default implementation simply returns the input for demonstration
        return items
    }
}
