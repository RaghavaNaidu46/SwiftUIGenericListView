//
//  FlowLayoutSectionView.swift
//
//
//  Created by Raghava Dokala on 08/08/24.
//

import SwiftUI

public struct FlowLayoutSectionView: View {
    let items: [AnyView]
    let rowStyle:SectionRowStyle?
    let highlightStyle:HighlightStyle
    let action: ((Set<Int>) -> Void)?
    let bg : Color
    @State private var totalHeight = CGFloat.zero
    @State private var selectedIndices = Set<Int>()  // State to track selected items
    
    public var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .background(bg)
        .frame(height: totalHeight)
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(0..<self.items.count, id: \.self) { index in
                self.items[index]
                    .background(selectedIndices.contains(index) ? highlightStyle.background : Color.clear)  // Light green background for selected items
                    .foregroundColor((selectedIndices.contains(index) ? highlightStyle.textColor : Color.black))
                    .cornerRadius(13)
                    .overlay(RoundedRectangle(cornerRadius: 13)
                        .stroke((selectedIndices.contains(index) ? highlightStyle.border : Color.gray) ?? Color.clear,
                                lineWidth: rowStyle?.rowBorderWidth ?? 1))
                    .clipShape(RoundedRectangle(cornerRadius: 13))
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading) { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        
                        let result = width
                        if index == self.items.count - 1 {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    }
                    .alignmentGuide(.top) { d in
                        let result = height
                        if index == self.items.count - 1 {
                            height = 0
                        }
                        return result
                    }
                    .onTapGesture {
                        if selectedIndices.contains(index) {
                            selectedIndices.remove(index)  // Deselect if already selected
                        } else {
                            selectedIndices.insert(index)  // Select if not already selected
                        }
                        action?(selectedIndices)
                    }
            }
        }
        .background(viewHeightReader($totalHeight))
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        GeometryReader { geometry -> Color in
            DispatchQueue.main.async {
                binding.wrappedValue = geometry.size.height
            }
            return Color.clear
        }
    }
}
