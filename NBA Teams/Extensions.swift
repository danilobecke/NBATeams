//
//  Extensions.swift
//  NBA Teams
//
//  Created by Danilo Becke on 21/04/2018.
//  Copyright © 2018 Danilo Becke. All rights reserved.
//

import UIKit

// MARK: - Application push/present methods
func present(_ viewController: UIViewController, animated: Bool = true) {
    UIApplication.shared.keyWindow?.rootViewController?
        .present(viewController, animated: animated, completion: nil)
}

func push(_ viewController: UIViewController, animated: Bool = true) {
   
    guard let navigation = UIApplication.shared.keyWindow?.rootViewController
        as? UINavigationController else {
            return
    }
    navigation.pushViewController(viewController, animated: animated)
}

// MARK: - UIColor extensions
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
    
    static func customGradientImage(withFrame frame: CGRect) -> UIImage? {

        let blue = UIColor(red: 28/255, green: 48/255, blue: 118/255, alpha: 1).cgColor
        let red = UIColor(red: 195/255, green: 0, blue: 33/255, alpha: 1).cgColor
        
        UIGraphicsBeginImageContext(frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        var locations : [CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [blue, red]
            as CFArray, locations: &locations) else {
            return nil
            
        }
        context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0),
                                   end: CGPoint(x: frame.width, y: 0), options: [])
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return outputImage
    }
}

// MARK: - Array extensions
extension Array {
    func get(at position: Int) -> Element? {
        guard position >= 0, position < self.count else {
            return nil
        }
        return self[position]
    }
}

// MARK: - Bool extensions
extension Bool {
    mutating func toggle() {
        self = !self
    }
}
