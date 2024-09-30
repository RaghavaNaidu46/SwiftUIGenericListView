//
//  CustomHost.swift
//  ZohoAssist
//
//  Created by Raghava Dokala on 09/09/24.
//  Copyright © 2024 jambav. All rights reserved.
//

import SwiftUI
import UIKit

public class SheetDismisserProtocol: ObservableObject {
    public weak var host: UIHostingController<AnyView>? = nil

    // Public initializer
    public init(host: UIHostingController<AnyView>? = nil) {
        self.host = host
    }

    public func dismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.host?.view.alpha = 0
        }) { _ in
            self.host?.willMove(toParent: nil)
            self.host?.view.removeFromSuperview()
            self.host?.removeFromParent()
        }
    }
}
