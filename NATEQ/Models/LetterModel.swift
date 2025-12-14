//
//  LetterModel.swift
//  NATEQ
//
//  Created by Rahaf Alhammadi on 22/06/1447 AH.
//
import Foundation

struct LetterModel: Identifiable {
    let id = UUID()
    let char: String
    let symbol: String
    let imageName: String
    let videoName: String
    var isCompleted: Bool = false
}
