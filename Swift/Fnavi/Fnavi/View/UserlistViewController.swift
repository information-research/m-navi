//
//  UserlistViewController.swift
//  Fnavi
//
//  Created by 新納真次郎 on 2018/01/15.
//  Copyright © 2018年 nshhhin. All rights reserved.
//

import UIKit

class UserlistViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
  
  var experiment: Experiment!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
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
  
  /// セルの個数を指定するデリゲートメソッド（必須）
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return experiment.count
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  // セルにボタン表示する時に参考になりそう（http://joyplot.com/documents/2016/11/11/swift-uitableview/）
  //セルに表示する文字列を設定する
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! CustomTableViewCell3
    // セルに値を設定
    cell.userLabel.text = "しゅんき"
    cell.mailLabel.text = "ttysynki@gmail.com"
    return cell
  }
  
}
