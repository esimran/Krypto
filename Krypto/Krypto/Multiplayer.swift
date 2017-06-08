//
//  Multiplayer.swift
//  Krypto
//
//  Created by Simran Singh on 6/4/17.
//  Copyright © 2017 Simran Singh. All rights reserved.
//

import UIKit

class Multiplayer: UIViewController {
    
    private var brain = KryptoBrain()
    @IBAction func next(_ sender: UIButton) {
        setup()
    }
    @IBAction func reset(_ sender: UIButton) {
        resetValues()
    }
    @IBAction func check(_ sender: UIButton) {
        if inKrypto {
            checkCompletion()
        } else {
            setKrypto()
        }
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
    @IBOutlet weak var timer: UILabel!
    var startCards: [UIImageView] = []
    var playCards: [UIImageView] = []
    var originalValues: [String] = []
    var playValues: [String] = []
    var operatorCards: [UIImageView] = []
    var operators: [UIImageView] = []
    var leftParanthesis: [UIImageView] = []
    var rightParanthesis: [UIImageView] = []
    var stateOfParanthesis = -1
    var originalStartPoints: [CGPoint] = []
    var originalPlayPoints: [CGPoint] = []
    var originalOperatorCardPoints: [CGPoint] = []
    var originalOperatorPoints: [CGPoint] = []
    var mark = ""
    var dispatchTimer: DispatchSourceTimer?
    var time = 0
    var kryptoTime = 0
    var cardIndex = 0
    var allPoints: [CGPoint] = []
    var previousPoint: CGPoint = CGPoint.init(x: 0, y: 0)
    var timerClass = Timer()
    var inKrypto = false
    var timeUp = UIAlertController()
    
    
    var  horizontalConstraint = NSLayoutConstraint()
    var  verticalConstraint = NSLayoutConstraint()
    
    
    
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.setPoints()
        })
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
            let random = brain.randomize()
            originalValues.append(random)
            image.image = UIImage(named: random)
            image.tag = Int(random)!
            image.isHidden = false
            let drag = UIPanGestureRecognizer(target: self, action: #selector(ViewController.startDragged))
            image.addGestureRecognizer(drag)
            
            image.layer.borderWidth = 2
            image.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
            image.layer.cornerRadius = 5.0
        }
        for image in playCards {
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.playTapped(_:)))
            image.addGestureRecognizer(tap)
            image.isUserInteractionEnabled = true
            image.isHidden = true
            image.tag = -1
            let drag = UIPanGestureRecognizer(target: self, action: #selector(ViewController.playDragged))
            image.addGestureRecognizer(drag)
        }
        for index in 0...3{
            let image = operatorCards[index]
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.defaultOperatorTapped(_:)))
            image.tag = -5 + index
            image.addGestureRecognizer(tap)
            image.isUserInteractionEnabled = true
            let drag = UIPanGestureRecognizer(target: self, action: #selector(ViewController.defaultOperatorDragged(_:)))
            image.addGestureRecognizer(drag)
        }
        for image in operators {
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.playOperatorTapped(_:)))
            image.addGestureRecognizer(tap)
            image.isUserInteractionEnabled = true
            image.isHidden = true
            image.tag = -1
            let drag = UIPanGestureRecognizer(target: self, action: #selector(ViewController.playOperatorDragged(_:)))
            image.addGestureRecognizer(drag)
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
        timeUp = UIAlertController(title: "Time's Up!", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        timeUp.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: nil))
//        startTimer()
//        secondCard.removeConstraints(secondCard.constraints)
//        horizontalConstraint = NSLayoutConstraint(item: secondCard, attribute: .centerX, relatedBy: .equal, toItem: secondCard.superview!, attribute: .centerX, multiplier: 1, constant: secondCard.center.x)
//        verticalConstraint = NSLayoutConstraint(item: secondCard, attribute: .centerY, relatedBy: .equal, toItem: secondCard.superview!, attribute: .centerY, multiplier: 1, constant: secondCard.center.y)
//        secondCard.addConstraints([horizontalConstraint, verticalConstraint])
    }
    
    func startTimer() {
        time = -1
        let queue = DispatchQueue(label: "com.firm.app.timer", attributes: .concurrent)
        dispatchTimer?.cancel()
        dispatchTimer = DispatchSource.makeTimerSource(queue: queue)
        dispatchTimer?.scheduleRepeating(deadline: .now(), interval: .seconds(1), leeway: .seconds(1))
        dispatchTimer?.setEventHandler {
            self.time += 1
//            DispatchQueue.main.async {
//                self.timer.text = String(self.time)
//            }
        }
        dispatchTimer?.resume()
    }
    
//    func startTimer() {
//        timerClass = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.action), userInfo: nil, repeats: true)
//    }
//    
//    func action() {
//        time += 1
//        timer.text = String(time)
//    }
    
    func setKrypto() {
        inKrypto = true
        timer.text = "You have 30 seconds! Click the Krypto button to check your answer!"
        kryptoTime = 3
        let queue = DispatchQueue(label: "krypto.timer", attributes: .concurrent)
        dispatchTimer?.cancel()
        dispatchTimer = DispatchSource.makeTimerSource(queue: queue)
        dispatchTimer?.scheduleRepeating(deadline: .now(), interval: .seconds(1), leeway: .seconds(1))
        dispatchTimer?.setEventHandler {
            self.kryptoTime -= 1
            if self.kryptoTime < 1 {
                self.kryptoTime = 0
            }
            DispatchQueue.main.async {
                self.timer.text = String(self.kryptoTime)
                if self.kryptoTime <= 0 {
                    self.present(self.timeUp, animated: true, completion: nil)
                }
            }
        }
        dispatchTimer?.resume()
    }
    
    func resetValues() {
        for index in 0...4 {
            let image = startCards[index]
            image.isHidden = false
            image.center = originalStartPoints[index]
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
        updatePlayValues()
        print("reset")
    }
    
    func setPoints() {
        for image in startCards {
            originalStartPoints.append(image.center)
        }
        for image in playCards {
            originalPlayPoints.append(image.center)
        }
        for image in operatorCards {
            originalOperatorCardPoints.append(image.center)
        }
        for image in operators {
            originalOperatorPoints.append(image.center)
        }
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
        updatePlayValues()
    }
    
    func startDragged(_ recognizer: UIPanGestureRecognizer) {
        label.isHidden = false
        label.text = "Drag to a gray card to play or release to try a different card"
        for image in playCards {
            if image.tag == -1 {
                image.isHidden = false
                image.image = UIImage(named: "gray")
            }
        }
        let translation = recognizer.translation(in: self.view)
        let center = recognizer.view!.center
        if originalStartPoints.contains(center){
            let index = originalStartPoints.index(of: center)
            mark = originalValues[index!]
            originalValues[index!] = "-1"
        }
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        let view = recognizer.view!
        
        
//
//        let superview = view.superview
//        let currentOffsetX = view.center.x - (superview?.center.x)!
//        let currentOffsetY = view.center.y - (superview?.center.y)!
//        
//        horizontalConstraint.constant = currentOffsetX
//        verticalConstraint.constant = currentOffsetY
        
        
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        if recognizer.state == UIGestureRecognizerState.ended {
            updatePlayValues()
            label.isHidden = true
            for image in playCards {
                if image.tag == -1 {
                    image.isHidden = true
                }
            }
            if thereIsPlayContact(view: view) {
                return
            }
            let index1 = originalValues.index(of: "-1")
            view.center = originalStartPoints[index1!]
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
        updatePlayValues()
    }
    
    func playDragged(_ recognizer: UIPanGestureRecognizer) {
        label.isHidden = false
        label.text = "Drag to any played card to switch or release to try a different card"
        for image in playCards {
            if image.tag == -1 {
                image.isHidden = false
                image.image = UIImage(named: "gray")
            }
        }
        let translation = recognizer.translation(in: self.view)
        let center = recognizer.view!.center
        if originalPlayPoints.contains(center){
            let index = originalPlayPoints.index(of: center)
            mark = playValues[index!]
            playValues[index!] = "-2"
        }
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        let view = recognizer.view!
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        if recognizer.state == UIGestureRecognizerState.ended {
            let index1 = playValues.index(of: "-2")
            playValues[index1!] = mark
            updatePlayValues()
            label.isHidden = true
            for image in playCards {
                image.isHidden = false
            }
            var result = findSwitchIndex(inputView: view)
            let result2 = findSwitchIndex2(inputView: view)
            if  result != -1 {
                if index1! == result {
                    result = result2
                }
                switchPlayCards(index1: index1!, index2: result)
                for image in playCards {
                    if image.tag != -1 {
                        image.isHidden = false
                        image.image = UIImage(named: String(image.tag))
                    } else {
                        image.isHidden = true
                    }
                }
            }
            view.center = originalPlayPoints[index1!]
        }
    }
    
    func findSwitchIndex(inputView: UIView) -> Int {
        for index in 0...4 {
            let image = playCards[4-index]
            if image.frame.intersects(inputView.frame) {
                return 4-index
            }
        }
        return -1
    }
    
    func findSwitchIndex2(inputView: UIView) -> Int {
        for index in 0...4 {
            let image = playCards[index]
            if image.frame.intersects(inputView.frame) {
                return index
            }
        }
        return -1
    }
    
    func switchPlayCards (index1: Int, index2: Int) {
        let image1 = playCards[index1]
        let image2 = playCards[index2]
        let temp = image2.tag
        image2.tag = image1.tag
        image1.tag = temp
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
    
    func defaultOperatorDragged(_ recognizer: UIPanGestureRecognizer) {
        label.isHidden = false
        label.text = "Drag to any played card to switch or release to try a different card"
        for image in operators {
            if image.tag == -1 {
                image.isHidden = false
                image.image = UIImage(named: "gray")
            }
        }
        let translation = recognizer.translation(in: self.view)
        let center = recognizer.view!.center
        if originalOperatorCardPoints.contains(center){
            cardIndex = originalOperatorCardPoints.index(of: center)!
        }
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        let view = recognizer.view!
        view.layoutIfNeeded()
        view.setNeedsLayout()
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        if recognizer.state == UIGestureRecognizerState.ended {
            for image in operators {
                image.isHidden = false
                if view.frame.intersects(image.frame) {
                    let imageName = brain.convertCardIndex(cardIndex: cardIndex)
                    image.image = UIImage(named: imageName)
                    image.tag = brain.decode(imageName: imageName)
                }
                if image.tag == -1 {
                    image.isHidden = true
                } else {
                    image.isHidden = false
                    image.image = UIImage(named: brain.decode(tag: image.tag))
                }
            }
            view.center = originalOperatorCardPoints[cardIndex]
        }
    }
    
    func playOperatorTapped(_ sender: UITapGestureRecognizer) {
        let myView = sender.view!
        if myView.isHidden {
            return
        }
        myView.isHidden = true
        myView.tag = -1
    }
    
    func playOperatorDragged(_ recognizer: UIPanGestureRecognizer) {
        label.isHidden = false
        label.text = "Drag to any played card to switch or release to try a different card"
        for image in operators {
            if image.tag == -1 {
                image.isHidden = false
                image.image = UIImage(named: "gray")
            }
        }
        let translation = recognizer.translation(in: self.view)
        let center = recognizer.view!.center
        if originalOperatorPoints.contains(center){
            cardIndex = originalOperatorPoints.index(of: center)!
        }
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        let view = recognizer.view!
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        if recognizer.state == UIGestureRecognizerState.ended {
            for image in operators {
                image.isHidden = false
                if view.frame.intersects(image.frame) {
                    let imageTag = image.tag
                    image.tag = view.tag
                    view.tag = imageTag
                }
            }
            for image in operators {
                if image.tag == -1 {
                    image.isHidden = true
                } else {
                    image.isHidden = false
                    image.image = UIImage(named: brain.decode(tag: image.tag))
                }
            }
            view.center = originalOperatorPoints[cardIndex]
        }
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
    
    func thereIsPlayContact(view: UIView) -> Bool {
        for image in playCards {
            if view.frame.intersects(image.frame) && image.isHidden {
                image.tag = view.tag
                image.image = UIImage(named: String(view.tag))
                view.isHidden = true
                image.isHidden = false
                return true
            }
        }
        return false
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
    
    func updatePlayValues() {
        playValues.removeAll()
        for image in playCards {
            playValues.append(String(image.tag))
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

