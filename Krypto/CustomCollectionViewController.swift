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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return GVnames.count+1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 11
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        // Configure the cell
        cell.label.text = findValue(row: indexPath.section.description, col: indexPath.item.description)
        return cell
    }
    
    func findValue(row: String, col: String) -> String {
        if row == "0" {
            if col == "0" {
                return "Krypto"
            } else {
                return "Round " + col
            }
        }
        if col == "0" && row != "0" {
            return GVnames[Int(row)!-1]
        }
        let scoreRow = Int(row)!-1
        let scoreCol = Int(col)!-1
        return String(GVscores[scoreRow][scoreCol])
    }
}
