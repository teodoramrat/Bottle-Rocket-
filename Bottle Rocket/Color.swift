//
//  Color.swift
//  Bottle Rocket
//
//  Created by Teodora Mratinkovic on 11/24/21.
//

import UIKit

enum Color: String {
    case navBarGreen
    case tabBarDark
    case detailViewGreen
    case textLabelDark
}

extension UIColor {
    static func appColor(_ name: Color) -> UIColor? {
         return UIColor(named: name.rawValue)
    }
    static let joinedColor = UIColor()
}
