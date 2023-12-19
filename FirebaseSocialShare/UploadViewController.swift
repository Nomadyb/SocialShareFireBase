//
//  UploadViewController.swift
//  FirebaseSocialShare
//
//  Created by Ahmet Emin Yalçınkaya on 18.12.2023.
//

import UIKit
import Firebase
import FirebaseStorage


class UploadViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

	
	
	@IBOutlet weak var imageView: UIImageView!
	
	
	@IBOutlet weak var commentText: UITextField!
	
	
	
	@IBOutlet weak var uploadButton: UIButton!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		
		imageView.isUserInteractionEnabled = true
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
		imageView.addGestureRecognizer(gestureRecognizer)
		
		
		
    }
	
	
	@objc func chooseImage() {
		
		let pickerController = UIImagePickerController()
		pickerController.delegate = self
		pickerController.sourceType = .photoLibrary
		present(pickerController,animated: true, completion: nil)
		
		
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		imageView.image = info[.originalImage] as? UIImage
		self.dismiss(animated: true, completion: nil)
		
	}
	
	func makeAlert(titleInput:String,messageInput:String) {
		let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert
		)
		let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil )
		self.present(alert,animated: true,completion: nil)
	}
    

 
	
	@IBAction func actionButtonClicked(_ sender: Any) {
		
		let storage = Storage.storage()
		let storageReference  = storage.reference()
		
		let mediaFolder = storageReference.child("media")
		
		if let data = imageView.image?.jpegData(compressionQuality: 0.7){
			
			let uuid = UUID().uuidString
			
			let imageReference = mediaFolder.child("\(uuid).jpg")
			imageReference.putData(data, metadata: nil) { (metadata, error) in
				if error != nil {
					self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
					
				}else {
					imageReference.downloadURL { (url, error) in
						if error != nil {
							let imageUrl = url?.absoluteString
							//print(imageUrl)
							
							
							//DB
							
							let firestoreDatabase = Firestore.firestore()
							var firestoreReference : DocumentReference? = nil
							
							
							let firestorePost = ["imageUrl": imageUrl!, "postedBy": Auth.auth().currentUser!.email!,"postComment":self.commentText.text!,"date":"date","likes":0] as [String : Any ]
							
							firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
								if error != nil {
									self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
									
									
									
								}
								
								})
							
							
							}
					}
					
				}
			}
			
			
			
		}
			
		
		
		
		
		
	}
	
	

}
