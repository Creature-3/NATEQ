//
//  HomeView.swift
//  NATEQ
//
//  Created by Rahaf Alhammadi on 22/06/1447 AH.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color.white,
                        Color(hex: "#B0E4DD")
                    ]),
                    center: .topLeading,
                    startRadius: 100,
                    endRadius: 900
                )
                .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    
                    Spacer()
                    
                    Text("اختر طريقة التعلم التي تناسبك")
                        .font(.system(size: 32, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    
                    // ✅ زر الحروف
                    NavigationLink {
                        LettersView(
                            title: "اختر الحرف",
                            category: LetterCategory.all
                        )
                    } label: {
                        menuButtonStyle("الحروف")
                        
                    }
                    
                    // ✅ زر مخارج الحروف
                    NavigationLink {
                        MainMakharejView()
                    } label: {
                        menuButtonStyle("مخارج الحروف")
                    }
                    
                    Spacer()
                }
            }
        }
    }
    
    // ✅ زر بشكل عضوي + Glass effect
    func menuButtonStyle(_ text: String) -> some View {
            Text(text)
                .font(.system(size: 28, weight: .medium)) 
                .foregroundColor(.black)
                .frame(width: 266, height: 96)
                .background(
                    Capsule()
                        .fill(Color.white.opacity(0.42))
                        .background(
                            Capsule()
                                .fill(Color(hex: "#B0E4DD"))
                                .blur(radius: 18)
                        )
                )
        }
}
#Preview {
    HomeView()
}
