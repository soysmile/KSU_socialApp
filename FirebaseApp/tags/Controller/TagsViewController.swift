//
//  TagsViewController.swift
//  FirebaseApp
//
//  Created by George Heints on 9/28/18.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import UIKit
import Firebase

class TagsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func switchAction(_ sender: UISwitch) {
        var label = myCallList[sender.tag]

        if sender.isOn{
            scheduleSetup(subject: label.type!, state: "true")
            UserDefaults.standard.set(true, forKey: "\(label.type!)")
        }else{
            scheduleSetup(subject: label.type!, state: "false")
            UserDefaults.standard.set(false, forKey: "\(label.type!)")
        }
    }
    func scheduleSetup(subject: String, state: String) {

        guard let uid = Auth.auth().currentUser?.uid else {
            //for some reason uid = nil
            return
        }

        let root = Database.database().reference().child("tag").child("tags").child("\(subject)").child("users")

        let post = ["\(uid)": "\(state)"
        ]

        let childUpdates = post
        root.updateChildValues(childUpdates)
    }


    var ref:DatabaseReference!
    var myCallList = [Calls]()
    func updateTagFirebase(){
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        print(myCallList.count)
        return myCallList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "tagCell", for: indexPath) as! TagsTableViewCell
        let _tag = myCallList[indexPath.row]
        cell.tagLabel?.text = _tag.type
        cell.tagSwitch.tag = indexPath.row

        let state = UserDefaults.standard.bool(forKey: "\(_tag.type!)")
        if state == true {
            cell.tagSwitch.isOn = true
        }else{
            cell.tagSwitch.isOn = false
        }

        return cell
    }


    @IBOutlet weak var tagsTableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadCalls()
        loadData()
        tagsTableView.delegate = self
        tagsTableView.dataSource = self
        tagsTableView.allowsSelection = false

    }
    func loadData(){
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        self.myCallList.removeAll()
        ref.child("tag").child("tags").observe(.childAdded, with: { (snapshot) in
            if snapshot != nil{
                var tagType = snapshot.key as? String
                let myCalls = Calls(type: tagType)
                self.myCallList.append(myCalls)
                print(self.myCallList.count)
                DispatchQueue.main.async {
                    self.tagsTableView.reloadData()
                }
            }
        })
    }

    func userTags(){
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        let query = ref.child("tag").queryOrdered(byChild: "tags")
        query.observe(.value) {
            (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let value = snapshot.value as? NSDictionary
                let firstname = value?["tags"] as? [String]
                
                print(firstname)
            }
        }
    }
    
    func loadCalls() {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        self.myCallList.removeAll()
        ref.child("tags").child("\(userID)").observe(.childAdded, with: { (snapshot) in
            if snapshot != nil{
                var tagType = snapshot.key as? String
                let myCalls = Calls(type: tagType)
                self.myCallList.append(myCalls)
                print(self.myCallList.count)
                DispatchQueue.main.async {
                    self.tagsTableView.reloadData()
                }
            }
        })
    }

}
