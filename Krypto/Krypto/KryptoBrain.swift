//
//  File.swift
//  Krypto
//
//  Created by Simran Singh on 5/20/17.
//  Copyright © 2017 Simran Singh. All rights reserved.
//

import Foundation

struct KryptoBrain {
    
    public func randomize() -> String {
        var randomNumber = arc4random_uniform(52)+1
        if randomNumber>25 {
            randomNumber-=25
            if randomNumber>17 {
                randomNumber-=17
            }
        }
        return String(format: "%i", randomNumber)
    }
    
    public func decode(tag: Int) -> String {
        switch tag {
        case -5:
            return "+"
        case -4:
            return "-"
        case -3:
            return "x"
        case -2:
            return "÷"
        default: return " "
        }
    }
    
    public func decode(imageName: String) -> Int {
        print(imageName)
        if imageName == "+" {
            return -5
        } else if imageName == "-" {
            return -4
        } else if imageName == "x" {
            return -3
        } else if imageName == "÷" {
            return -2
        } else {
            return -1
        }
    }
}
