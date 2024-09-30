import SwiftUI
import Combine

public class ExpandableTextViewModel: ObservableObject {
    var currentColorScheme: ColorScheme
    @Published var text: String {
        didSet {
            updateBorderColor()
        }
    }
    @Published var placeholder: String
    @Published var dynamicHeight: CGFloat = 100 // Start with min height
    let highlightStyle:HighlightStyle
    let action: ((String) -> Void)?
    
    public init(colorScheme: ColorScheme, text: String, placeholder: String, highlightStyle:HighlightStyle, action: ((String) -> Void)? = nil) {
        self.currentColorScheme = colorScheme
        self.text = text
        self.placeholder = placeholder
        self.highlightStyle = highlightStyle
        self.action = action
        
        updateBorderColor()
    }

    @Published var borderColor: Color = Color(hex: "#000000", alphaPercentage: 12)

    private func updateBorderColor() {
        borderColor = text.isEmpty ? ((currentColorScheme == .dark ? Color(hex: "#FFFFFF", alphaPercentage: 20) : Color(hex: "#000000", alphaPercentage: 12)))
        : highlightStyle.border ?? Color(hex: "#000000", alphaPercentage: 12)
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
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .padding(.leading, 10)   // Align with TextEditor padding
                        .padding(.top, 12)      // Align with TextEditor top padding
                }
                TextEditor(text: $viewModel.text)
                    .modifier(CompatibleTextCaseModifier())
                    .modifier(CompatibleOnChnageModifier(viewModel: viewModel))
                    .font(.system(size: 14))
                    .focused($isFocused)
                    .frame(minHeight: 100, maxHeight: min(viewModel.dynamicHeight, 100))
                    .padding(4) // Padding to match placeholder alignment
                    .background(Color.clear) // Set background to clear
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(UIColor(viewModel.borderColor)), lineWidth: 1)
                    )
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
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14)]
        let boundingRect = NSString(string: text).boundingRect(
            with: size,
            options: .usesLineFragmentOrigin,
            attributes: attributes,
            context: nil
        )
        return max(100, boundingRect.height + 40) // 40 for padding
    }
}

struct CompatibleTextCaseModifier: ViewModifier {

    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}

struct CompatibleOnChnageModifier: ViewModifier {
    @ObservedObject var viewModel:ExpandableTextViewModel
    @ViewBuilder
    func body(content: Content) -> some View {
        
        if #available(iOS 17.0, *) {
            content
                .onChange(of: viewModel.text, { _, _ in
                    viewModel.dynamicHeight = calculateHeight(for: viewModel.text)
                    viewModel.action?(viewModel.text)
                })
        } else {
            content
                .onChange(of: viewModel.text, perform: { _ in
                    viewModel.dynamicHeight = calculateHeight(for: viewModel.text)
                    viewModel.action?(viewModel.text)
                })
        }
    }
        
    private func calculateHeight(for text: String) -> CGFloat {
        let size = CGSize(width: UIScreen.main.bounds.width - 68, height: .infinity)
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14)]
        let boundingRect = NSString(string: text).boundingRect(
            with: size,
            options: .usesLineFragmentOrigin,
            attributes: attributes,
            context: nil
        )
        return max(100, boundingRect.height + 40) // 40 for padding
    }
}
