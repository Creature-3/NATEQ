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

                    // ✅ زر الحروف (ينقل لصفحة كل الحروف)
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

    // شكل الزر
    func menuButtonStyle(_ text: String) -> some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .frame(width: 266, height: 106)
            .background(Color(hex: "#CCDCDA"))
            .cornerRadius(33)
    }
}
#Preview {
    HomeView()
}
