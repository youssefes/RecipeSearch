//
//  UIColor+Extension.swift
//  RecipeSearch
//
//  Created by LapStore on 22/04/2022.
//
import UIKit

extension UIColor {

    public enum RecipeSearchUIColor {
        static let appColor = UIColor.rgb(red: 92, green: 198, blue: 5)
        
    }

    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}
