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
    @IBAction func check(_ sender: UIButton) {
        checkCompletion()
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
    @IBOutlet weak var plus: UIImageView!
    @IBOutlet weak var minus: UIImageView!
    @IBOutlet weak var times: UIImageView!
    @IBOutlet weak var of: UIImageView!
    @IBOutlet weak var equals: UIImageView!
    @IBOutlet weak var firstOperator: UIImageView!
    @IBOutlet weak var secondOperator: UIImageView!
    @IBOutlet weak var thirdOperator: UIImageView!
    @IBOutlet weak var fourthOperator: UIImageView!
    @IBOutlet weak var paranthesis: UIImageView!
    @IBOutlet weak var firstLeftParanthesis: UIImageView!
    @IBOutlet weak var secondLeftParanthesis: UIImageView!
    @IBOutlet weak var thirdLeftParanthesis: UIImageView!
    @IBOutlet weak var fourthLeftParanthesis: UIImageView!
    @IBOutlet weak var firstRightParanthesis: UIImageView!
    @IBOutlet weak var secondRightParanthesis: UIImageView!
    @IBOutlet weak var thirdRightParanthesis: UIImageView!
    @IBOutlet weak var fourthRightParanthesis: UIImageView!
    
    var startCards: [UIImageView] = []
    var playCards: [UIImageView] = []
    var originalValues: [String] = []
    var operatorCards: [UIImageView] = []
    var operators: [UIImageView] = []
    var leftParanthesis: [UIImageView] = []
    var rightParanthesis: [UIImageView] = []
    var stateOfParanthesis = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startCards = [
            firstCard, secondCard, thirdCard, fourthCard, fifthCard
        ]
        playCards = [
            firstPlay, secondPlay, thirdPlay, fourthPlay, fifthPlay
        ]
        operatorCards = [
            plus, minus, times, of
        ]
        operators = [
            firstOperator, secondOperator, thirdOperator, fourthOperator
        ]
        leftParanthesis = [
            firstLeftParanthesis, secondLeftParanthesis, thirdLeftParanthesis, fourthLeftParanthesis
        ]
        rightParanthesis = [
            firstRightParanthesis, secondRightParanthesis, thirdRightParanthesis, fourthRightParanthesis
        ]
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup() {
        for image in startCards {
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.startTapped(_:)))
            image.addGestureRecognizer(tap)
            image.isUserInteractionEnabled = true
            let random = brain.randomize()
            originalValues.append(random)
            image.image = UIImage(named: random)
            image.tag = Int(random)!
            image.isHidden = false
        }
        for image in playCards {
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.playTapped(_:)))
            image.addGestureRecognizer(tap)
            image.isUserInteractionEnabled = true
            image.isHidden = true
            image.tag = -1
        }
        for image in operatorCards{
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.defaultOperatorTapped(_:)))
            image.addGestureRecognizer(tap)
            image.isUserInteractionEnabled = true
        }
        for image in operators {
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.playOperatorTapped(_:)))
            image.addGestureRecognizer(tap)
            image.isUserInteractionEnabled = true
            image.isHidden = true
            image.tag = -1
        }
        for image in leftParanthesis {
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.playLeftTapped(_:)))
            image.addGestureRecognizer(tap)
            image.isUserInteractionEnabled = true
            image.isHidden = false
            image.tag = -1
            image.image = UIImage(named: " ")
        }
        for image in rightParanthesis {
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.playRightTapped(_:)))
            image.addGestureRecognizer(tap)
            image.isUserInteractionEnabled = true
            image.isHidden = false
            image.tag = -1
            image.image = UIImage(named: " ")
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.paranthesisTapped))
        paranthesis.addGestureRecognizer(tap)
        paranthesis.isUserInteractionEnabled = true
        let random = brain.randomize()
        answer.image = UIImage(named: random)
        answer.tag = Int(random)!
        stateOfParanthesis = -1
    }
    
    func resetValues() {
        for image in startCards {
            image.isHidden = false
        }
        for image in leftParanthesis + rightParanthesis {
            image.image = UIImage(named: " ")
            image.isHidden = false
            image.tag = -1
        }
        for image in playCards + operators {
            image.isHidden = true
            image.tag = -1
        }
        stateOfParanthesis = -1
        print("reset")
    }
    
    func startTapped(_ sender: UITapGestureRecognizer) {
        let myView = sender.view!
        if myView.isHidden {
            return
        }
        myView.isHidden = true
        let results = findFirstUnplayed()
        let image = results.image
        if results.index == -1{
            return
        }
        image.tag = myView.tag
        image.image = UIImage(named: String(image.tag))
        image.isHidden = false
    }
    
    func playTapped(_ sender: UITapGestureRecognizer) {
        let myView = sender.view!
        if myView.isHidden {
            return
        }
        myView.isHidden = true
        startCards[originalValues.index(of: String(myView.tag))!].isHidden = false
        myView.tag = -1
    }
    
    func defaultOperatorTapped(_ sender: UITapGestureRecognizer) {
        let myView = sender.view!
        let results = findFirstUnplayedOperator()
        let image = results.image
        if results.index == -1 {
            return
        }
        image.isHidden = false
        let imageName = brain.decode(tag: myView.tag)
        image.image = UIImage(named: brain.decode(tag: myView.tag))
        image.tag = brain.decode(imageName: imageName)
    }
    
    func playOperatorTapped(_ sender: UITapGestureRecognizer) {
        let myView = sender.view!
        if myView.isHidden {
            return
        }
        myView.isHidden = true
        myView.tag = -1
    }
    
    func paranthesisTapped(_ sender: UITapGestureRecognizer) {
        if stateOfParanthesis == -1 {
            stateOfParanthesis = 0
        } else {
            stateOfParanthesis = -1
        }
    }
    
    func playLeftTapped(_ sender: UITapGestureRecognizer) {
        let myView = sender.view!
        if stateOfParanthesis != 0{
            if myView.tag == -6 {
                myView.tag = -1
                updateLeftParanthesis()
            }
            return
        }
        myView.isHidden = false
        myView.tag = -6
        stateOfParanthesis = 1
        updateLeftParanthesis()
    }
    
    func playRightTapped(_ sender: UITapGestureRecognizer) {
        let myView = sender.view!
        if stateOfParanthesis != 1 {
            if myView.tag == -6 {
                myView.tag = -1
                updateRightParanthesis()
            }
            return
        }
        myView.isHidden = false
        myView.tag = -6
        stateOfParanthesis = -1
        updateRightParanthesis()
    }
    
    func findFirstUnplayed() -> (index: Int, image: UIImageView) {
        for index in 0...4{
            let card = playCards[index]
            if card.tag == -1 {
                return (index, card)
            }
        }
        return (-1, firstPlay)
    }
    
    func findFirstUnplayedOperator() -> (index: Int, image: UIImageView){
        for index in 0...3{
            let card = operators[index]
            if card.tag == -1 {
                return (index, card)
            }
        }
        return (-1, firstOperator)
    }
    
    func updateLeftParanthesis() {
        for image in leftParanthesis {
            if image.tag == -6 {
                image.image = UIImage(named: "(")
            } else {
                image.image = UIImage(named: " ")
            }
        }
    }
    
    func updateRightParanthesis(){
        for image in rightParanthesis{
            if image.tag == -6 {
                image.image = UIImage(named: ")")
            } else {
                image.image = UIImage(named: " ")
            }
        }
    }
    
    func checkCompletion() {
        var numericExpression = ""
        for i in 0...4 {
            let cardValue = playCards[i].tag
            if i < 4 {
                if leftParanthesis[i].tag == -6 {
                    numericExpression += "("
                }
            }
            if cardValue != -1 {
                numericExpression += String(cardValue)
            } else {
                return
            }
            if i > 0 {
                if rightParanthesis[i-1].tag == -6 {
                    numericExpression += ")"
                }
            }
            if i < 4 {
                let operatorValue = operators[i].tag
                if operatorValue != -1 {
                    numericExpression += brain.expression(tag: operatorValue)
                } else {
                    return
                }
            }
        }
        print(numericExpression)
        let expression = NSExpression(format: numericExpression)
        print(expression)
        let result = expression.expressionValue(with: nil, context: nil) as! NSNumber
        print(result)
        print(answer.tag)
        if result.intValue == answer.tag {
            print("Right!")
        }
    }

//    func checkCompletion(){
//        var numericExpression = ""
//        for i in 0...4 {
//            let cardValue = playCards[i].tag
//            if i < 3 {
//                if leftParanthesis[i].tag == -6 {
//                    numericExpression += "("
//                }
//            }
//            if cardValue != -1 {
//                numericExpression += String(cardValue)
//            } else{
//                return
//            }
//            if i > 0 {
//                if rightParanthesis[i].tag == -6 {
//                    numericExpression += ")"
//                }
//            }
//            if i < 4 {
//                let operatorValue = operators[i].tag
//                print(operatorValue)
//                print(numericExpression)
//                if operatorValue != -1 {
//                    let added = brain.expression(tag: operatorValue)
//                    numericExpression += added
//                } else {
//                    return
//                }
//            }
//            print(i)c
//        }
//        print(numericExpression)
//        let expression = NSExpression(format: numericExpression)
//        let result = expression.expressionValue(with: nil, context: nil) as! NSNumber
//        if result.intValue == Int(answer.tag) {
//            print("Right!")
//        }
//    }
}

