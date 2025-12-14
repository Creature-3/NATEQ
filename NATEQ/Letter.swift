//
//  Letter.swift
//  NATEQ
//
//  Created by Rahaf Alhammadi on 21/06/1447 AH.
//

import Foundation

struct ArabicLetter: Identifiable, Equatable, Hashable {
    let id = UUID()
    let symbol: String      // "ب"
    let name: String        // "باء"
}
