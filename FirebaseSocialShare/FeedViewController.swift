//
//  FeedViewController.swift
//  FirebaseSocialShare
//
//  Created by Ahmet Emin Yalçınkaya on 18.12.2023.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseDatabase
import FirebaseFirestore



class FeedViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

	
	
	
	
	
	@IBOutlet weak var tableView: UITableView!
	

	var userEmailArray = [String]()
	var userCommentArray = [String]()
	var userlikeArray = [Int]()
	var userImageArray = [String]()
	var documentIdArray = [String]()
	
    override func viewDidLoad() {
		super.viewDidLoad()

			tableView.delegate = self
			tableView.dataSource = self

			// GradientView'i arka plana ekle
			//let gradientView = GradientView(frame: view.bounds)
			//view.insertSubview(gradientView, at: 0)

			getDataFromFireStore()
    }
	
	
	
	
	func getDataFromFireStore(){
		
		let fireStoreDatabase = Firestore.firestore()
		//let settings = fireStoreDatabase.settings
		//settings.prepareForInterfaceBuilder()
		//fireStoreDatabase.settings = settings
		

		fireStoreDatabase.collection("Posts").order(by: "date",descending: true)
			.addSnapshotListener { snapshot, error in
			if error != nil {
				print(error?.localizedDescription)
			}else {
				
				if snapshot?.isEmpty != true {
					
					self.userImageArray.removeAll(keepingCapacity: false)
					self.userlikeArray.removeAll(keepingCapacity: false)
					self.userEmailArray.removeAll(keepingCapacity: false)
					self.userCommentArray.removeAll(keepingCapacity: false)
					self.documentIdArray.removeAll(keepingCapacity: false)
					
					for document in snapshot!.documents {
						let documentID = document.documentID
						self.documentIdArray.append(documentID)
						//print(documentID)
						if let postedBy = document.get("postedBy" ) as? String {
							self.userEmailArray.append(postedBy)
							
						}
						if let postComment = document.get("postComment") as? String {
							self.userCommentArray.append(postComment)
							
						}
						if let likes = document.get("likes") as? Int {
							self.userlikeArray.append(likes)
						}
						if let imageUrl = document.get("imageUrl") as? String {
							self.userImageArray.append(imageUrl)
						}
						
						
					}
					self.tableView.reloadData()
				}
				
				
			}
		}
		
	}
	
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return userEmailArray.count	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for:indexPath) as! FeedCell
		cell.userEmailLabel.text = userEmailArray[indexPath.row]
		cell.likeLabel.text = String(userlikeArray[indexPath.row])
		cell.commentLabel.text = userCommentArray[indexPath.row]
		//cell.userImageView.image = UIImage(named: "mona-lisa.png")
		cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]), placeholderImage: UIImage(named:"mona-lisa.png"))
		cell.documentIdLabel.text = documentIdArray[indexPath.row] // id lere göre like sayısını tutma
		return cell
		
		
	}
    


	
	
	

}
