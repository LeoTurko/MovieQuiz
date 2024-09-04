//
//  Array+Extensions.swift
//  MovieQuiz
//
//  Created by Леонид Турко on 26.08.2024.
//

import Foundation

extension Array {
  subscript(safe index: Index) -> Element? {
    indices ~= index ? self[index] : nil 
  }
}
