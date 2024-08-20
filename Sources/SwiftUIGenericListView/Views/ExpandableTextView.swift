import SwiftUI
import UIKit
import SwiftUI
import UIKit

public class ExpandableTextViewModel: ObservableObject {
    @Published var text: String
    @Published var placeHolder: String
    @Published var dynamicHeight: CGFloat
    let action: ((String) -> Void)?

    public init(text: String, placeHolder: String, dynamicHeight: CGFloat = 0, action: ((String) -> Void)? = nil) {
        self.text = text
        self.placeHolder = placeHolder
        self.dynamicHeight = dynamicHeight
        self.action = action
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
        textView.textContainerInset = .zero // Remove inset padding
        textView.textContainer.lineFragmentPadding = 0 // Remove padding for the text container
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
            
            // Adjust height on text change
            DispatchQueue.main.async {
                let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
                if self.viewModel.dynamicHeight != size.height {
                    self.viewModel.dynamicHeight = size.height
                }
            }
        }
    }
}
