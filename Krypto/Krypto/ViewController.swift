//
//  ViewController.swift
//  Krypto
//
//  Created by Simran Singh on 5/19/17.
//  Copyright © 2017 Simran Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var brain = KryptoBrain()
    @IBAction func next(_ sender: UIButton) {
        setValues()
    }
    @IBAction func reset(_ sender: UIButton) {
    }
    @IBOutlet weak var firstCard: UIImageView!
    @IBOutlet weak var secondCard: UIImageView!
    @IBOutlet weak var thirdCard: UIImageView!
    @IBOutlet weak var fourthCard: UIImageView!
    @IBOutlet weak var fifthCard: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setValues(){
        firstCard.image=UIImage(named: brain.randomize())
        secondCard.image=UIImage(named: brain.randomize())
        thirdCard.image=UIImage(named: brain.randomize())
        fourthCard.image=UIImage(named: brain.randomize())
        fifthCard.image=UIImage(named: brain.randomize())
    }

}

