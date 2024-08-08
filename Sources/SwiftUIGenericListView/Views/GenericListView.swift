//
//  GenericListView.swift
//
//
//  Created by Raghava Dokala on 03/08/24.
//

import SwiftUI

public struct GenericListView: View {
    public let sections: [SectionItem]
    public var stretchableBackground:(Bool?, String?)? = (false, nil)
    public var scrollViewBackground:Color?
    @State private var scrollOffset: CGFloat = 0
    @State private var listHeight: CGFloat = 0
    
    
    public init(sections: [SectionItem], scrollViewBackground:Color? = Color(hex: "#F5F5F5"), stretchableBackground:(Bool?, String?)? = (false, nil)) {
        self.sections = sections
        self.stretchableBackground = stretchableBackground
        self.scrollViewBackground = scrollViewBackground
    }
    
    public var body: some View {
        GeometryReader(){ geometry in
            ScrollView{
                ZStack(alignment: .top){
                    if let stretchable = stretchableBackground{
                        StretchableBackground(bgImage: stretchable.1 ?? "")
                    }
                    List() {
                        ForEach(sections) { section in
                            Section() {
                                switch section.items {
                                case .horizontal(let items):
                                    HorizontalSectionView(items: items, centerAlign: section.centerAlignHorizontal ?? false, action: section.action, canMagnify: section.canMagnify ?? false, selectedItem: section.selectedItem)
                                        .listRowBackground(section.backgroundColor ?? section.sectionStyle?.backgroundColor)
                                case .vertical(let items):
                                    VerticalSectionView(items: items,action: section.action)
                                        .listRowBackground(section.backgroundColor ?? section.sectionStyle?.backgroundColor)
                                }
                            } header: {
                                if let header = section.title {
                                    Text(header)
                                        .font(section.sectionStyle?.headerFont ?? .headline)
                                        .foregroundColor(section.sectionStyle?.headerColor ?? .primary)
                                        .padding(section.sectionStyle?.headerPadding ?? .init())
                                }else{
                                    EmptyView()
                                }
                            }
                            //.background(section.sectionStyle?.backgroundColor)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .listSectionSpacing(20)
                }.frame(width: geometry.size.width, height: geometry.size.height)
            }.background(scrollViewBackground)
        }
        
    }
}

