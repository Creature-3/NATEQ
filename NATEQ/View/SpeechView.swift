
import SwiftUI
import Combine
import AVKit

struct SpeechView: View {

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: SpeechViewModel

    init(receivedVideoName: String?, initialTargetSymbol: String) {
        _viewModel = StateObject(
            wrappedValue: SpeechViewModel(
                targetSymbol: initialTargetSymbol,
                videoName: receivedVideoName
            )
        )
    }

    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.white, Color(hex: "#B0E4DD")]),
                center: .topLeading,
                startRadius: 100,
                endRadius: 900
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    Text(viewModel.targetSymbol)
                        .font(.system(size: 76, weight: .regular))
                        .foregroundColor(.black)

                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(hex: "#B0E4DD"))
                        .frame(width: 90, height: 4)
                }
                .padding(.top, 6)
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(Color.white)

                    if let player = viewModel.player {
                        VideoPlayer(player: player)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                            .padding(8)
                            .onAppear {
                                // اختياري: يبدأ تلقائيًا
                                player.play()
                            }
                    } else {
                        Text("هنا مقطع الفيديو من المترجم")
                            .foregroundColor(.black.opacity(0.6))
                    }
                }
                .frame(width: 300, height: 300)
                .padding(.top, 18)

                // باقي كودك بدون تغيير...
                ZStack {
                    Capsule()
                        .fill(Color.white.opacity(0.42))
                        .background(
                            Capsule()
                                .fill(Color(hex: "#B0E4DD"))
                                .blur(radius: 18)
                        )

                    Text(viewModel.feedbackText)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black.opacity(0.75))
                        .padding(.horizontal, 18)
                }
                .frame(width: 240, height: 90)
                .padding(.top, 18)

                Spacer()

                Button {
                    viewModel.toggleRecording()
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.45))
                            .background(
                                Circle()
                                    .fill(Color(hex: "#B0E4DD"))
                                    .blur(radius: 18)
                            )
                            .frame(width: 90, height: 90)
                            .scaleEffect(viewModel.isRecording ? 1.15 : 1.0)
                            .animation(
                                viewModel.isRecording
                                ? .easeInOut(duration: 0.9).repeatForever(autoreverses: true)
                                : .default,
                                value: viewModel.isRecording
                            )

                        Image(systemName: viewModel.isRecording ? "stop.fill" : "mic.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.black.opacity(0.8))
                    }
                }
                .padding(.bottom, 20)

                Text(viewModel.isRecording ? "جاري التسجيل..." : "اختبر نطقك")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(.bottom, 8)
            }
        }
        .onReceive(viewModel.transcriptPublisher) { text in
            viewModel.updateTranscript(text)
        }
        .onChange(of: viewModel.isRecording) { _, recording in
            if recording == false {
                viewModel.finishRecording()
            }
        }
    }
}

#Preview("SpeechView – Preview") {
    SpeechView(
        receivedVideoName: "A",
        initialTargetSymbol: "أ"
    )
}

