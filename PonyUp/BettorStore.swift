//
//  BettorStore.swift
//  PonyUp
//
//  Created by Ben Allgeier on 4/6/17.
//  Copyright © 2017 ballgeier. All rights reserved.
//

import Foundation

class BettorStore {
// Also allow to be able to filter by session
// should the session have its own array of bettors or filter from here?
    
    var allBettors = [Bettor]()
    
    func contains(_ bettor: Bettor) -> Bool {
        return allBettors.contains(bettor)
    }

        func index(of bettor: Bettor) -> Int {
            guard let index = allBettors.index(of: bettor)
                else { fatalError("no index found for \(bettor)") }
            return index
        }

    
        func addBettor(_ bettor: Bettor) {
            let index = indexToKeepSorted(array: allBettors, for: bettor)
            allBettors.insert(bettor, at: index)
        }

} // end class BettorStore
