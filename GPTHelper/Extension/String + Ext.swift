//
//  String + Ext.swift
//  GPTHelper
//
//  Created by DonHalab on 06.01.2024.
//

import UIKit

extension String {
    func applyingBoldToSubstringsEnclosedInAsterisks() -> NSAttributedString {
        let pattern = "\\*\\*(.*?)\\*\\*"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let attributedString = NSMutableAttributedString(string: self)
        let fullRange = NSRange(self.startIndex..., in: self)
        
        let matches = regex.matches(in: self, options: [], range: fullRange)
        let boldAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)]
        
        // Идем по массиву с конца, чтобы индексы не сбивались
        for match in matches.reversed() {
            let matchRange = match.range(at: 0)
            let boldRange = match.range(at: 1)
            
            // Проверяем, что диапазоны валидны
            if matchRange.location != NSNotFound, boldRange.location != NSNotFound {
                let boldSubstring = (self as NSString).substring(with: boldRange)
                let boldAttributedString = NSAttributedString(string: boldSubstring, attributes: boldAttributes)
                attributedString.replaceCharacters(in: matchRange, with: boldAttributedString)
            }
        }
        
        return attributedString
    }
}