//
//  LettersView.swift
//  pj
//
//  Created by Jamilah Jaber Hazazi on 21/06/1447 AH.
//

import SwiftUI

struct LettersView: View {

    var title: String
    var category: LetterCategory

    @StateObject private var viewModel = LettersViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack {

            // الخلفية الجديدة
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

            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 25) {
                    
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    LazyVGrid(columns: columns, spacing: 25) {
                        
                        // نستخدم indices لتعديل حالة isCompleted لكل حرف
                        ForEach(viewModel.letters.indices, id: \.self) { index in
                            let item = viewModel.letters[index]
                            
                            NavigationLink {
                                SpeechSandboxView(
                                    receivedImageName: item.imageName,
                                    initialTargetSymbol: item.char
                                )
                            } label: {
                                HStack(spacing: 10) {
                                    Image(item.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 70, height: 70)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                    
                                    Text(item.char)
                                        .font(.system(size: 55))
                                        .fontWeight(.medium)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(item.isCompleted ? Color(hex: "#CCDCDA") : Color.white.opacity(0.85))
                                .cornerRadius(20)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                // عشان تضل ميزة "تم/غير تم" تشتغل
                                viewModel.letters[index].isCompleted.toggle()
                            })
                        }
                    }
                    .padding(.horizontal)

                    Spacer().frame(height: 200)
                }
            }
        }
        .onAppear {
            viewModel.loadLetters(for: category)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    LettersView(title: "مخرج اللسان", category: .lisan)
}

