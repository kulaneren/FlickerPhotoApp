//
//  UIColor+Extensions.swift
//  FlickrApp
//
//  Created by eren  on 31/10/2023.
//

import UIKit

extension UIColor {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = UIColor(named: "ColorAppBlue")
    let text = UIColor(named: "ColorGray")
    let warmGrey0_7Alpha = UIColor(displayP3Red: 136/255, green: 136/255, blue: 136/255, alpha: 0.7)
}
