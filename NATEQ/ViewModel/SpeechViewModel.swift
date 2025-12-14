//
//  SpeechViewModel.swift
//  NATEQ
//
//  Created by Rahaf Alhammadi on 22/06/1447 AH.
//

import Foundation
import Combine
import AVKit

final class SpeechViewModel: ObservableObject {

    // MARK: - Inputs
    let targetSymbol: String
    let videoName: String?      // ✅ بدل imageName

    // MARK: - Video
    @Published private(set) var player: AVPlayer?   // ✅ جاهز للـ VideoPlayer في الـ View

    // MARK: - State (UI + Logic)
    @Published var liveText: String = ""
    @Published var detectedLetter: ArabicLetter?
    @Published var showFeedback: Bool = false

    // ✅ This one changes IMMEDIATELY on tap (UI state)
    @Published private(set) var uiIsRecording: Bool = false

    private let speechService: SpeechRecognizerService
    private var cancellables = Set<AnyCancellable>()

    init(
        targetSymbol: String,
        videoName: String?,      // ✅ بدل imageName
        speechService: SpeechRecognizerService = SpeechRecognizerService()
    ) {
        self.targetSymbol = targetSymbol
        self.videoName = videoName
        self.speechService = speechService

        // ✅ Prepare player once (safe + independent from recording)
        self.player = Self.makePlayer(from: videoName)

        // ✅ Keep UI state synced with the real service state
        speechService.$isRecording
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.uiIsRecording = value
            }
            .store(in: &cancellables)
    }

    // ✅ The View uses this, so the icon changes instantly
    var isRecording: Bool {
        uiIsRecording
    }

    // Keep your current View code (.onReceive) working
    var transcriptPublisher: Published<String>.Publisher {
        speechService.$transcript
    }

    // ✅ Instant icon change on tap + start/stop service
    func toggleRecording() {
        uiIsRecording.toggle()

        if uiIsRecording {
            // Starting a new attempt
            detectedLetter = nil
            liveText = ""
            showFeedback = false
            speechService.startRecording()
        } else {
            speechService.stopRecording()
            finishRecording()
        }
    }

    func updateTranscript(_ text: String) {
        let cleaned = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleaned.isEmpty else { return }

        liveText = cleaned
        detectedLetter = detectLetter(from: cleaned)
    }

    func finishRecording() {
        showFeedback = true
    }

    private func detectLetter(from transcript: String) -> ArabicLetter? {
        ArabicAlphabet.all.first {
            transcript.contains($0.symbol) || transcript.contains($0.name)
        }
    }

    var feedbackText: String {
        guard showFeedback else {
            return isRecording
            ? (liveText.isEmpty ? "..." : liveText)
            : "شاهد، جرّب، تعلّم"
        }

        guard let target = ArabicAlphabet.all.first(where: { $0.symbol == targetSymbol }) else {
            return "⚠️ لا يوجد حرف مستهدف"
        }

        // ❌ Nothing detected
        guard let detected = detectedLetter else {
            return """
            ❌ خطأ
            لم أستطع تحديد الحرف المنطوق
            المطلوب: \(target.symbol) – \(target.name)
            """
        }

        // ✅ Correct
        if detected.symbol == target.symbol {
            return "✅ أحسنت! نطقتِ الحرف الصحيح"
        }

        // ❌ Wrong — show both
        return """
        ❌ خطأ
        نطقتِ: \(detected.symbol) – \(detected.name)
        المطلوب: \(target.symbol) – \(target.name)
        """
    }

    // MARK: - Helper (Video Loading)
    private static func makePlayer(from videoName: String?) -> AVPlayer? {
        guard let videoName, !videoName.isEmpty else { return nil }

        // Try mp4 then mov (works with what you usually have in Assets/bundle)
        let url =
            Bundle.main.url(forResource: videoName, withExtension: "mp4") ??
            Bundle.main.url(forResource: videoName, withExtension: "mov")

        guard let url else {
            print("❌ Video not found: \(videoName).mp4/.mov in bundle")
            return nil
        }

        let player = AVPlayer(url: url)
        return player
    }
}
