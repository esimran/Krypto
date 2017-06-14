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
    @IBOutlet weak var startGame: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination: Multiplayer = segue.destination as! Multiplayer
        destination.firstName = firstName.text!
        destination.secondName = secondName.text!
        destination.thirdName = thirdName.text!
        destination.fourthName = fourthName.text!
        destination.easyMode = easyMode.isOn
    }
}
