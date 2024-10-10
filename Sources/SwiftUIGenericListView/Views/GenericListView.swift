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
    public var contentPadding: CGFloat = .zero
    public var headerMinHeight: CGFloat?
    @Binding var contentHeight: CGFloat?
    public var cHeight: (CGFloat) -> Void
    @Binding var returnContentHeight: Bool?
    @Environment(\.colorScheme) var colorScheme
    
    public init(sections: [SectionItem]?, scrollViewBackground: Color? = Color(hex: "#F5F5F5"), stretchableBackground: (Bool?, String?)? = (false, nil), contentHeight: Binding<CGFloat?>? = nil, contentPadding: CGFloat = .zero, headerMinHeight: CGFloat? = 22, returnContentHeight: Binding<Bool?>? = nil, cHeight: @escaping (CGFloat) -> Void) {
        self.sections = sections
        self.stretchableBackground = stretchableBackground
        self.scrollViewBackground = scrollViewBackground
        self.headerMinHeight = headerMinHeight
        self._contentHeight = contentHeight ?? .constant(0)
        self.cHeight = cHeight
        self.contentPadding = contentPadding
        self._returnContentHeight = returnContentHeight ?? .constant(false)
    }
    
    public var body: some View {
        ScrollView{
            if let stretchable = stretchableBackground, stretchable.1 != nil {
                ZStack{
                    if let stretchable = stretchableBackground {
                        StretchableBackground(bgImage: stretchable.1 ?? "")
                    }
                    VStack(alignment: .leading, spacing: self.headerMinHeight) {
                        if let sectionItems = sections {
                            ForEach(sectionItems) { section in
                                sectionView(section: section)
                            }
                        }
                    }
                }
                .padding(contentPadding)
            }else{
                VStack(alignment: .leading, spacing: self.headerMinHeight) {
                    if let sectionItems = sections {
                        ForEach(sectionItems) { section in
                            sectionView(section: section)
                        }
                        .modifier(GenericListViewBackgroundModifier(contentHeight: $contentHeight,
                                                                    returnContentHeight: $returnContentHeight,
                                                                    cHeight: { height in
                            cHeight(height)
                        }))
                    }
                }
                .padding(contentPadding)
                
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    @ViewBuilder
    private func sectionView(section: SectionItem) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            if let header = section.title {
                Text(header)
                    .background(section.sectionStyle?.sectionStyle?.headerBackgroundColor)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(section.sectionStyle?.sectionStyle?.headerTextAlignment ?? .leading)
                //.frame(maxWidth: .infinity)
                    .font(section.sectionStyle?.sectionStyle?.headerFont ?? .headline)
                    .foregroundColor(section.sectionStyle?.sectionStyle?.headerColor ?? .primary)
                    .padding(section.sectionStyle?.sectionStyle?.headerPadding?.toEdgeInsets() ?? .init())
                    .padding(.top, 30)
                    .padding([.leading, .trailing])
            } else {
                Spacer()
                    .frame(height: 0)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                sectionContent(section: section)
            }
            .padding([.leading, .trailing])
            .padding([.vertical], section.verticalSpacing)
            .background(
                section.isGrouped
                ? AnyView(RoundedRectangle(cornerRadius: 10).fill(section.backgroundColor ?? Color.white).shadow(radius: 1))
                : AnyView(Color.clear)
            )
        }
    }
    
    @ViewBuilder
    private func sectionContent(section: SectionItem) -> some View {
        switch section.items {
        case .horizontal(let items):
            HorizontalSectionView(items: items,
                                  centerAlign: section.centerAlignHorizontal ?? false,
                                  canMagnify: section.canMagnify ?? false,
                                  canHighlight: section.canHelight ?? false,
                                  selectedItem: section.selectedItem,
                                  action: section.action)
            .background(section .backgroundColor ?? section.sectionStyle?.sectionStyle?.backgroundColor)
            
        case .vertical(let items):
            VerticalSectionView(items: items,
                                action: section.action)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(section.backgroundColor ?? section.sectionStyle?.sectionStyle?.backgroundColor)
            
        case .flow(let items):
            FlowLayoutSectionView(items: items,
                                  rowStyle: section.sectionStyle?.rowStyle,
                                  highlightStyle: section.sectionStyle?.highlightStyle ?? HighlightStyle(),
                                  action: section.flowAction, bg:section.backgroundColor ?? .white,
                                  enableMultiSelect: section.enableMultiSelect)
            .background(section.backgroundColor ?? section.sectionStyle?.sectionStyle?.backgroundColor)
            
        case .expandableTextView(let viewModel):
            ExpandableTextField(viewModel: viewModel)
                .frame(minHeight: viewModel.dynamicHeight, maxHeight: .infinity)
                .background(section.backgroundColor ?? section.sectionStyle?.sectionStyle?.backgroundColor)
            //.padding([.leading, .trailing])
            
        case .staticHView(let items):
            StaticHView(items: items,
                        centerAlign: section.centerAlignHorizontal ?? false,
                        highlightStyle: section.sectionStyle?.highlightStyle ?? HighlightStyle(),
                        action: section.action,
                        selectedItem: section.selectedItem)
            .background(section.backgroundColor ?? section.sectionStyle?.sectionStyle?.backgroundColor)
            
        case .singleView(let item):
            StaticButtonView(items: item, centerAlign: section.centerAlignHorizontal ?? false, action: section.action)
        case .textField(let viewModel):
            CustomTextFieldView(viewModel: viewModel)
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct GenericListViewBackgroundModifier: ViewModifier {
    @Binding var contentHeight: CGFloat?
    @Binding var returnContentHeight: Bool?
    public var cHeight: (CGFloat) -> Void
    
    @ViewBuilder
    func body(content: Content) -> some View {
        content
            .ifTrue(returnContentHeight ?? false, apply: { content in
                content
                    .background(GeometryReader { proxy in
                        Color.clear.task {
                            DispatchQueue.main.async {
                                if var cH = contentHeight{
                                    cH += proxy.size.height
                                    contentHeight = cH
                                    cHeight(cH)
                                }
                            }
                        }
                        .preference(key: HeightPreferenceKey.self, value: proxy.size.height)
                    })
            })
    }
}

public struct HeightPreferenceKey: PreferenceKey {
    public static var defaultValue: CGFloat = .zero
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
