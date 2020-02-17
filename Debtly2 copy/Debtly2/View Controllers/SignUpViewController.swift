//
//  SignUpViewController.swift
//  Debtly2
//
//  Created by Iesha Magallanes on 2/4/20.
//  Copyright © 2020 Debtly. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    @IBOutlet weak var debtlyImage: UIImageView!
    

    @IBOutlet weak var firstNameTextField: UITextField!
    
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var agreementButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    //Hide Keyboard when user touchs outside
    override func touchesBegan(_ touches:
        Set <UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Hide Keyboard when return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.resignFirstResponder()
        return(true)
    }
    
    
    
    //hide the error label
    func setUpElements() {
        
        errorLabel.alpha = 0
        
    }
    
    
    
    //Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    
    func validateFields() -> String? {
    
        
        
       //Check that all fields are filled in
if  firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
    passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            //Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character, and a number."
        }
        
        
        
        return nil
    
    }
        
        
    

    
    @IBAction func agreementTapped(_ sender: Any) {
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        //Validate the fields
        let error = validateFields()
        
        if error != nil {
            
            //There's something wrong with the fields, show error message
            showError(error!)
        }
        
        else {
            
            //Create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
             
            //Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
              
              // Check for errors
                if err != nil {
                    
                    // There was error creating the user
                    self.showError("Error creating user")
                }
                else {
                    
                   //User was created succesfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            //Show error message
                            self.showError("Error saving user data")
                        }
                }
                
                //Transition to the home screen
                    self.transitionToHome()
                   
                    
                    
                    
                }
            }
            
            
        }

    }
    
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
        
    }
    
    func transitionToHome() {
        
        let accountsViewController =
            
            self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.accountsViewController) as? AccountsViewController
        
        self.view.window?.rootViewController = accountsViewController
        self.view.window?.makeKeyAndVisible()
        
        
    }
    
}


