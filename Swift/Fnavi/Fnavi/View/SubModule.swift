//
//  SubModule.swift
//  Fnavi
//
//  Created by 新納真次郎 on 2018/01/03.
//  Copyright © 2018年 nshhhin. All rights reserved.
//

import Foundation
import UIKit


extension UITextField {
  
  func setInputAccessoryView() {
    let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
    kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
    kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
    // スペーサー
    let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,
                                 target: self, action: nil)
    // 完了ボタン
    let commitButton = UIBarButtonItem(
      title: "完了",
      style: .done,
      target: self,
      action: #selector(self.commitButtonTapped(sender:))
    )
    kbToolBar.items = [spacer, commitButton]
    self.inputAccessoryView = kbToolBar
  }
  @objc func commitButtonTapped(sender: Any) {
    self.resignFirstResponder()
  }
}

extension UITextView {
  
  func setInputAccessoryView() {
    let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
    kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
    kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
    // スペーサー
    let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,
                                 target: self, action: nil)
    // 完了ボタン
    let commitButton = UIBarButtonItem(
      title: "完了",
      style: .done,
      target: self,
      action: #selector(self.commitButtonTapped(sender:))
    )
    kbToolBar.items = [spacer, commitButton]
    self.inputAccessoryView = kbToolBar
  }
  @objc func commitButtonTapped(sender: Any) {
    self.resignFirstResponder()
  }
}

//CSVファイルの読み込みメソッド。引数にファイル名、返り値にString型の配列。
func loadCSV(filename:String)->[String]{
  //CSVファイルを格納するための配列を作成
  var csvArray:[String] = []
  //CSVファイルの読み込み
  let csvBundle = NSHomeDirectory() + "/Documents/" + filename + ".csv"
  
  do {
    //csvBundleのパスを読み込み、UTF8に文字コード変換して、NSStringに格納
    let csvData = try String(contentsOfFile: csvBundle,
                             encoding: String.Encoding.utf8)
    //改行コードが"\r"で行なわれている場合は"\n"に変更する
    let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
    //"\n"の改行コードで区切って、配列csvArrayに格納する
    csvArray = lineChange.components(separatedBy: "\n")
  }
  catch {
    print("エラー")
  }
  return csvArray
}

//CSVファイル保存メソッド
func saveCSV( lines: [String], filename: String ) {
  print("saveCSV")
  //改行区切りで配列を連結する。
  let outputStr = lines.joined(separator: "\n")
  let filePath = NSHomeDirectory() + "/Documents/" + filename + ".csv"

  print(filePath)

  do {
    //ファイルを出力する。
    try outputStr.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8 )
    
  } catch {
    print("catch")
    print(error)
  }
}

