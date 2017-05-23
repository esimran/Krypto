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
    @IBOutlet weak var label: UILabel!
    
    var startCards: [UIImageView] = []
    var playCards: [UIImageView] = []
    var originalValues: [String] = []
    var operatorCards: [UIImageView] = []
    var operators: [UIImageView] = []
    var leftParanthesis: [UIImageView] = []
    var rightParanthesis: [UIImageView] = []
    var stateOfParanthesis = -1
    var originalPoints: [CGPoint] = []
    
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
        for image in startCards {
            originalPoints.append(image.center)
        }
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup() {
        originalValues.removeAll()
        for image in startCards {
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.startTapped(_:)))
            image.addGestureRecognizer(tap)
            image.isUserInteractionEnabled = true
//            let random = brain.randomize()
            let random = "5"
            originalValues.append(random)
            image.image = UIImage(named: random)
            image.tag = Int(random)!
            image.isHidden = false
            let drag = UIPanGestureRecognizer(target: self, action: #selector(ViewController.startDragged))
            image.addGestureRecognizer(drag)
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
        label.isHidden = true
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
        label.isHidden = true
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
    
    func startDragged(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        let center = recognizer.view!.center
        var mark = "MARK"
        if originalPoints.contains(center){
            let index = originalPoints.index(of: center)
            mark = originalValues[index!]
            originalValues[index!] = "-1"
            print("done")
        }
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        let view = recognizer.view!
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        if recognizer.state == UIGestureRecognizerState.ended {
            checkForPlayContact(view: view)
        } else {
            let index1 = originalValues.index(of: "-1")
            view.center = originalPoints[index1!]
            originalValues[index1!] = mark
        }
    }
    
    func playTapped(_ sender: UITapGestureRecognizer) {
        let myView = sender.view!
        if myView.isHidden {
            return
        }
        myView.isHidden = true
        let index = originalStartingCard(tag: myView.tag)
        if index != -1 {
            startCards[index].isHidden = false
        }
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
            label.isHidden = false
            label.text = "Press a gray box for the left paranthesis or the paranthesis again to stop"
            makeLeftUnplayedGray()
        } else {
            label.isHidden = true
            stateOfParanthesis = -1
            updateLeftParanthesis()
            updateRightParanthesis()
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
        label.text = "Now, press a gray box for the right paranthesis or the paranthesis again to stop"
        label.isHidden = false
        myView.isHidden = false
        myView.tag = -6
        stateOfParanthesis = 1
        updateLeftParanthesis()
        makeRightUnplayedGray()
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
        label.isHidden = true
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
    
    func makeLeftUnplayedGray() {
        for image in leftParanthesis {
            if image.tag == -6 {
                image.image = UIImage(named: "(")
            } else {
                image.image = UIImage(named: "gray")
            }
        }
    }
    
    func makeRightUnplayedGray() {
        for image in rightParanthesis {
            if image.tag == -6 {
                image.image = UIImage(named: ")")
            } else {
                image.image = UIImage(named: "gray")
            }
        }
    }
    
    func checkForPlayContact(view: UIView) {
        for image in playCards {
            if view.frame.intersects(image.frame) && image.isHidden {
                image.tag = view.tag
                image.image = UIImage(named: String(view.tag))
                view.isHidden = true
                image.isHidden = false
            }
        }
    }
    
    func originalStartingCard(tag: Int) -> Int {
        for index in 0...4 {
            let image = startCards[index]
            if image.isHidden && image.tag == tag {
                return index
            }
        }
        return -1
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
        let expression = NSExpression(format: numericExpression)
        let result = expression.expressionValue(with: nil, context: nil) as! NSNumber
        if result.intValue == answer.tag {
            label.isHidden = false
            label.text = "Right!"
        } else {
            label.isHidden = false
            label.text = "Wrong!"
        }
    }
}

