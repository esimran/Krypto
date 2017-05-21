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
        setup()
    }
    @IBAction func reset(_ sender: UIButton) {
        resetValues()
    }
    @IBOutlet weak var firstCard: UIImageView!
    @IBOutlet weak var secondCard: UIImageView!
    @IBOutlet weak var thirdCard: UIImageView!
    @IBOutlet weak var fourthCard: UIImageView!
    @IBOutlet weak var fifthCard: UIImageView!
    @IBOutlet weak var firstPlay: UIImageView!
    @IBOutlet weak var secondPlay: UIImageView!
    @IBOutlet weak var thirdPlay: UIImageView!
    @IBOutlet weak var fourthPlay: UIImageView!
    @IBOutlet weak var fifthPlay: UIImageView!
    @IBOutlet weak var answer: UIImageView!
    
    var startCards: [UIImageView] = []
    var playCards: [UIImageView] = []
    var originalValues: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startCards = [
            firstCard, secondCard, thirdCard, fourthCard, fifthCard
        ]
        playCards = [
            firstPlay, secondPlay, thirdPlay, fourthPlay, fifthPlay
        ]
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setup(){
        for image in startCards{
            let tap = UITapGestureRecognizer(target: self, action:#selector(ViewController.startTapped(_:)))
            image.addGestureRecognizer(tap)
            image.isUserInteractionEnabled = true
            let random = brain.randomize()
            originalValues.append(random)
            image.image = UIImage(named: random)
            image.tag = Int(random)!
            image.isHidden = false
        }
        for image in playCards{
            let tap = UITapGestureRecognizer(target: self, action:#selector(ViewController.playTapped(_:)))
            image.addGestureRecognizer(tap)
            image.isUserInteractionEnabled = true
            image.isHidden = true
            image.tag = -1
        }
        answer.image = UIImage(named: brain.randomize())
    }

    func resetValues(){
        for image in startCards{
            image.isHidden = false
        }
        for image in playCards{
            image.isHidden = true
            image.tag = -1
        }
    }
    
    func startTapped(_ sender: UITapGestureRecognizer){
        let myView = sender.view!
        if myView.isHidden{
            return
        }
        myView.isHidden = true
        let results = findFirstUnplayed()
        let image = results.image
        image.tag = myView.tag
        image.image = UIImage(named: String(image.tag))
        image.isHidden = false
        if results.index == 4{
            checkCompletion()
        }
    }
    
    func playTapped(_ sender: UITapGestureRecognizer){
        let myView = sender.view!
        if myView.isHidden{
            return
        }
        myView.isHidden = true
        startCards[originalValues.index(of: String(myView.tag))!].isHidden = false
        myView.tag = -1
    }
    
    func findFirstUnplayed() -> (index: Int, image: UIImageView){
        for index in 0...4{
            let card = playCards[index]
            if card.tag == -1 {
                return (index, card)
            }
        }
        return (-1, firstPlay)
    }
    
    func checkCompletion(){
        print("TODO")
    }
}

