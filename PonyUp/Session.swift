//
//  Session.swift
//  PonyUp
//
//  Created by Ben Allgeier on 3/4/17.
//  Copyright © 2017 ballgeier. All rights reserved.
//

// A session contains the races for a day

import Foundation

class Session {
    let date: Date
    let title: String
    
    // see comments for sessions in Bettor.swift
    var bettors = [Bettor]()    
    func addBettor(_ bettor: Bettor) {
        let index = indexToKeepSorted(array: bettors, for: bettor)
        bettors.insert(bettor, at: index)
    }
    
    // an array or set or Races? Races already have number
    var races: [Race]
    var numberOfRaces : Int {
        return races.count
    }
    
    init(title: String, date: Date, races: [Race] = [Race]()) {
        self.title = title
        self.date = date
        self.races = races
    } // end init
    
    func addRace(_ number: Int) -> Race {
        let race = Race(number: number, session: self)
        races.append(race)
        return race
    } // end addRace(_:)
    
    func index(of race: Race) -> Int {
        guard let index = races.index(of: race)
            else { fatalError("index for race \(race.number) in session \(self) not found") }
        return index
    }
    
} // end class Session

extension Session: Equatable {
    static func == (lhs: Session, rhs: Session) -> Bool {
        return (lhs.date == rhs.date) && (lhs.title == rhs.title)
    }
}

extension Session: CustomStringConvertible {
    var description: String {
// could add date to this
        return self.title
    }
}
