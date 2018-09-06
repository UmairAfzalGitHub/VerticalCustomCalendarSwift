//
//  Utility.swift
//  CustomCalendarIOS
//
//  Created by Mac on 06/09/2018.
//  Copyright © 2018 UmairAFzal. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    
    class func isIOS10Available() -> Bool {
        
        if let systemVersion = Double(UIDevice.current.systemVersion) {
            
            if systemVersion >= 10.0 {
                return true
            }
        }
        
        return false
    }
}
