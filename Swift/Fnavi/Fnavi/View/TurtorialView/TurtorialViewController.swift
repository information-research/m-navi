//
//  TurtorialViewController.swift
//  Fnavi
//
//  Created by 新納真次郎 on 2017/12/23.
//  Copyright © 2017年 nshhhin. All rights reserved.
//

import UIKit

class TurtorialViewController: UIPageViewController, UIPageViewControllerDataSource {
  
  private var pageControl: UIPageControl!
  var currentPage:Int  = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setViewControllers([getFirst()], direction: .forward, animated: true, completion: nil)
    self.dataSource = self
    
    // ビューの縦、横のサイズを取得する.
    let width = self.view.frame.maxX, height = self.view.frame.maxY
    // ページ数を定義する.
    let pageSize = 3
    
    // PageControlを作成する.
    pageControl = UIPageControl(frame: CGRect(x:0, y:self.view.frame.maxY - 100, width:width, height:50))
    
    // PageControlするページ数を設定する.
    pageControl.numberOfPages = pageSize
    
    // 現在ページを設定する.
    pageControl.currentPage = 0
    pageControl.isUserInteractionEnabled = false
    
    self.view.addSubview(pageControl)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func getFirst() -> FirstViewController {
    print("getFirst()")
    return storyboard!.instantiateViewController(withIdentifier: "FirstView") as! FirstViewController
  }
  
  func getSecond() -> SecondViewController {
    print("getSecond()")
    return storyboard!.instantiateViewController(withIdentifier: "SecondView") as! SecondViewController
  }
  
  func getThird() -> ThirdViewController {
    print("getThird()")
    return storyboard!.instantiateViewController(withIdentifier: "ThirdView") as! ThirdViewController
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
    if viewController.isKind(of: ThirdViewController.self) {
      pageControl.currentPage = currentPage
      return getSecond()
    } else if viewController.isKind(of:SecondViewController.self) {
      // 2 -> 1
      pageControl.currentPage = currentPage
      return getFirst()
    } else {
      // 1 -> end of the road
      return nil
    }
    
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    if viewController.isKind(of: FirstViewController.self){
      // 1 -> 2
      pageControl.currentPage = currentPage
      return getSecond()
    } else if viewController.isKind(of: SecondViewController.self) {
      // 2 -> 3
      pageControl.currentPage = currentPage
      return getThird()
    } else {
      // 3 -> end of the road
      
      return nil
    }
  }
}


