//
//  GenericListViewModel.swift
//  
//
//  Created by Raghava Dokala on 03/08/24.
//

import SwiftUI

class GenericListViewModel: ObservableObject {
    @Published var sections: [SectionItem] = []
    private let dataSource: any GenericListDataSource
         
    init(dataSource: any GenericListDataSource) {
        self.dataSource = dataSource
        loadSections()
    }
         
    private func loadSections() {
        sections = dataSource.fetchSections()
    }
}
