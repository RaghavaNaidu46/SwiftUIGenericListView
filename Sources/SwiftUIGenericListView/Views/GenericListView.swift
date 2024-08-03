//
//  GenericListView.swift
//
//
//  Created by Raghava Dokala on 03/08/24.
//

import SwiftUI

public struct GenericListView: View {
    public let sections: [SectionItem]
       
    public init(sections: [SectionItem]) {
        self.sections = sections
    }
       
    public var body: some View {
        List {
            ForEach(sections) { section in
                Section(header: Text(section.title)) {
                    switch section.items {
                    case .horizontal(let items):
                        HorizontalSectionView(items: items, centerAlign: section.centerAlignHorizontal)
                    case .vertical(let items):
                        VerticalSectionView(items: items)
                    }
                }
            }
        }
    }
}
