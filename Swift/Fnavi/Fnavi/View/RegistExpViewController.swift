//
//  RegistExpViewController.swift
//  Fnavi
//
//  Created by 新納真次郎 on 2018/01/14.
//  Copyright © 2018年 nshhhin. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class RegistExpViewController: UIViewController,UITextFieldDelegate {
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var abstTextField: UITextField!
  @IBOutlet weak var bonusTextField: UITextField!
  @IBOutlet weak var datePicker: UIDatePicker!
   let global = UIApplication.shared.delegate as! AppDelegate
  var experiments : [Experiment] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    titleTextField.setInputAccessoryView()
    abstTextField.setInputAccessoryView()
    bonusTextField.setInputAccessoryView()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
  }
  
  override func viewWillDisappear(_ animated: Bool) {

    super.viewWillDisappear(animated)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    for touch: UITouch in touches {
      let tag = touch.view!.tag
      if tag == 1 {
        dismiss(animated: true, completion: nil)
      }
    }
  }
  
  @IBAction func tapSubmit(_ sender: Any) {
    
    let apiURL = "http://app.m-navi.ml/api/create_exp"
    let title = titleTextField.text!
    let owner = 27
    let description = abstTextField.text!
    let date = datePicker.date
    //let date = "2018/01/11 20:00:00"
    let privilege = bonusTextField.text!
    let query = "title=\(title)&description=\(description)&owner=\(owner)&do_date=\(date)&privilege=\(privilege)"
    
    let format = DateFormatter()
    format.timeStyle = .short
    format.dateStyle = .short
    format.locale = Locale(identifier: "ja_JP")
    let str_date = format.string(from:date)
    
    let str_url = "http://app.m-navi.ml/api/create_exp?title=\(title)&description=\(description)&owner=\(owner)&do_date=\(str_date)&privilege=\(privilege)"
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
