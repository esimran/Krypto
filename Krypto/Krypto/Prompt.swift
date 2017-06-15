//
//  Prompt.swift
//  Krypto
//
//  Created by Simran Singh on 6/14/17.
//  Copyright © 2017 Simran Singh. All rights reserved.
//

import UIKit

class Prompt: UIViewController {
    
    @IBOutlet weak var Popup: UIView!
    @IBAction func Cancel(_ sender: UIButton) {
        afterPrompt = true
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var firstPlayer: UILabel!
    @IBOutlet weak var secondPlayer: UILabel!
    @IBOutlet weak var thirdPlayer: UILabel!
    @IBOutlet weak var fourthPlayer: UILabel!
    var players: [UILabel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        players = [
            firstPlayer, secondPlayer, thirdPlayer, fourthPlayer
        ]
        Popup.layer.cornerRadius = 10
        Popup.layer.masksToBounds = true
        for index in 0...3 {
            let label = players[index]
            let tap = UITapGestureRecognizer(target: self, action: #selector(Prompt.labelTap))
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(tap)
        }
    }
    
    func labelTap(sender: UITapGestureRecognizer) {
        let label = sender.view
        afterPrompt = true
        self.dismiss(animated: true, completion: nil)
    }
}
