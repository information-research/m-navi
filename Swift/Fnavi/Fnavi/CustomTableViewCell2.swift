//
//  CustomTableViewCell2.swift
//  Fnavi
//
//  Created by 新納真次郎 on 2018/01/15.
//  Copyright © 2018年 nshhhin. All rights reserved.
//

import UIKit

class CustomTableViewCell2: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var dodateLabel: UILabel!
  @IBOutlet weak var numLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
