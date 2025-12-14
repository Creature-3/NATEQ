//
//  LettersViewModel.swift
//  pj
//
//  Created by Jamilah Jaber Hazazi on 21/06/1447 AH.
//

import Foundation
import Combine

final class LettersViewModel: ObservableObject {

    @Published var letters: [LetterModel] = []

    private func videoName(for symbol: String) -> String? {
        switch symbol {
        case "أ": return "A"
        case "ب": return "B2"// فيديوك الحقيقي للحرف
        default: return nil
        }
    }

    func loadLetters(for category: LetterCategory) {
        let symbols: [String]

        switch category {
        case .halq:      symbols = ["أ","ه","ع","ح","خ","غ"]
        case .shafateen: symbols = ["ف","ب","م","و"]
        case .lisan:     symbols = ["ق","ك","ج","ش","ي","ض","ل","ن","ر","ت","د","ط","ز","ص","س","ث","ذ","ظ"]
        case .all:
            symbols = ["أ","ب","ت","ث","ج","ح","خ","د","ذ","ر","ز","س","ش","ص","ض","ط","ظ","ع","غ","ف","ق","ك","ل","م","ن","ه","و","ي"]
        }

        letters = symbols.map { s in
            LetterModel(
                char: s,
                symbol: s,
                imageName: s,
                videoName: videoName(for: s) ?? "",
                isCompleted: false
            )
        }
    }
}
