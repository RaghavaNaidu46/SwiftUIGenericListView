//
//  SendItemView.swift
//  TestProduct
//
//  Created by Raghava Dokala on 29/08/24.
//

import SwiftUI
struct SendItemView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity, idealHeight: 40) // Makes the text frame take up the full width of the screen
            .multilineTextAlignment(.center) // Centers the text within the frame
            .font(.system(size: 14))
            .clipped()
            .background(Color(hex: "089949")) // Sets the background color to green
            .foregroundColor(.white) // Sets the text color to white
    }
}
