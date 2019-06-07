//
//  TagsTableViewCell.swift
//  FirebaseApp
//
//  Created by George Heints on 9/28/18.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import UIKit

class TagsTableViewCell: UITableViewCell {

    var callBack: ((String,String)->Void)?

    @IBOutlet weak var tagSwitch: UISwitch!
    @IBOutlet weak var tagLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
