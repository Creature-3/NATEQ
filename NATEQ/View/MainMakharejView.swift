//
//  MainMakharejView.swift
//  pj
//
//  Created by Jamilah Jaber Hazazi on 21/06/1447 AH.
//

import SwiftUI

struct MainMakharejView: View {

    var body: some View {
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
                    Text("مخارج الحروف")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    NavigationLink(destination:
                        LettersView(title: "مخرج الحلق", category: .halq)
                    ) {
                        menuButton("الحلق")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                    }

                    NavigationLink(destination:
                        LettersView(title: "مخرج الشفتين", category: .shafateen)
                    ) {
                        menuButton("الشفتين")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }

                    NavigationLink(destination:
                        LettersView(title: "مخرج اللسان", category: .lisan)
                    ) {
                        menuButton("اللسان")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                }
                .padding()
            }
       }

    func menuButton(_ text: String) -> some View {
        Text(text)
            .font(.title2)
            .foregroundColor(.black)
            .frame(width: 266, height: 106)
            .background(Color(hex: "#CCDCDA"))
            .cornerRadius(33)
    }
}

#Preview {
    MainMakharejView()
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >>  8) & 0xFF) / 255
        let b = Double((rgb >>  0) & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}
