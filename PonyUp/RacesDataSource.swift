//
//  RacesDataSource.swift
//  PonyUp
//
//  Created by Ben Allgeier on 3/6/17.
//  Copyright © 2017 ballgeier. All rights reserved.
//

import UIKit

class RacesDataSource: NSObject, UITableViewDataSource {
    
    var sessionStore: SessionStore! // not private so that can be set by tableViewVC
// note setting empty array for races if currentSession is nil -- is there a better way to handle?
// note that adding plain setter for races - did not add setter for sessions in SessionsDataSource
// think more about this set up
    var races: [Race] {
        get {
            guard let session = sessionStore.currentSession
                else { return [Race]() }
            return session.races
        } // end get
//        set {
//            self.races = newValue
//        } // end set
    } // end var races
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return races.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.RacesTableViewCell, for: indexPath)
        
        let race = races[indexPath.row]
        let raceNumber = race.number
        cell.textLabel?.text = "Race \(raceNumber)"
        
        return cell
    }
    
    enum Storyboard {
      static let RacesTableViewCell = "Races Table View Cell"
    }
    
} // end class RacesDataSource
