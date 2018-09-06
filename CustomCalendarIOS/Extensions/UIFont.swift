//
//  UIFont+.swift
//
//
//  Created by iMac Limited on 19/05/18.
//  Copyright © 2018 Umair Afzal. All rights reserved.
//

import UIKit

extension UIFont {

    class func appThemeFontWithSize(_ fontSize: CGFloat) -> UIFont {

        if !Utility.isIOS10Available() {

            if let font = UIFont(name: "Helvetica Neue", size: fontSize) {
                return font
            }
        }
        return UIFont.systemFont(ofSize: fontSize)
    }

    class func appThemeLightFontWithSize(_ fontSize: CGFloat) -> UIFont {

        if !Utility.isIOS10Available() {

            if let font = UIFont(name: "HelveticaNeue-Light", size: fontSize) {
                return font
            }
        }
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.light)
    }

    class func appThemeMediumFontWithSize(_ fontSize: CGFloat) -> UIFont {

        if !Utility.isIOS10Available() {

            if let font = UIFont(name: "HelveticaNeue-Medium", size: fontSize) {
                return font
            }
        }
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.medium)
    }

    class func appThemeBoldFontWithSize(_ fontSize: CGFloat) -> UIFont {

        if !Utility.isIOS10Available() {

            if let font = UIFont(name: "HelveticaNeue-Bold", size: fontSize) {
                return font
            }
        }
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.bold)
    }

    class func appThemeThinFontWithSize(_ fontSize: CGFloat) -> UIFont {

        if !Utility.isIOS10Available() {

            if let font = UIFont(name: "HelveticaNeue-Thin", size: fontSize) {
                return font
            }
        }

        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.thin)
    }

    class func appThemeRegularFontWithSize(_ fontSize: CGFloat) -> UIFont {

        if let font = UIFont(name: "Helvetica", size: fontSize) {
            return font
        }

        return UIFont.systemFont(ofSize: fontSize)
    }

    class func appBoldThemeFontWithSize(_ fontSize: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: fontSize)
    }

    class func appNormalFont(_ fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize)
    }
    
    class func appNormalBoldFont(_ fontSize: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: fontSize)
    }

}
