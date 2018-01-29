//
//  ConfirmViewController.swift
//  Fnavi
//
//  Created by 新納真次郎 on 2018/01/14.
//  Copyright © 2018年 nshhhin. All rights reserved.
//

import UIKit
import SwiftyJSON

class ConfirmViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var ownerLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var abstLabel: UILabel!
  @IBOutlet weak var bonusLabel: UILabel!
  let global = UIApplication.shared.delegate as! AppDelegate
  var userName: String!
  
  var experiment: Experiment!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    userName = global.userId
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    titleLabel.text = experiment.title
    ownerLabel.text = experiment.owner
    dateLabel.text = experiment.dodate
    abstLabel.text = experiment.abstruct
    bonusLabel.text = experiment.bonus
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func tapCancel(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func tapAgree(_ sender: Any) {
    
    if experiment != nil {
      let exp_id = experiment.id
      let user_id = userName
      let str_url = "http://app.m-navi.ml/api/join_exp?exp_id=\(exp_id)&user_id=\(user_id!)"
      print(str_url)
      let encord_url = str_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
      
      guard let url = URL(string: encord_url! ) else {
        print("無効なURL")
        return
      }
      
      let task = URLSession.shared.dataTask(with: url) { data, response, error in
        
        if let jsonData = data {
          do {
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            let result = JSON(json)
            print(result["result"])
            self.dismiss(animated: true, completion: nil)
          }
          catch {
            self.dismiss(animated: true, completion: nil)
          }
        }
      }
      task.resume()
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    for touch: UITouch in touches {
      let tag = touch.view!.tag
      if tag == 2 {
        dismiss(animated: true, completion: nil)
      }
    }
  }
  
}
