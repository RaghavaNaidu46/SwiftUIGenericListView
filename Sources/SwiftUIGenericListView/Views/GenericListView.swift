//
//  GenericListView.swift
//
//
//  Created by Raghava Dokala on 03/08/24.
//

import SwiftUI

public struct GenericListView: View {
    public let sections: [SectionItem]?
    public var stretchableBackground: (Bool?, String?)? = (false, nil)
    public var scrollViewBackground: Color?
    @Binding var contentHeight: CGFloat?
    
    public init(sections: [SectionItem]?, scrollViewBackground: Color? = Color(hex: "#F5F5F5"), stretchableBackground: (Bool?, String?)? = (false, nil), contentHeight: Binding<CGFloat?>? = nil) {
        self.sections = sections
        self.stretchableBackground = stretchableBackground
        self.scrollViewBackground = scrollViewBackground
        self._contentHeight = contentHeight ?? .constant(0)
    }
    
    public var body: some View {
        if let stretchable = stretchableBackground, stretchable.1 != nil {
            ScrollView{
                ZStack{
                    if let stretchable = stretchableBackground {
                        StretchableBackground(bgImage: stretchable.1 ?? "")
                    }
                    VStack(alignment: .leading, spacing: 20) {
                        if let sectionItems = sections {
                            ForEach(sectionItems) { section in
                                sectionView(section: section)
                            }
                        }
                    }
                }
            }
        }else{
            ScrollView{
                VStack(alignment: .leading, spacing: 20) {
                    if let sectionItems = sections {
                        ForEach(sectionItems) { section in
                            sectionView(section: section)
                        }
                    }
                }
                .background(GeometryReader { proxy in
                    Color.clear.task {
                        contentHeight = proxy.size.height
                    }
                        .preference(key: HeightPreferenceKey.self, value: proxy.size.height)
                })
            }
        }
    }
    
    @ViewBuilder
    private func sectionView(section: SectionItem) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            if let header = section.title {
                Text(header)
                    .background(section.sectionStyle?.sectionStyle?.backgroundColor)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(section.sectionStyle?.sectionStyle?.headerTextAlignment ?? .leading)
                    .font(section.sectionStyle?.sectionStyle?.headerFont ?? .headline)
                    .foregroundColor(section.sectionStyle?.sectionStyle?.headerColor ?? .primary)
                    .padding(section.sectionStyle?.sectionStyle?.headerPadding ?? .init())
                    .padding(.top, 10)
            } else {
                Spacer().frame(height: 0)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                sectionContent(section: section)
                    .background(GeometryReader { proxy in
                        Color.clear.task {
                            if var cHeight = contentHeight{
                                cHeight += cHeight + proxy.size.height
                                contentHeight = cHeight
                            }
                        }
                            .preference(key: HeightPreferenceKey.self, value: proxy.size.height)
                    })
            }
            .padding()
            .background(
                section.isGrouped
                ? AnyView(RoundedRectangle(cornerRadius: 10).fill(section.backgroundColor ?? Color.white).shadow(radius: 1))
                : AnyView(Color.clear)
            )
        }
        .padding([.leading, .trailing])
    }
    
    @ViewBuilder
    private func sectionContent(section: SectionItem) -> some View {
        switch section.items {
        case .horizontal(let items):
            HorizontalSectionView(items: items, centerAlign: section.centerAlignHorizontal ?? false, canMagnify: section.canMagnify ?? false, selectedItem: section.selectedItem, action: section.action)
                .background(section .backgroundColor ?? section.sectionStyle?.sectionStyle?.backgroundColor)
        case .vertical(let items):
                VerticalSectionView(items: items, action: section.action)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(section.backgroundColor ?? section.sectionStyle?.sectionStyle?.backgroundColor)
            
        case .flow(let items):
            FlowLayoutSectionView(items: items, rowStyle: section.sectionStyle?.rowStyle, action: section.action)
                .background(section.backgroundColor ?? section.sectionStyle?.sectionStyle?.backgroundColor)
        case .expandableTextView(let viewModel):
            ExpandableTextView(viewModel: viewModel)
                .frame(minHeight: viewModel.dynamicHeight, maxHeight: .infinity)
                .background(section.backgroundColor ?? section.sectionStyle?.sectionStyle?.backgroundColor)
        case .staticHView(let items):
            StaticHView(items: items, centerAlign: section.centerAlignHorizontal ?? false, action: section.action)
                .background(section.backgroundColor ?? section.sectionStyle?.sectionStyle?.backgroundColor)
        }
    }
}

struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
