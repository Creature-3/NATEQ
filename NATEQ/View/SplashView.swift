//
//  SplashView.swift
//  NATEQ
//
//  Created by Rahaf Alhammadi on 22/06/1447 AH.
//

import SwiftUI

struct SplashView: View {

    @State private var showCircle = false
    @State private var circleDropped = false
    @State private var circleExpanded = false
    @State private var showTitle = false
    @State private var goNext = false

    private let themeColor = Color(hex: "#B0E4DD")

    var body: some View {
        GeometryReader { geo in
            let centerX = geo.size.width / 2
            let centerY = geo.size.height / 2

            ZStack {

                // خلفية: تبدأ أبيض ثم تصير لون التطبيق بعد التمدد
                (circleExpanded ? themeColor : Color.white)
                    .ignoresSafeArea()
                    .animation(.easeInOut(duration: 0.9), value: circleExpanded)

                // الدائرة
                Circle()
                    .fill(themeColor)
                    .frame(
                        width: circleExpanded ? max(geo.size.width, geo.size.height) * 3 : (showCircle ? 26 : 0),
                        height: circleExpanded ? max(geo.size.width, geo.size.height) * 3 : (showCircle ? 26 : 0)
                    )
                    .position(x: centerX, y: circleDropped ? centerY : -80)
                    .opacity(showCircle ? 1 : 0)
                    // نزول أهدى
                    .animation(.spring(response: 0.85, dampingFraction: 0.80), value: circleDropped)
                    // تمدد أبطأ
                    .animation(.easeInOut(duration: 1.15), value: circleExpanded)

                // النص يظهر بعد ما يغطي اللون الشاشة
                Text("نُطق")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.black.opacity(0.85))
                    .opacity(showTitle ? 1 : 0)
                    .scaleEffect(showTitle ? 1 : 0.92)
                    .animation(.easeOut(duration: 0.55), value: showTitle)

                // الانتقال للصفحة التالية
                if goNext {
                    HomeView()
                        .transition(.opacity)
                }
            }
            .onAppear {
                runSequence()
            }
        }
    }

    private func runSequence() {
        // 1) ظهور الدائرة (أطول)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            showCircle = true
        }

        // 2) نزولها للوسط (أطول)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
            circleDropped = true
        }

        // 3) تمدد يغطي الشاشة (أهدى)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.65) {
            circleExpanded = true
        }

        // 4) ظهور الكلمة
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.55) {
            showTitle = true
        }

        // 5) الانتقال للصفحة التالية (خلي وقت أطول عشان تستمتعين)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.70) {
            withAnimation(.easeInOut(duration: 0.35)) {
                goNext = true
            }
        }
    }
}

#Preview {
    SplashView()
}
