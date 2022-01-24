//
//  UILabel+LineSpacing.swift
//  Halan
//
//  Created by Moamen Abd Elgawad on 24/01/2022.
//

import UIKit

extension UILabel {
    func changeLinesSpacing(lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight
        paragraphStyle.alignment = textAlignment
        
        let attrString = NSMutableAttributedString()
        if self.attributedText != nil {
            attrString.append(self.attributedText!)
        } else {
            guard let font = font else { return }
            guard let text = text else { return }
            attrString.append(NSMutableAttributedString(string: text))
            attrString.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: attrString.length))
        }
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
        self.attributedText = attrString
    }
    
    func underline() {
        guard let text = self.text else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        
        self.attributedText = attributedString
    }
    
}
