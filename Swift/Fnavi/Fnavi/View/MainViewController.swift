//
//  ViewController.swift
//  Fnavi
//
//  Created by 新納真次郎 on 2017/12/18.
//  Copyright © 2017年 nshhhin. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

let fnaviURL = "http://app.m-navi.ml/"

struct Experiment {
  var id: Int
  var title: String
  var owner: String
  var dodate: String
  var abstruct: String
  var bonus: String
  var count: Int
}

class MainViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {
  
  @IBOutlet weak var tableView: UITableView!
  var experiments: [Experiment] = []
  let global = UIApplication.shared.delegate as! AppDelegate
  
  override func viewDidLoad() {
    print("mainView")
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear( animated )
    tableView.dataSource = self as UITableViewDataSource   //追加
    tableView.delegate = self as UITableViewDelegate // 追加
    reloadTable()
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  /// セルの個数を指定するデリゲートメソッド（必須）
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return experiments.count

  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    tableView.deselectRow(at: indexPath, animated: true)
    let next = self.storyboard!.instantiateViewController(withIdentifier: "ConfirmView") as! ConfirmViewController
    next.modalTransitionStyle = .crossDissolve
    print(experiments.count)
    next.experiment = experiments[experiments.count-indexPath.row-1]
    self.present(next,animated: true, completion: nil)
  }
  
  // セルにボタン表示する時に参考になりそう（http://joyplot.com/documents/2016/11/11/swift-uitableview/）
  //セルに表示する文字列を設定する
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! CustomTableViewCell
    // セルに値を設定
    cell.titleLabel.text = experiments[experiments.count-indexPath.row-1].title
    cell.ownerLabel.text = experiments[experiments.count-indexPath.row-1].owner
    cell.dodateLabel.text = experiments[experiments.count-indexPath.row-1].dodate
    cell.abstLabel.text = experiments[experiments.count-indexPath.row-1].abstruct
    cell.bonusLabel.text = experiments[experiments.count-indexPath.row-1].bonus
//    cell.selectionStyle = UITableViewCellSelectionStyle.none
//    cell.backgroundColor = UIColor.lightGray
    return cell
  }
  
  @IBAction func tapReload(_ sender: Any) {
    reloadTable()
  }
  
  func reloadTable(){
    experiments = []
    
    guard let url = URL(string: "http://app.m-navi.ml/api/get_exp/") else {
      print("無効なURL")
      return
    }
    
    let task = URLSession.shared.dataTask(with: url){ data, response, error in
      if let jsonData = data {
        do {
          print("入った")
          let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
          let exp_array = JSON(json)
          for exp in exp_array.array! {
            let id = exp["id"].int!
            let title = exp["title"].string!
            let owner = exp["owner"].int!
            let dodate = exp["do_date"].string!
            let abstruct = exp["description"].string!
            let bonus = exp["privilege"].string!
            self.experiments.append( Experiment(id: id, title: title, owner: String(owner), dodate: dodate, abstruct: abstruct, bonus: bonus, count:0) )
          }
          self.tableView.reloadData()
        }
        catch {
          print("parse error!")
        }
      }
    }
    task.resume()
  }
  
}

