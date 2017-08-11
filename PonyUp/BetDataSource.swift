//
//  BetDataSource.swift
//  DerbyBettor
//
//  Created by Ben Allgeier on 2/28/17.
//  Copyright © 2017 ballgeier. All rights reserved.
//

import UIKit

class BetDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - Model
    
    var numberOfHorses: Int!
    let numberOfPositionsToPick = 2
    
    func horseNumber(inPosition position: Int) -> Int {
        return (position / numberOfPositionsToPick) + 1
    } // end horseNumber(inPosition)
    
    // MARK: UICollectionViewDataSource Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  numberOfHorses * numberOfPositionsToPick
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.betCollectionViewCell, for: indexPath) as! BetCollectionViewCell
        
        let horseNumber = self.horseNumber(inPosition: indexPath.row)
        cell.configure(withHorseNumber: horseNumber)
        return cell
    }
    
    struct Storyboard {
        static let betCollectionViewCell = "Bet Collection View Cell"
    }
    
} // end class BetDataSource
