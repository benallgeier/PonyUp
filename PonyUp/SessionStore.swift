//
//  SessionStore.swift
//  PonyUp
//
//  Created by Ben Allgeier on 3/8/17.
//  Copyright © 2017 ballgeier. All rights reserved.
//

//// Should SessionStore keep an instance of BettorStore
//// and then the tab bar only needs to instantiate SessionStore

import Foundation

class SessionStore {
// not sure if should keep private(set) - maybe allow controller to append...
    private(set) var allSessions = [Session]()
//    private(set) var allSessions: [Session] = {
//       var sessions = [Session]()
//        let title = "Derby Party At Nick's House Baby"
//        let date = Date()
//        let session = Session(title: title, date: date)
//        sessions.append(session)
//        
//        // In this case the date gets cut off
//        let title2 = "Derby Party At Nick's Baby"
//        let session2 = Session(title: title2, date: date)
//        sessions.append(session2)
//        
//        return sessions
//    }()
    
    var currentSession: Session?
    
    var currentRaces: [Race]? {
        return currentSession?.races
    }
    
    func addSession(_ session: Session) {
        allSessions.insert(session, at: 0)
    }
    
    func contains(_ session: Session) -> Bool {
        return allSessions.contains(session)
    }
    
    func index(of session: Session) -> Int {
        guard let index = allSessions.index(of: session)
            else { fatalError("no index found for \(session)") }
        return index
    }
    
} // end class SessionStore
