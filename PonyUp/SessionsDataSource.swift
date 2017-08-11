//
//  SessionsDataSource.swift
//  PonyUp
//
//  Created by Ben Allgeier on 3/8/17.
//  Copyright © 2017 ballgeier. All rights reserved.
//

import UIKit

class SessionsDataSource: NSObject, UITableViewDataSource {
    
    var sessionStore: SessionStore! // not private so that can be set by tableViewVC
    private var sessions : [Session] {
        return sessionStore.allSessions
    }
    private var currentSession: Session? {
        return sessionStore.currentSession
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.SessionsTableViewCell, for: indexPath)
        
        let session = sessions[indexPath.row]
        cell.textLabel?.text = session.title
        let dateText = dateFormatter.string(from: session.date)
        cell.detailTextLabel?.text = dateText
        // add checkmark iff session is currentSession
        cell.accessoryType = (session == currentSession) ? .checkmark : .none
        
        return cell
    }
    
    enum Storyboard {
        static let SessionsTableViewCell = "Sessions Table View Cell"
    }
    
    // MARK: - DateFormatter
    
// adding date formatter - should this be accessible elsewhere
    let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateStyle = .medium
       formatter.timeStyle = .none
       return formatter
    }()

} // end class SessionsDataSource
