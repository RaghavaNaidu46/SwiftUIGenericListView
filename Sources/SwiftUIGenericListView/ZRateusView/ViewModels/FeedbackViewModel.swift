//
//  FeedbackViewModel.swift
//  ZFeedback
//
//  Created by Raghava Dokala on 29/08/24.
//

import SwiftUI

struct FeedbackDataSource: GenericListDataSource {
    var sections: [SectionItem] = []
    
    mutating func addItems(_ items: [SectionItem]) throws -> [SectionItem] {
        sections.append(contentsOf: items)
        return sections
    }
    
    func fetchSections() -> [SectionItem] {
        return sections
    }
}
