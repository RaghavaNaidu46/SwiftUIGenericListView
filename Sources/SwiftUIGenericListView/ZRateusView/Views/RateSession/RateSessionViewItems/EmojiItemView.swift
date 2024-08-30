//
//  SwiftUIView.swift
//  ZFeedback
//
//  Created by Raghava Dokala on 29/08/24.
//

import SwiftUI

struct EmojiItemView: View {
    let imgName: String
    let title: String
    
    var body: some View {
        VStack() {
            Image(imgName)
                .aspectRatio(contentMode: .fit)
            Text(title)
                .font(.system(size: 12))
                .padding([.leading, .trailing], 10)
                .foregroundColor(.secondary)
        }
        .frame(width: 65, height: 65)
        .padding()
    }
}
