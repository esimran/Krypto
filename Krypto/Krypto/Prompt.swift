//
//  Prompt.swift
//  Krypto
//
//  Created by Simran Singh on 6/14/17.
//  Copyright © 2017 Simran Singh. All rights reserved.
//

import UIKit

class Prompt: UIViewController {
    
    @IBOutlet var Popup: UIView!
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
