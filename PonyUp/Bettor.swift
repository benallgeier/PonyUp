//
//  Bettor.swift
//  PonyUp
//
//  Created by Ben Allgeier on 3/3/17.
//  Copyright © 2017 ballgeier. All rights reserved.
//

import Foundation

class Bettor {
    let name: String
//// what type should an email be? Its own type?
    var email: String
// POTENTIAL ISSUE: Are we going to have a reference cycle, if so how to best avoid
// bettor has array of sessions and sessions have an array of bettors
// does it make any difference that arrays are value types? Notice that sessions cannot be made to be weak
// initial thoughts: if delete session, remove that session from each bettor's sessions array
// ANOTHER THOUGHT: Seems like a lot to have such an array for each bettor (perhaps other way around to)
// Is there a more efficeint way to keep track of this relationship? Do we really need to keep this property?
    var sessions = [Session]()
    func addSession(_ session: Session) {
        // for now just append
        sessions.append(session)
    }
    
    
//// should bets be an array or sets or computed
//// still not clear on ownership of bets (bettor, session, ...)
    var bets = [Bet]()
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    } // end init
    
} // end class Bettor

// not sure if I need
//extension Bettor: Hashable {
//    var hashValue: Int {
//        return email.hashValue
//    } // end hashValue
//} // end extension Horse: Hashable

extension Bettor: Comparable {
    static func == (lhs: Bettor, rhs: Bettor) -> Bool {
        if lhs.name != rhs.name { return false }
        else { return lhs.email == rhs.email }
    } // end ==(lhs:rhs:)
    
    static func < (lhs: Bettor, rhs: Bettor) -> Bool {
        if lhs.name != rhs.name { return lhs.name < rhs.name }
        else { return lhs.email < rhs.email }
    }
} // end extension Horse: Equatable

extension Bettor: CustomStringConvertible {
    var description: String {
        // could add email to this
        return self.name
    }
}
