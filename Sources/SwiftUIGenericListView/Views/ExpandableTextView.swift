import SwiftUI
import UIKit

public class ExpandableTextViewModel: ObservableObject {
    @Published var text: String {
        didSet {
            updateBorderColor()
        }
    }
    @Published var placeholder: String
    @Published var dynamicHeight: CGFloat = 100 // Start with min height
    let action: ((String) -> Void)?

    public init(text: String, placeholder: String, action: ((String) -> Void)? = nil) {
        self.text = text
        self.placeholder = placeholder
        self.action = action
        updateBorderColor()
    }

    @Published var borderColor: Color = .gray

    private func updateBorderColor() {
        borderColor = text.isEmpty ? .gray : Color(hex: "089949")
    }
}
struct ExpandableTextField: View {
    @ObservedObject var viewModel: ExpandableTextViewModel
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                if viewModel.text.isEmpty {
                    Text(viewModel.placeholder)
                        .foregroundColor(.gray)
                        .padding(.leading, 4)   // Align with TextEditor padding
                        .padding(.top, 12)      // Align with TextEditor top padding
                }
                TextEditor(text: $viewModel.text)
                    .focused($isFocused)
                    .frame(minHeight: 100, maxHeight: min(viewModel.dynamicHeight, 100))
                    .padding(4) // Padding to match placeholder alignment
                    .background(Color.clear) // Set background to clear
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(UIColor(viewModel.borderColor)), lineWidth: 2)
                    )
                    .onChange(of: viewModel.text) { _ in
                        viewModel.dynamicHeight = calculateHeight(for: viewModel.text)
                        viewModel.action?(viewModel.text)
                    }
                    .onAppear {
                        viewModel.dynamicHeight = calculateHeight(for: viewModel.text)
                    }
            }
        }
        .onTapGesture {
            isFocused = false
        }
    }

    private func calculateHeight(for text: String) -> CGFloat {
        let size = CGSize(width: UIScreen.main.bounds.width - 68, height: .infinity)
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 17)]
        let boundingRect = NSString(string: text).boundingRect(
            with: size,
            options: .usesLineFragmentOrigin,
            attributes: attributes,
            context: nil
        )
        return max(100, boundingRect.height + 40) // 40 for padding
    }
}
