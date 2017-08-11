//
//  BettorViewController.swift
//  PonyUp
//
//  Created by Ben Allgeier on 4/6/17.
//  Copyright © 2017 ballgeier. All rights reserved.
//

import UIKit

class BettorsViewController: UITableViewController {
    
    private var appDataManager: PonyUpDataManager!
    private var bettorStore: BettorStore {
        return appDataManager.bettorStore
    }
    private var bettors: [Bettor] {
        return bettorStore.allBettors
    }
    private var sessionStore: SessionStore {
        return appDataManager.sessionStore
    }
    private var session: Session? {
        return sessionStore.currentSession
    }
    private let bettorsDataSource = BettorsDataSource()
    @IBOutlet weak var filterTVSegmentedControl: UISegmentedControl!
    
    // MARK: - View Controller Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set dataSource and delegate
        tableView.dataSource = bettorsDataSource
        tableView.delegate = self
        // set dataManager from tab bar
        let tabBar = tabBarController as! PonyUpTabController
        appDataManager = tabBar.appDataManager
        // pass properties to dataSource
        bettorsDataSource.bettorStore = bettorStore
        bettorsDataSource.sessionStore = sessionStore
        // allow for variable row heights
        tableView.estimatedRowHeight = 44
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        // add action to segmented control
        filterTVSegmentedControl.addTarget(self, action: #selector(currentSessionOrAll(sender:)), for: .valueChanged)
        filterTVSegmentedControl.selectedSegmentIndex = segmentedControlFor["all"]! // dataSource initializes bettorsArray to .all as well
    } // end viewDidLoad()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
// really only need to reloadData if the session has changed and filterTVSegmentedControl's selectedIndex is on session - similar to Races tableView
        tableView.reloadData()
    }
    
    // MARK: - SegmentedControl Actions
    
    func currentSessionOrAll(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case segmentedControlFor["session"]!: bettorsDataSource.setBettorsList(to: .session)
        case segmentedControlFor["all"]!: bettorsDataSource.setBettorsList(to: .all)
        default: print("bad index selected for segmented control")
        } // end switch
        tableView.reloadData()
    }
    
// notice we get optionals in return -- for now just forcing unwrapping - better way?
    private var segmentedControlFor: [String : Int] = ["session" : 0,
                                                       "all" : 1 ]
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier
            else { fatalError("Unidentified segue") }
        switch identifier {
        case Storyboard.addNewBettorSegue:
            prepareCreateNewBettorVC(with: segue)
        default:
            fatalError("Unexpected segue: \(identifier)")
        } // end switch identifier
    } // end prepare(for:sender:)
    
    private func prepareCreateNewBettorVC(with segue: UIStoryboardSegue) {
        if let createNewBettorVC = segue.destination.contentViewController as? CreateNewBettorViewController {
            createNewBettorVC.bettorStore = bettorStore
        } // end if let
    }
    
    // MARK: - Unwind Segue Actions
    
    @IBAction func cancelNewBettor(segue: UIStoryboardSegue) {
        // nothing to do
    }
    
    @IBAction func prepareAddNewBettor(segue: UIStoryboardSegue) {
        // get bettor from source
        guard let CreateNewBettorVC = segue.source as? CreateNewBettorViewController,
            let bettor = CreateNewBettorVC.bettor
            else { return }
        addNewBettor(bettor: bettor)
    } // end addNewSession(segue:)

    // updates data model, inserts new row,
    private func addNewBettor(bettor: Bettor) {
        // add bettor to model
        bettorStore.addBettor(bettor)
        // join bettor and session
        if let session = self.session {
            appDataManager.joinBettorWithSession(bettor: bettor, session: session)
        }
        // insert this new row into the table
        let indexPath = indexPathOf(bettor: bettor)
        tableView.insertRows(at: [indexPath], with: .automatic)
    } // end addNewBettor(bettor:)
    
    // MARK: - UITableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if bettorsDataSource.bettorsArray != .all { return }
        guard let session = session
            else { print("no current session when selecting bettor"); return }
        let bettor = bettors[indexPath.row]
        if session.bettors.contains(bettor) {
// not updating bettor.session...
            session.bettors.remove(at: indexPath.row)
        } else {
            session.addBettor(bettor)
        } // end else
        tableView.reloadRows(at: [indexPath], with: .automatic)
    } // end tableView(_:didSelectRowAt:)
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        // add code to return nil if bettor has any bets
        return indexPath
    }
    
    // MARK: - Storyboard Constants
   
    enum Storyboard {
        static let addNewBettorSegue = "Add New Bettor Segue"
    }
    
    // MARK: - IndexPath Helpers
    
    private func indexPathOf(bettor: Bettor) -> IndexPath {
        let index = bettorStore.index(of: bettor)
        let indexPath = IndexPath(row: index, section: 0)
        return indexPath
    }
    
} // end class BettorViewController
