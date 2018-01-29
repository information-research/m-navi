//
//  CustomTableViewCell.swift
//  Fnavi
//
//  Created by 新納真次郎 on 2018/01/14.
//  Copyright © 2018年 nshhhin. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

  @IBOutlet weak var iconView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var ownerLabel: UILabel!
  @IBOutlet weak var dodateLabel: UILabel!
  @IBOutlet weak var abstLabel: UILabel!
  @IBOutlet weak var bonusLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
