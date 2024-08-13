//
//  StaticHView.swift
//
//
//  Created by Raghava Dokala on 12/08/24.
//

import SwiftUI

struct StaticHView: View {
    let items: [AnyView]
    let action: ((Int) -> Void)?
    
    var body: some View {
        HStack{
            ForEach(0..<items.count, id: \.self) { index in
                items[index]
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture {
                        action?(index)
                    }
            }
        }
    }
}
