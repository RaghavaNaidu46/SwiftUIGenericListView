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
    @Binding var contentHeight: CGFloat

    public init(sections: [SectionItem]?, scrollViewBackground: Color? = Color(hex: "#F5F5F5"), stretchableBackground: (Bool?, String?)? = (false, nil), contentHeight: Binding<CGFloat>) {
        self.sections = sections
        self.stretchableBackground = stretchableBackground
        self.scrollViewBackground = scrollViewBackground
        self._contentHeight = contentHeight
    }
    
    public var body: some View {
        GeometryReader { geometry in
            if let stretchable = stretchableBackground, stretchable.1 != nil {
                ScrollView {
                    ZStack(alignment: .top) {
                        if let stretchable = stretchableBackground {
                            StretchableBackground(bgImage: stretchable.1 ?? "")
                        }
                        commonListView(geometry: geometry)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
                .background(scrollViewBackground)
                .background(GeometryReader {
                    Color.clear.preference(key: ViewHeightKey.self, value: $0.frame(in: .local).size.height)
                })
                .onPreferenceChange(ViewHeightKey.self) { height in
                    contentHeight = height
                }
                .gesture(
                    DragGesture().onChanged { _ in
                        self.hideKeyboard()
                    }
                )
                .onTapGesture {
                    self.hideKeyboard()
                }
            } else {
                ZStack(alignment: .top) {
                    commonListView(geometry: geometry)
                }
                .background(GeometryReader {
                    Color.clear.preference(key: ViewHeightKey.self, value: $0.frame(in: .local).size.height)
                })
                .onPreferenceChange(ViewHeightKey.self) { height in
                    contentHeight = height
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
    
    @ViewBuilder
    private func commonListView(geometry: GeometryProxy) -> some View {
        List {
            if let sectionItems = sections{
                ForEach(sectionItems) { section in
                    Section() {
                        switch section.items {
                        case .horizontal(let items):
                            HorizontalSectionView(items: items, centerAlign: section.centerAlignHorizontal ?? false, canMagnify: section.canMagnify ?? false, selectedItem: section.selectedItem, action: section.action)
                                .listRowBackground(section.backgroundColor ?? section.sectionStyle?.backgroundColor)
                        case .vertical(let items):
                            VerticalSectionView(items: items, action: section.action)
                                .listRowBackground(section.backgroundColor ?? section.sectionStyle?.backgroundColor)
                        case .flow(let items):
                            FlowLayoutSectionView(items: items, action: section.action)
                                .listRowBackground(section.backgroundColor ?? section.sectionStyle?.backgroundColor)
                        case .expandableTextView(let viewModel):
                            ExpandableTextView(viewModel: viewModel, action: viewModel.action)
                                .frame(minHeight: viewModel.dynamicHeight, maxHeight: .infinity)
                                .listRowBackground(section.backgroundColor ?? section.sectionStyle?.backgroundColor)
                        case .staticHView((let items)):
                            StaticHView(items: items, action: section.action)
                        }
                    } header: {
                        if let header = section.title {
                            Text(header)
                                .font(section.sectionStyle?.headerFont ?? .headline)
                                .foregroundColor(section.sectionStyle?.headerColor ?? .primary)
                                .padding(section.sectionStyle?.headerPadding ?? .init())
                        } else {
                            EmptyView()
                                .frame(height: 45)
                        }
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .listSectionSpacing(20)
    }
}


struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
