//
//  TagMessageViewController.swift
//  FirebaseApp
//
//  Created by George Heints on 10/14/18.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class TagMessageViewController: UIViewController {

    private let db = Firestore.firestore()
    private var channelReference: CollectionReference {
        return db.collection("channels")
    }

    @IBAction func segmentedControlAction(_ sender: Any) {
    }
    @IBAction func createButtonAction(_ sender: Any) {

        guard let uid = Auth.auth().currentUser?.uid else { return
        }
        if newTagTextField.text != ""{
            let root = Database.database().reference().child("tag").child("tags")
            let post = ["\(uid)": "true"]
            let childUpdates = ["/\(newTagTextField.text!)/users/": post
            ]
            root.updateChildValues(childUpdates)
            UserDefaults.standard.set(true, forKey: "\(newTagTextField.text!)")

            //
            guard let channelName = self.newTagTextField.text else {
                return
            }

            //Create chanell
            let channel = Channel(name: channelName)
            channelReference.addDocument(data: channel.representation) { error in
                if let e = error {
                    print("Error saving channel: \(e.localizedDescription)")
                }
            }

            self.dismiss(animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "⚠️", message: "Заполните поле тег", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var newTagTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "✖️", style: .done, target: self, action: #selector(closePop))
    }

    @objc func closePop(){
        self.dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

}
