//
//  SpeechSandboxView.swift
//  NATEQ
//
//  Created by Rahaf Alhammadi on 21/06/1447 AH.
//
struct SpeechSandboxView: View {

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: SpeechSandboxViewModel

    init(receivedImageName: String?, initialTargetSymbol: String) {
        _viewModel = StateObject(
            wrappedValue: SpeechSandboxViewModel(
                targetSymbol: initialTargetSymbol,
                imageName: receivedImageName
            )
        )
    }

    var body: some View {
        ZStack {
            // نفس الـ UI عندك بدون تغيير
            // فقط استخدمي:
            // viewModel.targetSymbol
            // viewModel.feedbackText
            // viewModel.toggleRecording()
        }
        .onReceive(viewModel.transcriptPublisher) { text in
            guard viewModel.isRecording else { return }
            viewModel.updateTranscript(text)
        }
        .onChange(of: viewModel.isRecording) { _, recording in
            if recording == false {
                viewModel.finishRecording()
            }
        }
    }
}
