//
//  UILabel+LineSpacing.swift
//  Halan
//
//  Created by Moamen Abd Elgawad on 24/01/2022.
//

import UIKit

extension UILabel {
    /// add line under UILabel
    func underline() {
        guard let text = self.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        attributedText = attributedString
    }
    
}
