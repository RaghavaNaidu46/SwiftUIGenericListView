//
//  FeedbackSuccessView.swift
//  ZohoAssist
//
//  Created by Raghava Dokala on 09/09/24.
//  Copyright © 2024 jambav. All rights reserved.
//

import SwiftUI

public struct FeedbackSuccessView: View {
    let message:String
    let imageName:String
    public var body: some View{
        HStack{
            Image(imageName)
            Text(message)
        }
        .background(Color(hex: "#EAFAF1"))
    }
}
