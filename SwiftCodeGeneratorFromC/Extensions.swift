//
//  Extensions.swift
//  SwiftCodeGeneratorFromC
//
//  Created by Ranjeet Singh on 04/05/23.
//

import Foundation


extension String {
    // MARK: - CamelCase
    // Ironically, function call must be in llamaCase
    func camelCase() -> String {
        return self.components(separatedBy: CharacterSet.alphanumerics.inverted)
            .filter { !$0.isEmpty }
            .map { $0.capitalized }
            .joined()
    }
    
    mutating func camelCased() {
        self = self.camelCase()
    }
    
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    
    func lowercaseFirstLetter() -> String {
      return prefix(1).lowercased() + self.dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
    
    mutating func lowercaseFirstLetter() {
      self = self.lowercaseFirstLetter()
    }
}

