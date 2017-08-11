//
//  Race.swift
//  PonyUp
//
//  Created by Ben Allgeier on 3/3/17.
//  Copyright © 2017 ballgeier. All rights reserved.
//

import Foundation

// should/could this be a struct
class Race {
    
    let number: Int
//// should runners be an array or set
//// if runners already have polePosition property, might not need an array
    var runners: [Horse]
    var numberOfHorses: Int {
        return runners.count
    }
    unowned let session: Session
    
//// should this be its own data structure?
    var top4Runners: [Horse]?
    var payouts: Payouts?
//// should bets be an array or set or even computed
    var bets = [Bet]()
    
    init(number: Int, session: Session, runners: [Horse] = [Horse]()) {
        self.number = number
        self.session = session
        self.runners = runners
    } // end init
    
} // end class Race

extension Race: Equatable {
    static func == (lhs: Race, rhs: Race) -> Bool {
        return (lhs.session == rhs.session) &&
               (lhs.number == rhs.number)
    }
}

