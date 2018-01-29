//
//  ThirdViewController.swift
//  Fnavi
//
//  Created by 新納真次郎 on 2017/12/23.
//  Copyright © 2017年 nshhhin. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  @IBAction func tapEnterBtn(_ sender: Any) {
    let next = self.storyboard!.instantiateViewController(withIdentifier: "RegistView")
    next.modalTransitionStyle = .crossDissolve
    self.present(next,animated: true, completion: nil)
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
