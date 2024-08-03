//
//  SwiftUIView.swift
//  
//
//  Created by Raghava Dokala on 03/08/24.
//

import SwiftUI


struct SampleDataSource: GenericListDataSource {
    func fetchSections() -> [SectionItem] {
        return [
            SectionItem(title: "Horizontal Section Centered", items: .horizontal([
                AnyView(CustomHorizontalItemView(title: "Horizontal 1")),
                AnyView(CustomHorizontalItemView(title: "Horizontal 2"))
            ]), centerAlignHorizontal: true),
            SectionItem(title: "Horizontal Section Not Centered", items: .horizontal([
                AnyView(CustomHorizontalItemView(title: "Horizontal 3")),
                AnyView(CustomHorizontalItemView(title: "Horizontal 4")),
                AnyView(CustomHorizontalItemView(title: "Horizontal 5"))
            ]), centerAlignHorizontal: false),
            SectionItem(title: "Vertical Section", items: .vertical([
                AnyView(CustomVerticalItemView(title: "Vertical 1")),
                AnyView(CustomVerticalItemView(title: "Vertical 2")),
                AnyView(CustomVerticalItemView(title: "Vertical 3"))
            ]), centerAlignHorizontal: false)
        ]
    }
}

struct CustomHorizontalItemView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
    }
}

struct CustomVerticalItemView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(8)
    }
}

struct ContentView: View {
    @StateObject var viewModel = GenericListViewModel(dataSource: SampleDataSource())
    
    var body: some View {
        GenericListView(sections: viewModel.sections)
    }
}
