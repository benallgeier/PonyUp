//
//  BetCollectionViewCell.swift
//  DerbyBettor
//
//  Created by Ben Allgeier on 2/28/17.
//  Copyright © 2017 ballgeier. All rights reserved.
//

import UIKit

class BetCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var horseNumber: UILabel!
    
    func configure(withHorseNumber number: Int) {
        let horseNumberString = String(number)
        horseNumber.text = horseNumberString
    } // end configure(horseNumber:)
    
} // end class BetCollectionViewCell
