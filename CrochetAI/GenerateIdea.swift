//
//  GenerateIdea.swift
//  CrochetAI
//
//  Created by Sara Ali Alahmadi on 29/08/1446 AH.
//

import SwiftUI

struct GenerateIdea: View {
    @State private var selectedOption = 0
       @State private var showPreferences = false
       let options = ["Generate Idea", "Convert Image"]
       @State private var projectDescription = ""
       
       init() {
           // تغيير لون الزر المحدد عند النقر
           UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.pc

           // تغيير لون النص عند تحديده
           UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)

           // تغيير لون النص عندما لا يكون محددًا
           UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
       }
       
       var body: some View {
           VStack {
               Image("crochet icon")
               
               Picker("", selection: $selectedOption) {
                   ForEach(0..<options.count, id: \.self) { index in
                       Text(options[index]).tag(index)
                   }
               }
               .pickerStyle(SegmentedPickerStyle())
               .padding()

               ZStack {
                   VStack {
                       Text("Generate Idea")
                           .font(.title)
                       
                       TextField("Describe your dream crochet project...", text: $projectDescription)
                           .textFieldStyle(RoundedBorderTextFieldStyle())
                           .padding()
                       
                       Button("Generate Ideas") {
                           // Add action here
                       }
                       .frame(maxWidth: .infinity)
                       .padding()
                       .background(Color.pc)
                       .foregroundColor(.white)
                       .cornerRadius(10)
                     
                       Button(action: { showPreferences.toggle() }) {
                           HStack {
                               Image(systemName: "slider.horizontal.3")
                               Text("Show Preferences")
                           }
                           .frame(maxWidth: .infinity)
                           .padding()
                           .overlay(
                               RoundedRectangle(cornerRadius: 10)
                                   .stroke(Color.black, lineWidth: 1)
                           )
                       }

                       // Preferences Section
                       if showPreferences {
                           // PreferencesView()
                       }
                   }
                   .padding()
                   .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 2))
                   .padding()
               }
           }
                        }
                }
#Preview {
    GenerateIdea()
}
