//
//  Extensions.swift
//  NBA Teams
//
//  Created by Danilo Becke on 21/04/2018.
//  Copyright © 2018 Danilo Becke. All rights reserved.
//

import UIKit

extension UIColor {
    static func fromHexString(_ rawHex: String, alpha: CGFloat = 1) -> UIColor? {
        let scanner = Scanner(string: rawHex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        return UIColor(red: CGFloat(r) / 0xff,
                green: CGFloat(g) / 0xff,
                blue: CGFloat(b) / 0xff,
                alpha: alpha)
    }
}

extension Array {
    func get(at position: Int) -> Element? {
        guard position > 0, position < self.count else {
            return nil
        }
        return self[position]
    }
}
