//
//  SplashScreen.swift
//  CrochetAI
//
//  Created by Sara Ali Alahmadi on 29/08/1446 AH.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        VStack(spacing: 70){
            Image("splash image")
                .resizable()
                .frame(width: 280, height: 270)
            Text("Welcome!")
                .font(.title)
                .bold()
            VStack(spacing: 30){
                Text("Turn ideas & images into creative crochet patterns.")
                    .font(.caption)
                Text("Generate unique designs & innovative suggestions with AI.")
                    .font(.caption)
            }
        }
    }
}

#Preview {
    SplashScreen()
}
