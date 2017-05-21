//
//  File.swift
//  Krypto
//
//  Created by Simran Singh on 5/20/17.
//  Copyright © 2017 Simran Singh. All rights reserved.
//

import Foundation

struct KryptoBrain {
    
    public func randomize() -> String{
        var randomNumber = arc4random_uniform(52)+1
        if randomNumber>25{
            randomNumber-=25
            if randomNumber>17{
                randomNumber-=17
            }
        }
        return String(format: "%i", randomNumber)
    }
    
}
