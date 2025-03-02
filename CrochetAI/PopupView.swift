//
//  PopupView.swift
//  CrochetAI
//
//  Created by Sara Ali Alahmadi on 03/09/1446 AH.
//

import SwiftUI

struct PopupView: View {
    @Binding var showPopup: Bool
    var body: some View {
        ZStack {
                    if showPopup {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                showPopup = false
                            }
                        
                        VStack(spacing: 10) {
                            Text("Generate Pattern")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.top, 20)
                                .multilineTextAlignment(.leading)
                            Text("text text text text text")
                                .font(.body)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 20)
                            
                            Image("your_image_name") // استبدلها بالصورة الخاصة بك
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .cornerRadius(10)
                                .padding()
                            
                            HStack {
                                Button(action: {
                                    showPopup = false
                                }) {
                                    Text("Cancel")
                                        .frame(height: 15)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.white)
                                        .foregroundColor(.black)
                                        .cornerRadius(10)
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                                }
                                
                                Button(action: {
                                    showPopup = false
                                }) {
                                    Text("Done")
                                        .frame(height: 15)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.pc)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                            .frame(height: 100)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                        }
                        .frame(width: 360)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .transition(.scale)
                        .zIndex(1)
                    }
                }
                .animation(.easeInOut, value: showPopup)
            }
        }

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView(showPopup: .constant(true))
    }
}
