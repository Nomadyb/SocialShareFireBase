//
//  ViewController.swift
//  FirebaseSocialShare
//
//  Created by Ahmet Emin Yalçınkaya on 18.12.2023.
//

import UIKit
import Firebase
import FirebaseAuth




class ViewController: UIViewController{

	
	
	@IBOutlet weak var emailText: UITextField!
	
	@IBOutlet weak var passwordText: UITextField!
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()

		
		
		
	}
	
	
	
	@IBAction func signInClicked(_ sender: Any) {
		
		//performSegue(withIdentifier: "toFeedVC", sender: nil)
		
		if emailText.text != "" && passwordText.text != "" {
			
			Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!){
				(authdata,error) in
				if error != nil {
					self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Alert!")
					
				}else {
					self.performSegue(withIdentifier: "toFeedVC", sender: nil )
				}
				
			}
			

			
			
		}else {
			
			makeAlert(titleInput: "Error!", messageInput: "Error, mail Value cannot be null!")
			
			
		}
		
		
	}
	

	@IBAction func signUpClicked(_ sender: Any) {
		
		
		if emailText.text != "" && passwordText.text != "" {
			
			
			Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!){
				(authdata, error) in
				
				if error != nil {
					self.makeAlert(titleInput: "error!", messageInput: error?.localizedDescription ?? "error")
					
				}else {
					self.performSegue(withIdentifier: "toFeedVC", sender: nil)
				}
			}
			
		}else {
			
			

			makeAlert(titleInput: "Error", messageInput: "Error, mail Value cannot be null!")
			
		}
		

		
	}
	
	
	
	func makeAlert(titleInput:String,messageInput:String) {
		
		let alert = UIAlertController(title:  titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
		let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil)
		alert.addAction(okButton)
		self.present(alert, animated: true , completion: nil)
		
		
		
	}

	
	

}

