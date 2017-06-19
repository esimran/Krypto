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
            if index < GVplayable.endIndex {
                label.text = GVnames[index]
                label.backgroundColor = GVcolors[index]
                if GVplayable[index] {
                    let tap = UITapGestureRecognizer(target: self, action: #selector(Prompt.labelTap))
                    label.isUserInteractionEnabled = true
                    label.addGestureRecognizer(tap)
                } else {
                    label.isUserInteractionEnabled = false
                    label.backgroundColor = UIColor.gray
                }
            } else {
                label.isUserInteractionEnabled = false
                label.backgroundColor = UIColor.gray
            }
        }
    }
    
    
    
    func labelTap(sender: UITapGestureRecognizer) {
        let label = sender.view
        GVafterPrompt = true
        self.dismiss(animated: true, completion: nil)
        GVplayingIndex = (label?.tag)!-1
        GVplayable[(label?.tag)!-1] = false
    }
}
