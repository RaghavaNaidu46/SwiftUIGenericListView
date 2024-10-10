//
//  ListItem.swift
//
//
//  Created by Raghava Dokala on 03/08/24.
//

import SwiftUI

public enum ListItem {
    case horizontal([AnyView])
    case vertical([AnyView])
    case flow([AnyView])
    case expandableTextView(ExpandableTextViewModel)
    case textField(CustomTextFieldViewModel)
    case staticHView([AnyView])
    case singleView(AnyView)
}
