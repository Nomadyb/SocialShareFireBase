//
//  SettingsViewController.swift
//  FirebaseSocialShare
//
//  Created by Ahmet Emin Yalçınkaya on 18.12.2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

	
	
	@IBAction func logoutClicked(_ sender: Any) {
		
		//performSegue(withIdentifier: "toViewController", sender: nil)
		
		do {
			try Auth.auth().signOut()
			performSegue(withIdentifier: "toViewController", sender: nil)
				
		}catch {
			print("not connected!")
		}
		
		
		
		
		
	}
	
	

}
