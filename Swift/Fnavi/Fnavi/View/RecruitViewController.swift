//
//  RecruitViewController.swift
//  Fnavi
//
//  Created by 新納真次郎 on 2018/01/14.
//  Copyright © 2018年 nshhhin. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class RecruitViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  var experiments : [Experiment] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    // Do any additional setup after loading the view.
    tableView.dataSource = self as UITableViewDataSource   //追加
    tableView.delegate = self as UITableViewDelegate // 追加
    reloadTable()
  }
  
  /// セルの個数を指定するデリゲートメソッド（必須）
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return experiments.count
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    tableView.deselectRow(at: indexPath, animated: true)
    let next = self.storyboard!.instantiateViewController(withIdentifier: "UserlistView") as! UserlistViewController
    next.modalTransitionStyle = .crossDissolve
    print(experiments.count)
    next.experiment = experiments[experiments.count-indexPath.row-1]
    self.present(next,animated: true, completion: nil)
  }
  
  // セルにボタン表示する時に参考になりそう（http://joyplot.com/documents/2016/11/11/swift-uitableview/）
  //セルに表示する文字列を設定する
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! CustomTableViewCell2
    // セルに値を設定
    cell.titleLabel.text = experiments[experiments.count-indexPath.row-1].title
    cell.dodateLabel.text = experiments[experiments.count-indexPath.row-1].dodate
    return cell
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func tapAdd(_ sender: Any) {
    let next = self.storyboard!.instantiateViewController(withIdentifier: "RegistExpView")
    next.modalTransitionStyle = .crossDissolve
    self.present(next,animated: true, completion: nil)
  }
  
  func reloadTable(){
    experiments = []
    Alamofire.request("http://app.m-navi.ml/api/get_exp", encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
      switch response.result {
      case .success:
        let json:JSON = JSON(response.result.value ?? kill)
        for exp in json.array! {
          print()
          if exp["owner"] == 27 {
            print(exp)
            let id = exp["id"].int!
            let title = exp["title"].string!
            let owner = exp["owner"].int!
            let dodate = exp["do_date"].string!
            let abstruct = exp["description"].string!
            let bonus = exp["privilege"].string!
            
            Alamofire.request("http://app.m-navi.ml/api/get_participants/\(id.self)", encoding: JSONEncoding.default).responseJSON(completionHandler: { response2 in
              switch response2.result {
              case .success:
                let json2:JSON = JSON(response2.result.value ?? kill)
                self.experiments.append( Experiment(id: id, title: title, owner: String(owner), dodate: dodate, abstruct: abstruct, bonus: bonus, count: json2.array!.count) )
                
                self.tableView.reloadData()
              case .failure(let error2):
                print(error2)
              }
            })
            
            
          }
        }
      case .failure(let error):
        print(error)
      }
    })
  }
  
}
