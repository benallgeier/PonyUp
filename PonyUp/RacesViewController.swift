//
//  RacesViewController.swift
//  PonyUp
//
//  Created by Ben Allgeier on 3/2/17.
//  Copyright © 2017 ballgeier. All rights reserved.
//

import UIKit

class RacesViewController: UITableViewController {
    
    private var appDataManager : PonyUpDataManager!
    private var sessionStore: SessionStore {
        return appDataManager.sessionStore
    }
    private var session: Session? {
        return sessionStore.currentSession
    }
    let racesDataSource = RacesDataSource()
    
    // MARK: - ViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // set up tableView's dataSource and delegate
        tableView.dataSource = racesDataSource
        tableView.delegate = self
        // set dataManager from tab bar
        let tabBar = tabBarController as! PonyUpTabController
        appDataManager = tabBar.appDataManager
        // pass sessionStore to dataSource
        racesDataSource.sessionStore = sessionStore
        
        // allow for variable row heights
//        tableView.estimatedRowHeight = 44
        //        tableView.rowHeight = UITableViewAutomaticDimension // already set by default
    } // end viewDidLoad()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
// for now, call reloadData
// perhaps a better way, such as notification that currentSession has been changed
        tableView.reloadData()
    } // end viewWillAppear(_:)
    
    // MARK: - Actions
    
    @IBAction func addNewRace(_ sender: Any) {
        // add next race to session
        guard let session = session
// generally have to think about what to do when no session has been created for each tab
            else { print("No selected session"); return }
        let raceNumber = session.numberOfRaces + 1
        let race = session.addRace(raceNumber)
        // get index of race and insert new row into table
        let index = session.index(of: race)
        let indexPath = IndexPath(row: index, section: 0)
        // Insert this new row into the table
        tableView.insertRows(at: [indexPath], with: .automatic)
    } // end addNewRace(_:)
    
} // end class RacesViewController



//// Original idea with textfield bringing up picker to choose race number
//// was thinking about having bets for race show by default
//// storyboard has corresponding RacesViewController for this

// , UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate

//    var pickerView = UIPickerView()
//    @IBOutlet weak var racePickerTextField: UITextField!

//override func viewDidLoad() {
//    super.viewDidLoad()
//    
//    pickerView.delegate = self
//    pickerView.dataSource = self
//    
//    racePickerTextField.delegate = self
//    
//    racePickerTextField.inputView = pickerView
//    racePickerTextField.text = "Race 1  ▽"
//    
//    let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
//    let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//    let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneWithPicker))
//    toolBar.items = [spacer, doneBarButton]
//    // both methods seem to work
//    //        pickerView.addSubview(toolBar)
//    racePickerTextField.inputAccessoryView = toolBar
//    
//} // end viewDidLoad()

//func doneWithPicker() {
//    view.endEditing(true)
//}

// MARK: - UIPickerViewDelegate Methods

//func pickerView(_ pickerView: UIPickerView,
//                titleForRow row: Int,
//                forComponent component: Int) -> String? {
//    return String(row + 1)
//} // end pickerView(_:titleForRow:forComponent:)
//
//func pickerView(_ pickerView: UIPickerView,
//                didSelectRow row: Int,
//                inComponent component: Int) {
//    racePickerTextField.text = "Race \(row + 1)  ▽"
//}
//
//// MARK: - UIPickerViewDataSource Methods
//
//func numberOfComponents(in pickerView: UIPickerView) -> Int {
//    return 1
//}
//
//func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//    return numberOfHorses
//}
//
//// MARK: - UITextFieldDelegate Methods
//
////// can we get rid of the cursor
////// and ability to select (All)...
////// really don't like that it is a textfield, just like that the
////// picker comes up from the bottom
//
//func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//    return false
//}



