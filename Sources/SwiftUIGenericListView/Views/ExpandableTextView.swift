//
//  ExpandableTextView.swift
//  
//
//  Created by Raghava Dokala on 08/08/24.
//

import Foundation
import SwiftUI
import UIKit


public class ExpandableTextViewModel: ObservableObject {
    @Published var text: String
    @Published var dynamicHeight: CGFloat
    let action: ((String) -> Void)?
    
    public init(text: String, dynamicHeight: CGFloat, action: ((String) -> Void)?) {
        self.text = text
        self.dynamicHeight = dynamicHeight
        self.action = action
    }
}

public struct ExpandableTextView: UIViewRepresentable {
    let action: ((String) -> Void)?
    
    @ObservedObject var viewModel: ExpandableTextViewModel

    public init(viewModel: ExpandableTextViewModel, action: ((String) -> Void)?) {
        self.viewModel = viewModel
        self.action = action
    }

    public func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.backgroundColor = .clear
        return textView
    }

    public func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != viewModel.text {
            uiView.text = viewModel.text
        }
        
        DispatchQueue.main.async {
            let size = uiView.sizeThatFits(CGSize(width: uiView.frame.width, height: CGFloat.greatestFiniteMagnitude))
            if self.viewModel.dynamicHeight != size.height {
                self.viewModel.dynamicHeight = size.height
            }
        }
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(viewModel: viewModel)
    }

    public class Coordinator: NSObject, UITextViewDelegate {
        var viewModel: ExpandableTextViewModel

        init(viewModel: ExpandableTextViewModel) {
            self.viewModel = viewModel
        }

        public func textViewDidChange(_ textView: UITextView) {
            let selectedRange = textView.selectedRange
            self.viewModel.text = textView.text
            textView.selectedRange = selectedRange
            viewModel.action?(textView.text)
        }
    }
}
