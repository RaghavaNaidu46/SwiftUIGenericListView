//
//  FlowView.swift
//  TestProduct
//
//  Created by Raghava Dokala on 29/08/24.
//

import SwiftUI

struct FlowView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let title: String
    
    var body: some View {
        VStack{
            Text(title)
                .font(.system(size: 12))
                .padding(12)
                .frame(height: 26)
                .foregroundColor((colorScheme == .dark ? Color.white : Color.black))
        }
    }
}
