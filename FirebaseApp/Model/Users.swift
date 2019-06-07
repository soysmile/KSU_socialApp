//
//  User.swift
//  FirebaseApp
//
//  Created by George Heints on 22.03.2018.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import Foundation
import Firebase

class Users: NSObject {
    var group: String?
    var isLeader: String?
    var id: String?
    var name: String?
    var login: String?
    var email: String?
    var profileImageUrl: String?
    var role: String?
    var isOnline: String?
    var creationDate: String?
    var course: String?
    var password: String?
    var job: String?
    var telNumber: String?
    var birthDate: String?
    init(dictionary: [String: AnyObject]) {
        self.isLeader = dictionary["isLeader"] as? String
        self.group = dictionary["group"] as? String
        self.birthDate = dictionary["birthDate"] as? String
        self.telNumber = dictionary["telNumber"] as? String
        self.job = dictionary["job"] as? String
        self.password = dictionary["password"] as? String
        self.isOnline = dictionary["isOnline"] as? String
        self.course = dictionary["course"] as? String
        self.creationDate = dictionary["creationDate"] as? String
        self.id = dictionary["userID"] as? String
        self.name = dictionary["name"] as? String
        self.login = dictionary["username"] as? String
        self.email = dictionary["email"] as? String
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
        self.role = dictionary["role"] as? String
    }
}

