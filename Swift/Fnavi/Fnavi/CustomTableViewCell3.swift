//
//  CustomTableViewCell3.swift
//  Fnavi
//
//  Created by 新納真次郎 on 2018/01/15.
//  Copyright © 2018年 nshhhin. All rights reserved.
//

import UIKit

class CustomTableViewCell3: UITableViewCell {

  @IBOutlet weak var userLabel: UILabel!
  @IBOutlet weak var mailLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
