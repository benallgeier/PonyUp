//
//  SessionsViewController.swift
//  PonyUp
//
//  Created by Ben Allgeier on 3/8/17.
//  Copyright © 2017 ballgeier. All rights reserved.
//

import UIKit

class SessionsViewController: UITableViewController {
    
    private var appDataManager: PonyUpDataManager!
    private var sessionStore: SessionStore {
        return appDataManager.sessionStore
    }
    private var sessions : [Session] {
        return sessionStore.allSessions
    }
    private var currentSession: Session? {
        return sessionStore.currentSession
    }
    private var currentSessionIndexPath: IndexPath? {
        if let session = currentSession {
            return indexPathOf(session: session)
        } else { return nil }
    }
    private let sessionsDataSource = SessionsDataSource()
    
    // MARK: - View Controller Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // set dataSource and delegate
        tableView.dataSource = sessionsDataSource
        tableView.delegate = self
        // set our dataManager from tab bar
        let tabBar = tabBarController as! PonyUpTabController
        appDataManager = tabBar.appDataManager
        // pass properties to dataSource
        sessionsDataSource.sessionStore = sessionStore
        // allow for variable row heights
        tableView.estimatedRowHeight = 44
//        tableView.rowHeight = UITableViewAutomaticDimension // already set by default
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    } // end viewDidLoad()
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier
            else { fatalError("Unidentified segue") }
        switch identifier {
        case Storyboard.addNewSessionSegue:
            prepareCreateNewSessionVC(with: segue)
        default:
            fatalError("Unexpected segue: \(identifier)")
        } // end switch identifier
    } // end prepare(for:sender:)
    
    private func prepareCreateNewSessionVC(with segue: UIStoryboardSegue) {
        if let createNewSessionVC = segue.destination.contentViewController as? CreateNewSessionViewController {
            createNewSessionVC.sessionStore = sessionStore
        } // end if let
    }
    
    // MARK: - Unwind Segue Actions
    
    @IBAction func cancelNewSession(segue: UIStoryboardSegue) {
        // nothing to do
    }
    
    @IBAction func prepareAddNewSession(segue: UIStoryboardSegue) {
        // get session from source
        guard let CreateNewSessionVC = segue.source as? CreateNewSessionViewController,
              let session = CreateNewSessionVC.session
            else { return }
        addNewSession(session: session)
    } // end addNewSession(segue:)
    
    // updates data model, including currentSession, tableView, and checkmark
    private func addNewSession(session: Session) {
//         add session to sessionStore    
        sessionStore.addSession(session)
//        // get old and new indexPaths if possible
//        let newIndexPath = indexPathOf(session: session)
//        let oldIndexPath = currentSessionIndexPath // could be nil
        // update currentSession
        sessionStore.currentSession = session
        // update tableView
        
        // reloadData works. After changing to prepending, app crashes with updates blocks
        tableView.reloadData()
        
        // found that if you put insertRow and reloadRow in different updates blocks,
        // app does not crash
        // could just not perform in updates block too
//        tableView.beginUpdates()
//        tableView.insertRows(at: [newIndexPath], with: .automatic)
//        tableView.endUpdates()
//        tableView.beginUpdates()
//        // no row to reload if first session added
//        if oldIndexPath != nil {
//            tableView.reloadRows(at: [oldIndexPath!], with: .automatic)
//        } else {
//            if sessions.count > 1 {
//                fatalError("currentSession is nil and we already had some sessions")
//            }
//        }
//        tableView.endUpdates()
        
    } // end addNewSession(session:)
    
    // MARK: - UITableViewDelegate Methods
    
    // checks to see if we selected new row, then updates currentSession
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // if selected different session, update session
        guard let oldSession = currentSession
            else { fatalError("no current session when selecting row") }
        let newSession = sessions[indexPath.row]
        let oldIndexPath = currentSessionIndexPath
        
        if oldSession != newSession {
            sessionStore.currentSession = newSession
            tableView.beginUpdates()
            tableView.reloadRows(at: [oldIndexPath!, indexPath], with: .automatic)
            tableView.endUpdates()
        }
    } // end tableView(_:didSelectRowAt:)
    
    // MARK: - Storyboard Constants

    enum Storyboard {
        static let addNewSessionSegue = "Add New Session Segue"
    }
    
    // MARK: - IndexPath Helpers
    
    private func indexPathOf(session: Session) -> IndexPath {
        let index = sessionStore.index(of: session)
        let indexPath = IndexPath(row: index, section: 0)
        return indexPath
    }


    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

} // end class SessionsViewController

extension UIViewController {
    var contentViewController: UIViewController {
        if let navCon = self as? UINavigationController {
            return navCon.visibleViewController ?? self
        }
        return self
    }
}
