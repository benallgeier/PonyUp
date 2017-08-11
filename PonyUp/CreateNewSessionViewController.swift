//
//  AddNewSessionViewController.swift
//  PonyUp
//
//  Created by Ben Allgeier on 3/8/17.
//  Copyright © 2017 ballgeier. All rights reserved.
//

import UIKit

class CreateNewSessionViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: - Model
    
    var sessionStore: SessionStore!
    var session: Session?
    
    // MARK: - Outlets

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    
    // MARK: - View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initially title textField is empty so disable doneButton
        doneButton.isEnabled = false
        // make textField active
        titleTextField.becomeFirstResponder()
        
        // add tapGestureRecognizer to dismiss keyboard
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedBackground))
        tableView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // set the initial date to today's date
        datePicker.setDate(Date(), animated: true)
    } // end viewWillAppear(_:)
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // remove keyboard
        titleTextField.resignFirstResponder()
    }
    
    // MARK: - Segue Preparations
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier
            else { fatalError("Unidentified segue") }
        
        switch identifier {
        case Storyboard.cancelNewSessionSegue:
            prepareCancelNewSession()
        case Storyboard.addNewSessionSegue:
            prepareAddNewSession()
        default:
            fatalError("Unexpected segue: \(identifier)")
        } // end switch identifier
    }
    
    private func prepareCancelNewSession() {
        // nothing to do
    }
    
    @IBAction func doneButtonSelected() {
        // try to create the session from the user data
        // if successful: 
        // if not duplicate, then set the session property and perform segue
        // if duplicate, inform user
        guard let date = dateFromDatePicker(datePicker)
            else { print("date is nil"); return }
        let title = titleTextField.text! // not sure when textField's text is nil
        let session = Session(title: title, date: date)
        // check if session already exists
        if !sessionStore.contains(session) {
            self.session = session
            performSegue(withIdentifier: Storyboard.addNewSessionSegue, sender: nil)
        } else {
            // do not set session property and inform user
            informUserOfDuplicate(session)
        } // end else
    }
    
    private func prepareAddNewSession() {
        // note session propery should be set from doneButtonSelected since
        // it had to create a session to test for it being a duplicate
    } // end prepareAddNewSessionSegue(segue:)
    
    private func dateFromDatePicker(_ datePicker: UIDatePicker) -> Date? {
        let dateFromPicker = datePicker.date
        let calendar = Calendar.current
        // as with the datePicker, we won't consider time
        let unitFlags = Set<Calendar.Component>([.year, .month, .day])
        let components = calendar.dateComponents(unitFlags, from: dateFromPicker)
        let dateFromComponents = calendar.date(from: components) // possibly nil
// perhaps think about what to do if dateFromComponents is nil
// For starters, what would cause it to be nil
        return dateFromComponents
    }
    
    private func informUserOfDuplicate(_ session: Session) {
        // create UIAlertController informing user cannot add session
// perhaps offer ability to edit existing session
        let title = "\"\(session)\" already exists"
        let message = "Change the title or date"
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancelAction)
        
        present(ac, animated: true, completion: nil)
    }
    
    // MARK: - Storyboard Constants
    
    private enum Storyboard {
        static let cancelNewSessionSegue = "Cancel New Session Segue"
        static let addNewSessionSegue = "Add New Session Segue"
    }
    
    // MARK: - UITextFieldDelegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - TapGestureRecognizer Actions
    
    @IBAction func tappedBackground(_ sender: Any) {
        titleTextField.resignFirstResponder()
    }
    // MARK: - UIControlEvent Actions
    
    // for editingChanged
    @IBAction func toggleDoneButton(_ sender: UITextField) {
        guard let text = sender.text else { print("textField.text is nil"); return }
        doneButton.isEnabled = (text.isEmpty ? false : true)
    }
    
} // end class AddNewSessionViewController
