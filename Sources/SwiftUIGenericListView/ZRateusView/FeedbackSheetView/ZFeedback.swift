//
//  ZFeedback.swift
//  Feedback
//
//  Created by Raghava Dokala on 03/09/24.
//

import SwiftUI

public struct ZFeedback: View {
    @State public var showBottomSheet = false
    @State public var contentHeight: CGFloat? = .zero
    @State public var showLogsView = false
    @State public var enableLogs: Bool = false
    @State public var returnContentHeight: Bool? = true
    public var dismiss: (() -> Void)?
    @State public var delegate: SheetDismisserProtocol
    public var dataProvider: RateSessionDataProvider

    // Public initializer
    public init(showBottomSheet: Bool = false, contentHeight: CGFloat? = .zero, showLogsView: Bool = false, enableLogs: Bool = false, returnContentHeight: Bool? = true, dismiss: (() -> Void)? = nil, delegate: SheetDismisserProtocol, dataProvider: RateSessionDataProvider) {
        self.showBottomSheet = showBottomSheet
        self.contentHeight = contentHeight
        self.showLogsView = showLogsView
        self.enableLogs = enableLogs
        self.returnContentHeight = returnContentHeight
        self.dismiss = dismiss
        self.delegate = delegate
        self.dataProvider = dataProvider
    }

    public var body: some View {
        EmptyView()
            .background(Color.clear)
            .onAppear(perform: {
                returnContentHeight = true
                showBottomSheet = true // Trigger the bottom sheet to show with animation
            })
            .modifier(CompatibleOnChange(enableLogs: $enableLogs, isPresented: $showBottomSheet, contentHeight: $contentHeight))
            .modifier(BottomSheetModifier(isPresented: $showBottomSheet, contentHeight: $contentHeight, enableLogs: enableLogs, shouldGetContentHeight: $returnContentHeight, delegate: delegate, dataProvider: dataProvider))
    }
}

public struct BottomSheetModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var contentHeight: CGFloat?
    @State var enableLogs: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @Binding var shouldGetContentHeight: Bool?
    @State private var showThanksView = false
    @State private var didCancel = true
    @ObservedObject var delegate: SheetDismisserProtocol
    public var dataProvider: RateSessionDataProvider
    
    @ViewBuilder
    public func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented, onDismiss: handleSheetDismissal) {
                RateSession(dataProvider: dataProvider, sendAction: { obj in
                    print(obj) // Action to handle when data is sent
                    isPresented = false
                    didCancel = false
                    self.dataProvider.sendObject(object: obj)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showThanksView = true
                    }
                },returnContentHeight: $shouldGetContentHeight, cHeight: { newHeight in
                    print(newHeight)
                    withAnimation {
                        contentHeight = newHeight // Callback to update the content height
                    }
                    
                    if let cHeight = contentHeight, (UIScreen.screenHeight/2) < cHeight {
                        shouldGetContentHeight = false
                    }
                })
                .modifier(CompatiblePresentationDetents(contentHeight: $contentHeight, isPresented: $isPresented))
                .onPreferenceChange(HeightPreferenceKey.self) { value in
                    contentHeight = value // Update the content height state
                }
            }
            .sheet(isPresented: $showThanksView, onDismiss: {
                delegate.dismiss()
            }, content: {
                FeedbackSuccessView(message: dataProvider.successFieldValues.title, imageName: dataProvider.successFieldValues.imageName)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .modifier(CompatiblePresentationDetents(contentHeight: .constant(60), isPresented: $showThanksView))
                    .background(GeometryReader { geometry in
                        Color.clear.preference(key: HeightPreferenceKey.self, value: geometry.size.height)
                    })
                    .background(Color(hex: "#EAFAF1"))
                    .ignoresSafeArea()
            })
    }
    private func handleSheetDismissal() {
        if didCancel {
            delegate.dismiss()
        }
        // Reset or handle other cleanup
    }
}

public struct CompatiblePresentationDetents: ViewModifier {
    @Binding var contentHeight: CGFloat?
    @Binding var isPresented: Bool
    
    @ViewBuilder
    public func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .presentationDetents([.height(contentHeight ?? 0)])
                .presentationDragIndicator(.visible)
        } else {
            content
        }
    }
}

public struct CompatibleOnChange: ViewModifier {
    @Binding var enableLogs: Bool
    @Binding var isPresented: Bool
    @Binding var contentHeight: CGFloat?
    
    @ViewBuilder
    public func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content
                .onChange(of: [enableLogs, isPresented], initial: false) { oldValue, newValue in
                    contentHeight = isPresented ? contentHeight : 0
                }
        } else {
            content
                .onChange(of: [enableLogs, isPresented]) { newValue in
                }
        }
    }
}
