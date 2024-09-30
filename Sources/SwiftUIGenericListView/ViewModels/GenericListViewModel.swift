//
//  GenericListViewModel.swift
//  
//
//  Created by Raghava Dokala on 03/08/24.
//

import SwiftUI
import Combine

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
struct GenericView:  ViewModifier {
    let switchAction: (() -> Void)
    let buttonAction: (() -> Void)
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                switchAction()
            }
    }
}
