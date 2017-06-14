//
//  File.swift
//  Krypto
//
//  Created by Simran Singh on 5/20/17.
//  Copyright © 2017 Simran Singh. All rights reserved.
//

import Foundation

struct KryptoBrain {
    
    public func randomize(easyMode: Bool) -> String {
        var randomNumber = arc4random_uniform(1) + 1
        if !easyMode {
            randomNumber = arc4random_uniform(52) + 1
            if randomNumber>25 {
                randomNumber-=25
                if randomNumber>17 {
                    randomNumber-=17
                }
            }
        } else {
            randomNumber = arc4random_uniform(10) + 1
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
    
    public func expression(tag: Int) -> String {
        switch tag {
        case -5:
            return "+"
        case -4:
            return "-"
        case -3:
            return "*"
        case -2:
            return "/"
        default: return " "
        }
    }
    
    public func decode(imageName: String) -> Int {
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
    
    public func convertCardIndex(cardIndex: Int) -> String {
        switch cardIndex {
        case 0:
            return "+"
        case 1:
            return "-"
        case 2:
            return "x"
        case 3:
            return "÷"
        default: return " "
        }
    }
}
