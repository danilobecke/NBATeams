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
        // FIXME: here!
        guard let hex = UInt32(rawHex) else {
            return nil
        }
        
        let divisor = CGFloat(255)
        let red     = CGFloat((hex & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex & 0x0000FF) / divisor
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
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
