//
//  CenteringScrollView.swift
//  
//
//  Created by Raghava Dokala on 06/08/24.
//
import SwiftUI

public struct CenteringScrollView<Content: View>: View {
    let content: Content
    let shouldCenter: Bool
    
    @State private var contentHeight: CGFloat = .zero
    @State private var contentWidth: CGFloat = .zero
    
    public init(shouldCenter: Bool, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.shouldCenter = shouldCenter
    }
    
    public var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        if shouldCenter {
                            Spacer(minLength: max(0, (geometry.size.width - contentWidth) / 2))
                        }
                        content
                            .background(GeometryReader { contentGeometry in
                                Color.clear
                                    .preference(key: ScrollOffsetPreferenceKey.self, value: contentGeometry.size.height)
                                    .onAppear {
                                        self.contentWidth = contentGeometry.size.width
                                    }
                                    .onChange(of: contentGeometry.size.width) { newValue in
                                        let oldValue = self.contentWidth
                                        self.contentWidth = newValue

                                        // If you need to do something based on the old and new value
                                        if oldValue != newValue {
                                            // Perform your action here
                                        }
                                    }

                            })
                        if shouldCenter {
                            Spacer(minLength: max(0, (geometry.size.width - contentWidth) / 2))
                        }
                    }
                }
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    self.contentHeight = value
                }
            }
            .frame(height: contentHeight)
        }
    }
}
