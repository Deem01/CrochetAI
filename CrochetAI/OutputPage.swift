//
//  OutputPage.swift
//  CrochetAI
//
//  Created by Sara Ali Alahmadi on 04/09/1446 AH.
//

import SwiftUI

struct OutputPage: View {
    @State private var isBookmarked = false
    @State private var imageOutput: Image? = nil // لحفظ الصورة المحولة
    @State private var textOutput: String = "شرح طريقة العمل" // النص الناتج
    
    var body: some View {
        VStack {
            HStack {
                Image("crochet icon")
                    .padding(.leading, 20)
                Spacer()
            }
            Button(action: {
                isBookmarked.toggle() // تغيير الحالة عند النقر
            }) {
                Spacer()
                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    .foregroundColor(isBookmarked ? .yellow : .gray)
                    .font(.title)
                    .padding(.trailing, 50)
            }
            
            Spacer()
            
            // عرض مخرجات ContentView (الصورة المحولة)
            VStack {
                if let imageOutput = imageOutput {
                    imageOutput
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 2))
                } else {
                    Text("لا توجد صورة محولة")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 2))
                }
                
                Text(textOutput) // عرض النص التوضيحي
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 2))
            }
            
            // عرض مخرجات GenerateIdea (الصورة المحولة وفكرة مكتوبة)
            VStack {
                if let imageOutput = imageOutput {
                    Text("الشرح: طريقة العمل")
                        .padding(.top)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 2))
                    
                    imageOutput
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 2))
                    
                    Text("شرح طريقة العمل هنا...") // يمكن تحديث هذا النص بناءً على النتيجة
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 2))
                }
            }
            
            Spacer()
            
            VStack {
                HStack {
                    Button(action: {
                        // إعادة توليد الصورة أو الفكرة
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.pc)
                                .frame(width: 50, height: 50)
                            Image(systemName: "goforward")
                                .foregroundColor(.white)
                                .font(.title)
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    OutputPage()
}
