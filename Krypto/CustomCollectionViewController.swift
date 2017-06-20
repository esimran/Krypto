//
//  CustomCollectionViewController.swift
//  Krypto
//
//  Created by Simran Singh on 6/18/17.
//  Copyright © 2017 Simran Singh. All rights reserved.
//

import UIKit

let reuseIdentifier = "customCell"

class CustomCollectionViewController: UICollectionViewController {
    
    @IBAction func startRound(_ sender: Any) {
        if GVround != 10 {
            performSegue(withIdentifier: "StartRound", sender: nil)
        } else {
            performSegue(withIdentifier: "FinishMulti", sender: nil)

        }
    }
    @IBOutlet weak var startRoundButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if GVround != 10 {
            startRoundButton.setTitle("Start Round \(GVround+1)", for: .normal)
        } else {
            startRoundButton.setTitle(findWinner(), for: .normal)
        }
    }
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return GVnames.count+1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 12
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        // Configure the cell
        let row = indexPath.section.description
        let col = indexPath.item.description
        cell.label.text = findValue(row: row, col: col)
        return cell
    }
    
    func findValue(row: String, col: String) -> String {
        if row == "0" {
            if col == "0" {
                return "Krypto"
            } else if col == "11" {
                return "Total Score"
            } else {
                return "Round " + col
            }
        }
        if col == "0" && row != "0" {
            return GVnames[Int(row)!-1]
        }
        let scoreRow = Int(row)!-1
        let scoreCol = Int(col)!-1
        let value = GVscores[scoreRow][scoreCol]
        if value != 0 || col == "11" {
            return String(value)
        } else {
            return ""
        }
    }
    func findWinner() -> String {
        var max = -11
        var winners: [String] = []
        for index in 0...GVscores.count - 1 {
            let playerScore = GVscores[index][10]
            if playerScore > max {
                max = playerScore
            }
        }
        for index in 0...GVscores.count - 1 {
            let playerScore = GVscores[index][10]
            if playerScore == max {
                winners.append(GVnames[index])
            }
        }
        var basic = String()
        if winners.count == 1 {
            basic = "The winner is \(GVnames[0])"
        } else {
            basic = "The winners are:"
            for name in winners {
                basic += " " + name
            }
            return basic
        }
        basic += "! Click here for the main menu."
        return basic
    }
}
