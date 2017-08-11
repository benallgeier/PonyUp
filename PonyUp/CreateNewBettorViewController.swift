//
//  CreateNewBettorViewController.swift
//  PonyUp
//
//  Created by Ben Allgeier on 4/6/17.
//  Copyright © 2017 ballgeier. All rights reserved.
//

import UIKit

class CreateNewBettorViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var bettorStore: BettorStore!
    var bettor: Bettor?
    
    // MARK: - View Controller Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initially title textField is empty so disable doneButton
        doneButton.isEnabled = false
        // make textField active
        nameTextField.becomeFirstResponder()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedBackground))
        tableView.addGestureRecognizer(tapGestureRecognizer)
    } // end viewDidLoad()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // resign first responder to dismiss keyboard
// could call view.endEditing...
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    } // end viewWillDisappear(_:)
    
    // MARK: - Methods for TextFields
    
    // UITextFieldDelegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        return true
    } // end textFieldShouldReturn(_:)
    
    func tappedBackground() {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }
    
    // UIControlEvent Actions
    // for editingChanged
    @IBAction func toggleDoneButton(_ sender: UITextField) {
        let name = nameTextField.text!
        let email = emailTextField.text!
        // make sure name is not empty
        if name.isEmpty {
            doneButton.isEnabled = false
            return
        }
        // since name is not empty, we now test we have a valid email
        doneButton.isEnabled = isValidEmail(email)
    } // end toggleDoneButton(_:)
    
    private func isValidEmail(_ email: String) -> Bool {
        // need to learn how to do this
        // for now, return true if not empty
        return !email.isEmpty
    } // end isValidEmail(_:)
    
    // MARK: - Segue Preparations
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier
            else { fatalError("Unidentified segue") }
        
        switch identifier {
        case Storyboard.cancelNewBettorSegue:
            prepareCancelNewBettor()
        case Storyboard.addNewBettorSegue:
            prepareAddNewBettor()
        default:
            fatalError("Unexpected segue: \(identifier)")
        } // end switch identifier
    }
    
    private func prepareCancelNewBettor() {
        // nothing to do
    }
    
    private func prepareAddNewBettor() {
        // note bettor propery should be set from doneButtonSelected since
        // it had to create a bettor to test for it being a duplicate
    } // end prepareAddNewBettorSegue(segue:)
    
    // MARK: - Action Methods
    
    @IBAction func doneButtonSelected() {
        // if not duplicate, then set the bettor property and perform segue
        // if duplicate, inform user
        let name = nameTextField.text!
        let email = emailTextField.text!
        let bettor = Bettor(name: name, email: email)
// Potential problem. What if two people have the same name. 
// Would have to look at their email to distinguish
// should we allow same name - rare, but possible
        if !bettorStore.contains(bettor) {
            self.bettor = bettor
            performSegue(withIdentifier: Storyboard.addNewBettorSegue, sender: nil)
        } else {
            // do not set bettor property and inform user
            informUserOfDuplicate(bettor)
        } // end else
    } // end doneButtonSelected()
    
    private func informUserOfDuplicate(_ bettor: Bettor) {
        // create UIAlertController informing user cannot add bettor
        // perhaps offer ability to edit existing bettor
        let title = "\"\(String(describing: bettor))\" already exists"
        let message = "Change the name or email"
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancelAction)
        
        present(ac, animated: true, completion: nil)
    }
    
    // MARK: - Storyboard Constants
    
    private enum Storyboard {
        static let cancelNewBettorSegue = "Cancel New Bettor Segue"
        static let addNewBettorSegue = "Add New Bettor Segue"
    }

} // end class CreateNewBettorViewController
