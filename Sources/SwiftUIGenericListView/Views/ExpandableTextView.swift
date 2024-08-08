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

    public init(text: String, dynamicHeight: CGFloat) {
        self.text = text
        self.dynamicHeight = dynamicHeight
    }
}

public struct ExpandableTextView: UIViewRepresentable {
    @ObservedObject var viewModel: ExpandableTextViewModel

    public init(viewModel: ExpandableTextViewModel) {
        self.viewModel = viewModel
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
        uiView.text = viewModel.text
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
            self.viewModel.text = textView.text
        }
    }
}
