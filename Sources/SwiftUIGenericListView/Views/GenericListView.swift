//
//  GenericListView.swift
//
//
//  Created by Raghava Dokala on 03/08/24.
//

import SwiftUI

struct GenericListView: View {
    let sections: [SectionItem]
         
    var body: some View {
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
