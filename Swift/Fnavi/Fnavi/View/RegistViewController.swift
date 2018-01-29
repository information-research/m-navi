//
//  RegistViewController.swift
//  Fnavi
//
//  Created by 新納真次郎 on 2018/01/03.
//  Copyright © 2018年 nshhhin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegistViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var NoSelectAlertView: UIView!
  @IBOutlet weak var userNameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  let global = UIApplication.shared.delegate as! AppDelegate
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("RegistView")
    userNameTextField.setInputAccessoryView()
    emailTextField.setInputAccessoryView()
    passwordTextField.setInputAccessoryView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    // Document内に"data.csv"があるかを確認
    let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    if( FileManager.default.fileExists( atPath: documentPath + "/data.csv" ) ){
      print("ファイルあり")
      let csv_lines = loadCSV(filename: "data")
      let line1 = csv_lines[0].components(separatedBy: "=")
      let isFirstloaded = line1[1]
      let line2 = csv_lines[1].components(separatedBy: "=")
      let userName:String! = line2[1]
      print(isFirstloaded, userName)
      if isFirstloaded == "true" {
        print("はじめての読み込み")
      }
      else{
        global.userId = userName
        let next = self.storyboard!.instantiateViewController(withIdentifier: "MainView")
        next.modalTransitionStyle = .crossDissolve
        self.present(next,animated: true, completion: nil)
      }
    } else {
      print("ファイルなし")
      saveCSV(lines: ["isFirstloaded=true","userName=nil"], filename: "data")
    }
  }
  
  @IBAction func tapImage(_ sender: Any) {
    // カメラロールが利用可能か？
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
      // 写真を選ぶビュー
      let pickerView = UIImagePickerController()
      // 写真の選択元をカメラロールにする
      // 「.camera」にすればカメラを起動できる
      pickerView.sourceType = .photoLibrary
      // デリゲート
      pickerView.delegate = self
      // ビューに表示
      self.present(pickerView, animated: true)
    }
  }

  // 写真を選んだ後に呼ばれる処理
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    // 選択した写真を取得する
    let image = info[UIImagePickerControllerOriginalImage] as! UIImage
    NoSelectAlertView.isHidden = true
    // ビューに表示する
    self.imageView.image = image
    // 写真を選ぶビューを引っ込める
    self.dismiss(animated: true)
  }
  
  // 写真をリセットする処理
  @IBAction func resetPicture() {
    // アラートで確認
    let alert = UIAlertController(title: "確認", message: "画像を初期化してもよいですか？", preferredStyle: .alert)
    let okButton = UIAlertAction(title: "OK", style: .default, handler:{(action: UIAlertAction) -> Void in
      // デフォルトの画像を表示する
      self.imageView.image = UIImage(named: "default.png")
    })
    let cancelButton = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
    // アラートにボタン追加
    alert.addAction(okButton)
    alert.addAction(cancelButton)
    // アラート表示
    present(alert, animated: true, completion: nil)
  }
  // 以下キーボードで隠さないようにするためのコード
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func registBtn(_ sender: Any) {
    let userName = userNameTextField.text!
    let email = emailTextField.text!
    let pass = passwordTextField.text!
    let url = "http://app.m-navi.ml/api/create_user?user_id=\(userName)&password=\(pass)&first_name=\(userName)&last_name=\(userName)&mail_address=\(email)"
    let encord_url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    Alamofire.request(encord_url!, encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
      switch response.result {
      case .success:
        let json:JSON = JSON(response.result.value ?? kill)
        print(json["result"])
        saveCSV(lines: ["isFirstloaded=false","userName=\(userName)"], filename: "data")
        self.global.userId = userName
        let next = self.storyboard!.instantiateViewController(withIdentifier: "MainView")
        next.modalTransitionStyle = .crossDissolve
        self.present(next,animated: true, completion: nil)
      case .failure(let error):
        print(error)
      }
    })
  }
}
