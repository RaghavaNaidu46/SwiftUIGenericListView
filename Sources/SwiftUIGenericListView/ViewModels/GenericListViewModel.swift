//
//  GenericListViewModel.swift
//  
//
//  Created by Raghava Dokala on 03/08/24.
//

import SwiftUI


public class GenericListViewModel: ObservableObject {
    @Published public var sections: [SectionItem] = []
    private let dataSource: any GenericListDataSource
       
    public init(dataSource: any GenericListDataSource) {
        self.dataSource = dataSource
        loadSections()
    }
       
    private func loadSections() {
        sections = dataSource.fetchSections()
    }
}
