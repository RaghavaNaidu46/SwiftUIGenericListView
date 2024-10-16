//
//  CustomTextField.swift
//  Pods
//
//  Created by Raghava Dokala on 09/10/24.
//

import SwiftUI

public struct CustomTextFieldView: View {
    @ObservedObject var viewModel: CustomTextFieldViewModel

    public var body: some View {
        VStack(alignment: .leading) {
            TextField(viewModel.placeHolder, text: $viewModel.text)
                .modifier(viewModel.modifier)
                .onChange(of: viewModel.text) { newValue in
                    // This will call the action passing the current name as it changes
                    viewModel.action?(newValue)
                }
        }
        .padding(0)
    }
}

public class CustomTextFieldViewModel: ObservableObject, Identifiable {
    @Published var placeHolder: String
    @Published var text: String
    let action: ((String) -> Void)?
    @Published var modifier: CustomTextFieldModifier
    public init(text: String, placeHolder: String, modifier: CustomTextFieldModifier? = nil, action: ((String) -> Void)? = nil) {
        self.text = text
        self.placeHolder = placeHolder
        self.action = action
        self.modifier = modifier ?? CustomTextFieldModifier()
    }
}


public struct CustomTextFieldModifier: ViewModifier {
    public var _font: Font
    public var _backgroundColor: Color
    public var _foregroundColor: Color
    public var _borderColor: Color
    public var _cornerRadius: CGFloat
    public var _padding: CGFloat
    public var _disableAutocorrection: Bool
    public var _autocapitalization: UITextAutocapitalizationType
    public var _keyboardType: UIKeyboardType
    public var _borderStyle: RoundedTextFieldStyle

    // Public initializer
    public init(font: Font = Font.system(size: 14),
                backgroundColor: Color = .white,
                foregroundColor: Color = .black,
                borderColor: Color = .gray,
                cornerRadius: CGFloat = 8,
                padding: CGFloat = 10,
                disableAutocorrection: Bool = true,
                autocapitalization: UITextAutocapitalizationType = .none,
                keyboardType: UIKeyboardType = .default,
                borderStyle: RoundedTextFieldStyle? = nil){
        self._font = font
        self._backgroundColor = backgroundColor
        self._foregroundColor = foregroundColor
        self._borderColor = borderColor
        self._cornerRadius = cornerRadius
        self._padding = padding
        self._disableAutocorrection = disableAutocorrection
        self._autocapitalization = autocapitalization
        self._keyboardType = keyboardType
        self._borderStyle = borderStyle ?? RoundedTextFieldStyle()
    }

    public func body(content: Content) -> some View {
        content
            .font(_font)
            .keyboardType(_keyboardType)
            //.textFieldStyle(_borderStyle)
            .autocapitalization(_autocapitalization)
            .disableAutocorrection(_disableAutocorrection)
            .padding(_padding)
            .background(_backgroundColor)
            .foregroundColor(_foregroundColor)
            .cornerRadius(_cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: _cornerRadius)
                    .stroke(_borderColor, lineWidth: 1)
            )
    }
}

public struct RoundedTextFieldStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical)
            .padding(.horizontal, 24)
            .background(
                Color(UIColor.systemGray6)
            )
            .clipShape(Capsule(style: .continuous))
    }
}
