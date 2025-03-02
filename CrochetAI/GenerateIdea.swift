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
               HStack{
                   Image("crochet icon")
                    .padding(.leading, 20)
                     Spacer()
               }

               Picker("", selection: $selectedOption) {
                   ForEach(0..<options.count, id: \.self) { index in
                       Text(options[index]).tag(index)
                   }
               }
               .pickerStyle(SegmentedPickerStyle())
               .padding()

               ZStack {
                   VStack {
                       HStack{
                           Text("Generate Idea")
                               .font(.title2)
                               .fontWeight(.semibold)
                           Spacer()
                       }
                       TextField("Describe your dream crochet project...", text: $projectDescription, axis: .vertical)
                           .lineLimit(5) // السماح بظهور عدة أسطر
                           .padding(.horizontal, 10) // مسافة من الجوانب
                           .padding(.top, 10) // دفع النص للأعلى ليبدأ من السطر الأول
                           .frame(height: 90, alignment: .top) // محاذاة المحتوى للأعلى
                           .background(Color.white) // خلفية بيضاء
                           .cornerRadius(8) // زوايا مستديرة
                           .overlay(
                               RoundedRectangle(cornerRadius: 8)
                                   .stroke(Color.gray.opacity(0.3), lineWidth: 1) // حدود خفيفة
                           )
                           .multilineTextAlignment(.leading) // محاذاة النص لليسار (أو لليمين حسب اللغة)
   
                       Button(action: {
                           // Add action here
                       }) {
                           Text("Generate Ideas")
                               .frame(maxWidth: .infinity)
                               .padding()
                               .frame(height: 40)
                               .background(Color.pc)
                               .foregroundColor(.white)
                               .cornerRadius(10)
                       }
                       .contentShape(Rectangle())
                    
                       Button(action: { showPreferences.toggle() }) {
                           HStack {
                               Image(systemName: "slider.horizontal.3")
                                   .foregroundColor(.black)
                               Text("Show Preferences")
                                   .foregroundColor(.black)
                               
                           }
                           .frame(maxWidth: .infinity)
                           .padding()
                           .frame(height: 40)
                           .overlay(
                               RoundedRectangle(cornerRadius: 10)
                                   .stroke(Color.black, lineWidth: 1)
                           )
                       }

                       // Preferences Section
                       PreferencesView()
                                       .opacity(showPreferences ? 1 : 0)
                                       .animation(.easeInOut, value: showPreferences)
                                       .fixedSize(horizontal: false, vertical: true)
                   }
                   .padding()
                   .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 2))
                   .padding()
               }
           }
           Spacer()
                        }
                }
#Preview {
    GenerateIdea()
}
import SwiftUI

struct PreferencesView: View {
    @State private var skillLevel = "Beginner"
    @State private var yarnWeight = "Medium (4)"
    @State private var projectSize = "Medium (4-12 hours)"
    @State private var patternFormat = "Both"
    
    @State private var expandedMenu: String? = nil
    
    let skillLevels = ["Beginner", "Intermediate", "Advanced"]
    let yarnWeights = ["Lace (0)", "Fingering (1)", "Sport (2)", "Medium (4)", "Bulky (5)"]
    let projectSizes = ["Small (0-4 hours)", "Medium (4-12 hours)", "Large (12+ hours)"]
    let patternFormats = ["Written Instructions", "Chart/Diagram", "Both"]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack{
                Image(systemName: "slider.horizontal.2.square")
                Text("Pattern Preferences")
                    .font(.headline)
                    .padding(.vertical, 20)
                  
            }
            PreferenceRow(title: "Skill Level", value: $skillLevel, options: skillLevels, expandedMenu: $expandedMenu)
            PreferenceRow(title: "Yarn Weight", value: $yarnWeight, options: yarnWeights, expandedMenu: $expandedMenu)
            PreferenceRow(title: "Project Size", value: $projectSize, options: projectSizes, expandedMenu: $expandedMenu)
            PreferenceRow(title: "Pattern Format", value: $patternFormat, options: patternFormats, expandedMenu: $expandedMenu)
        }
       // .padding()
    }
}
struct PreferenceRow: View {
    let title: String
    @Binding var value: String
    let options: [String]
    @Binding var expandedMenu: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .bold()
                .foregroundColor(.black)
            
            Button(action: {
                withAnimation {
                    expandedMenu = (expandedMenu == title) ? nil : title
                }
            }) {
                HStack {
                    Text(value)
                        .font(.body)
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: expandedMenu == title ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(height: 40)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 1)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            }

            if expandedMenu == title {
                VStack(spacing: 0) {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            value = option
                            withAnimation {
                                expandedMenu = nil
                            }
                        }) {
                            HStack {
                                Text(option)
                                    .font(.body)
                                    .foregroundColor(.black)
                                Spacer()
                                if value == option {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding()
                            .background(Color.white)
                        }
                        .buttonStyle(PlainButtonStyle())

                        Divider()
                    }
                }
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 1)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            }
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
//struct Preference: Identifiable {
//    let id = UUID()
//    let title: String
//    let options: [String]
//    var value: String
//}

