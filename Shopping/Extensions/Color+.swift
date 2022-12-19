//
//  Color+.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    
    init?(hex: String) {
            var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

            var rgb: UInt64 = 0

            var r: CGFloat = 0.0
            var g: CGFloat = 0.0
            var b: CGFloat = 0.0
            var a: CGFloat = 1.0

            let length = hexSanitized.count

            guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

            if length == 6 {
                r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
                g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
                b = CGFloat(rgb & 0x0000FF) / 255.0

            } else if length == 8 {
                r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
                g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
                b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
                a = CGFloat(rgb & 0x000000FF) / 255.0

            } else {
                return nil
            }

            self.init(red: r, green: g, blue: b, opacity: a)
        }
}

struct ColorTheme {
    let accent = Color("AccentColor")         //#010035
    let background = Color("mainBgColor")     //#F5F5F5
    let red = Color("mainRed")                //#FF6E4E
    let darkGray = Color("darkGray")          //#282843
    let lightGray = Color("lightGray")        //#CCCCCC
    let brown = Color("mainBrown")            //#772D03
    let gray = Color("mainGray")              //#B7B7B7
    let yellow = Color("mainYellow")          //#FFB800
    let black = Color("secondaryBlack")       //#010101
    let secondaryGray = Color("secondaryGray")//#8D8D8D
    let shadow = Color("shadowColor")         //#374E88
}

