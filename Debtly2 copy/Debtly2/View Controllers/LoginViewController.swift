//
//  LoginViewController.swift
//  Debtly2
//
//  Created by Iesha Magallanes on 2/4/20.
//  Copyright © 2020 Debtly. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    @IBOutlet weak var debtlyImage: UIImageView!
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var rememberMeButton: UIButton!
    
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    
    @IBOutlet weak var logInButton: UIButton!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    @IBOutlet weak var orConnectWithButton: UILabel!
    
    
    @IBOutlet weak var appleButton: UIButton!
    
    
    @IBOutlet weak var facebookButton: UIButton!
    
    
    @IBOutlet weak var googleButton: UIButton!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      setUpElements()
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
    
    
    
    
    func setUpElements() {
        
        //hide the error label
        errorLabel.alpha = 0
        
    }
     
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func rememberTapped(_ sender: Any) {
    }
    
    
    @IBAction func forgotTapped(_ sender: Any) {
    }
    
    
    @IBAction func logInTapped(_ sender: Any) {
        
        // TODO:Validate Text Fields
        
        
        // Create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result,error)  in
        
        if error != nil {
            //Couldn't sign in
            self.errorLabel.text = error!.localizedDescription
            self.errorLabel.alpha = 1
        }
        else {
            let homeViewController =
                self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
            
            self.view.window?.rootViewController = homeViewController
            self.view.window?.makeKeyAndVisible()
            
            }
            
        }
    }
    
    
    @IBAction func appleTapped(_ sender: Any) {
    }
    
    
    @IBAction func facebookTapped(_ sender: Any) {
    }
    
    
    @IBAction func goggleTapped(_ sender: Any) {
    }
    
    
}

