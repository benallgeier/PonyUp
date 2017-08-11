//
//  MakeBetViewController.swift
//  DerbyBettor
//
//  Created by Ben Allgeier on 2/28/17.
//  Copyright © 2017 ballgeier. All rights reserved.
//

import UIKit

class MakeBetViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var betDataSource = BetDataSource()
    
    var numberOfHorses = 10

    override func viewDidLoad() {
        collectionView.dataSource = betDataSource
        collectionView.delegate = self
        
        betDataSource.numberOfHorses = numberOfHorses
    } // end viewDidLoad()
    
    // MARK: - UICollectionViewDelegateFlowLayout Methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfCellsInARow = CGFloat(betDataSource.numberOfPositionsToPick)
        let whiteSpaceAmount = CGFloat(2 * (numberOfCellsInARow + 1))
        let width = CGFloat((collectionView.bounds.width - whiteSpaceAmount) / numberOfCellsInARow)
        let numberOfPositions = betDataSource.numberOfPositionsToPick
        let height = width / CGFloat(( 2 * numberOfPositions ))
        let cellSize = CGSize(width: width, height: height)
        return cellSize
    } // end collectionView(_:layout:sizeForItemAt:)
    
} // end class MakeBetViewController
