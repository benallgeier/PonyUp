//
//  BettorsDataSource.swift
//  PonyUp
//
//  Created by Ben Allgeier on 4/6/17.
//  Copyright © 2017 ballgeier. All rights reserved.
//

import UIKit

class BettorsDataSource: NSObject, UITableViewDataSource {
    
    var bettorsArray: BettorsArray = .all
    var bettorStore: BettorStore! // not private so this can be set by tableViewVC
    private var allBettors: [Bettor] {
        return bettorStore.allBettors
    }
    var sessionStore: SessionStore! // not private so this can be set by tableViewVC
    private var session: Session? {
        return sessionStore.currentSession
    }
// consider what to show in case currentSession is nil
    private var bettorsInSession: [Bettor] {
        if let session = session {
            return session.bettors
        } else {
            return [Bettor]()
        }
    }
    var bettors: [Bettor] {
        switch bettorsArray {
        case .all:
            return allBettors
        case .session:
            return bettorsInSession
        } // end switch
    } // end bettors
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bettors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.BettorsTableViewCell, for: indexPath)
        
        let bettor = bettors[indexPath.row]
        cell.textLabel?.text = bettor.name
        
        // add checkmark if in currentSession and showing all bettors
        if bettorsArray == .all && session != nil {
            cell.accessoryType = session!.bettors.contains(bettor) ? .checkmark : .none
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    } // end tableView(_:cellForRowAt:)
    
    enum Storyboard {
        static let BettorsTableViewCell = "Bettors Table View Cell"
    }
    
    // MARK: - Filter Bettors
    
    func setBettorsList(to bettorsArray: BettorsArray) {
        self.bettorsArray = bettorsArray
    }
    
    enum BettorsArray {
        case all
        case session
    }
    
} // end class BettorsDataSource
