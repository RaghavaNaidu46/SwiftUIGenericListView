//
//  GenericListDataSource.swift
//
//
//  Created by Raghava Dokala on 03/08/24.
//

import Foundation

public protocol GenericListDataSource {
    func fetchSections() -> [SectionItem]
}
