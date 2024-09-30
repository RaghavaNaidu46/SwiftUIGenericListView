//
//  Binding+Util.swift
//  AssistRatingFeedbackKit
//
//  Created by Raghava Dokala on 16/09/24.
//

import SwiftUI

public extension Binding {
   public func didSet(execute: @escaping (Value) -> Void) -> Binding {
        return Binding(
            get: { self.wrappedValue },
            set: {
                self.wrappedValue = $0
                execute($0)
            }
        )
    }
}
