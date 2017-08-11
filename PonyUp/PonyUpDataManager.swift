//
//  PonyUpDataManager.swift
//  PonyUp
//
//  Created by Ben Allgeier on 4/23/17.
//  Copyright © 2017 ballgeier. All rights reserved.
//

import Foundation

class PonyUpDataManager {
    
    let sessionStore = SessionStore()
    let bettorStore = BettorStore()
    
    func joinBettorWithSession(bettor: Bettor, session: Session) {
        // This will have to be checked out because I don't feel confident in this approach
        // will add each to the other's array - seems redundant and need be better understand reference cycles
        bettor.addSession(session)
        session.addBettor(bettor)
    }
    
} // end class PonyUpDataManager
