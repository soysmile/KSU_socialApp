//
//  ViewController.swift
//  FirebaseDemo
//
//  Created by George Heints on 22.03.2018.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import UIKit
import Firebase
import Pastel

class MenuViewController: UIViewController {

    var users = [Users]()

    @IBOutlet weak var khersonStateLabel: UILabel!
    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()

    }


    //
    func setCourse() {
        guard let uid = Auth.auth().currentUser?.uid else {
            //for some reason uid = nil
            return
        }

        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in

            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = Users(dictionary: dictionary)

            }

        }, withCancel: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        //Dynamic gradient
        let pastelView = PastelView(frame: view.bounds)

        //MARK: -  Custom Direction

        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight

        //MARK: -  Custom Duration

        pastelView.animationDuration = 3.0

        //MARK: -  Custom Color

        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                              UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])

        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
    }

    //Save user as User and set up data
    func saveProfileAsUser(completion: @escaping ((_ success:Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let creationDate = Auth.auth().currentUser?.metadata.creationDate else { return }
        let databaseRef = Database.database().reference().child("users/\(uid)")
        print(creationDate)
        let userObject = [
            "role": "user",
            "creationDate" : "\(creationDate)"
            ] as [String:Any]
        
        databaseRef.updateChildValues(userObject) { error, ref in
            completion(error == nil)
        }
    }

    //Save user as Guest and set up data
    func saveProfileAsGuest(completion: @escaping ((_ success:Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let creationDate = Auth.auth().currentUser?.metadata.creationDate else { return }
        let databaseRef = Database.database().reference().child("users/\(uid)")
        let userObject = [
            "role": "guest",
            "creationDate" : "\(creationDate)"
            ] as [String:Any]
        
        databaseRef.updateChildValues(userObject) { error, ref in
            completion(error == nil)
        }
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = Auth.auth().currentUser {
            
            let userID = Auth.auth().currentUser!.uid
            
            //Show user ID to console
            print("userID: \(userID)")
            let ref = Database.database().reference().child("users").child(userID)
            
            if let user = Auth.auth().currentUser {
                
                ref.observe(.value, with: { (snapshot) in
                    
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        let userR = Users(dictionary: dictionary)
                        userR.id = snapshot.key
                        self.users.append(userR)
                        let isAdmin = "admin"
                        let isUser = "user"
                        var role = ""
                        let currentUser = Auth.auth().currentUser!.uid
                        let emailExist = user.email
                        var emailArray = [NSMutableArray]()
                        
                        //this will crash because of background thread, so lets use dispatch_async to fix
                        DispatchQueue.main.async(execute: {
                            //self.tableView.reloadData()
                        })
                        Auth.auth().addStateDidChangeListener { auth, user in
                            Auth.auth().currentUser?.reload()
                            if let user = user {
                                
                                // Email Verified
                                if user.isEmailVerified {
                                    
                                    //Get user role
                                    role = userR.role!
                                    
                                    //If email exists in Administration Database
                                    let refEmail = Database.database().reference().child("registeredEmailList")
                                    refEmail.observe(.value, with: { (snapshotEmail) in
                                        
                                        if let emailDictionary = snapshotEmail.value as? [String: AnyObject]{
                                            var emails = emailDictionary["email"] as? [String]
                                            if (emails?.contains(emailExist!))!{
                                                
                                                //Change role request
                                                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                                                changeRequest?.commitChanges { error in
                                                    if error == nil {
                                                                                                                
                                                        self.saveProfileAsUser() { success in
                                                            if success {
                                                                
                                                                print("Операция успешно завершена, вы Пользователь")
                                                            } else {
                                                                
                                                                print("Что то пошло не так")
                                                            }
                                                        }
                                                        
                                                    } else {
                                                        print("Error: \(error!.localizedDescription)")
                                                    }
                                                }
                                                
                                                self.performSegue(withIdentifier: "toHomeScreen", sender: self)
                                                print("\nПользователь существует в базе данных\n")
                                            }else{
                                                
                                                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                                                changeRequest?.commitChanges { error in
                                                    if error == nil {
                                                        
                                                        self.saveProfileAsGuest() { success in
                                                            if success {

                                                                print("Операция успешно завершена, вы Гость")
                                                            } else {
                                                                
                                                                print("Что то пошло не так")
                                                            }
                                                        }
                                                        
                                                    } else {
                                                        print("Error: \(error!.localizedDescription)")
                                                    }
                                                }
                                                
                                                self.performSegue(withIdentifier: "toHomeScreen", sender: self)
                                                print("\nПользователь не внесен в базу данных, получает статус Абитуриент(Guest)\n")
                                            }
                                        }
                                    })

                                } else {

                                }
                                
                            } else {

                            }
                            
                        }
                        
                        
                    }
                    
                }, withCancel: nil)
            //
            
            
        }
    }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
}
