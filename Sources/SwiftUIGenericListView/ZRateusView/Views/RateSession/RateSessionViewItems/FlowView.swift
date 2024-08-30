//
//  FlowView.swift
//  TestProduct
//
//  Created by Raghava Dokala on 29/08/24.
//

import SwiftUI

struct FlowView: View {
    let title: String
    
    var body: some View {
        VStack{
            Text(title)
                .font(.system(size: 12))
                .padding()
                .frame(height: 26)
        }
    }
}

struct TitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity, idealHeight: 40) // Makes the text frame take up the full width of the screen
            .multilineTextAlignment(.center) // Centers the text within the frame
            .font(.title)
            .clipped()
            .foregroundColor(.black) // Sets the text color to white
    }
}
