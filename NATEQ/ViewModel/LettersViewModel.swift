//
//  LettersViewModel.swift
//  pj
//
//  Created by Jamilah Jaber Hazazi on 21/06/1447 AH.
//

import Foundation
internal import Combine


enum LetterCategory {
    case halq
    case shafateen
    case lisan
    case all
}


class LettersViewModel: ObservableObject {
    
    
    
    @Published var letters: [LetterModel] = []
    
    func loadLetters(for category: LetterCategory) {
        switch category {
        case .halq:
            letters = ["أ","ه","ع","ح","خ","غ"].map {
                LetterModel(char: $0, imageName: $0)
            }
            
        case .shafateen:
            letters = ["ف","ب","م","و"].map {
                LetterModel(char: $0, imageName: $0)
            }
            
        case .lisan:
            letters = ["ق","ك","ج","ش","ي","ض","ل","ن","ر",
                       "ت","د","ط","ز","ص","س","ث","ذ","ظ"]
                .map { LetterModel(char: $0, imageName: $0)
                    
                }
            
        case .all:
            letters = [
                "أ","ب","ت","ث","ج","ح","خ","د","ذ","ر","ز",
                "س","ش","ص","ض","ط","ظ","ع","غ","ف","ق",
                "ك","ل","م","ن","ه","و","ي"
            ].map {
                LetterModel(char: $0, imageName: $0)
                
            }
        }
    }
    
}
