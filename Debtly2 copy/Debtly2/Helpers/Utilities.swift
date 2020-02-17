//
//  File.swift
//  Debtly2
//
//  Created by Iesha Magallanes on 2/15/20.
//  Copyright © 2020 Debtly. All rights reserved.
//

import Foundation
import UIKit

class Utilities {

    
    
    
    
    
    
    static func isPasswordValid(_ password : String) -> Bool {
    
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
    return passwordTest.evaluate(with: password)
    }
    
    
    
    
    
    
    
}
