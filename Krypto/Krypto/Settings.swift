//
//  Settings.swift
//  Krypto
//
//  Created by Simran Singh on 6/11/17.
//  Copyright © 2017 Simran Singh. All rights reserved.
//

import UIKit

class Settings: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var secondName: UITextField!
    @IBOutlet weak var thirdName: UITextField!
    @IBOutlet weak var fourthName: UITextField!
    @IBOutlet weak var easyMode: UISwitch!
    @IBAction func StartGame(_ sender: Any) {
        if passesCheck() {
            performSegue(withIdentifier: "SettingsSegue", sender: self)
        }
    }
    var allColors: [UIColor] = [UIColor.green, UIColor.red, UIColor.blue, UIColor.orange]
    var inputs: [UITextField] = []
    var names: [String] = []
    var colors: [UIColor] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination: Multiplayer = segue.destination as! Multiplayer
        GVnames = names
        GVcolors = colors
        destination.easyMode = easyMode.isOn
        GVscores = Array(repeating: Array(repeating: 0, count: 11), count: GVnames.count)
    }
    
    func passesCheck() -> Bool {
        GVafterPrompt = false
        GVnames = [String()]
        GVcolors = []
        GVplayable = []
        GVplayingIndex = 0
        GVround = 0
        names.removeAll()
        colors.removeAll()
        inputs.append(firstName)
        inputs.append(secondName)
        inputs.append(thirdName)
        inputs.append(fourthName)
        for index in 0...3 {
            let name = inputs[index].text!
            if name != ""  {
                if !names.contains(name) {
                    names.append(name)
                    colors.append(allColors[index])
                    GVplayable.append(true)
                } else {
                    print("Duplicates")
                    return false
                }
            }
        }
        if names.isEmpty || names.endIndex < 2 {
            print("Need at least two players!")
            return false
        }
        return true
    }
}
