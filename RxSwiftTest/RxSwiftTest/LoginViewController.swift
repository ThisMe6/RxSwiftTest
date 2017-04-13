//
//  LoginViewController.swift
//  RxSwiftTest
//
//  Created by 悦生活 on 2017/4/13.
//  Copyright © 2017年 ICE. All rights reserved.
//

import UIKit
import NSObject_Rx
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var accText: UITextField!
    @IBOutlet weak var pwdText: UITextField!
    @IBOutlet weak var NextBtn: UIButton!
    @IBOutlet weak var TestLabel: UILabel!
    //数据结构监听
    var textCount = Variable(0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let accObservable = accText.rx.text.orEmpty.map { $0.characters.count > 5 }.shareReplay(1)
        let pwdObservable = pwdText.rx.text.orEmpty.map { $0.characters.count > 8 }.shareReplay(1)
        
        accObservable.subscribe { [weak self] (isSucc)  in
            guard let slf = self else {
                return
            }
            if isSucc.element! {
                slf.accText.backgroundColor = UIColor.white
            } else {
                slf.accText.backgroundColor = UIColor.lightGray
            }
        }.addDisposableTo(rx_disposeBag)
        
        pwdObservable.subscribe { [weak self] (isSucc)  in
            guard let slf = self else {
                return
            }
            if isSucc.element! {
                slf.pwdText.backgroundColor = UIColor.white
            } else {
                slf.pwdText.backgroundColor = UIColor.lightGray
            }
        }.addDisposableTo(rx_disposeBag)
        
        Observable.combineLatest(accObservable, pwdObservable) { $0 && $1 }.subscribe { [weak self] (isSucc) in
            guard let slf = self else {
                return
            }
            if isSucc.element! {
                slf.NextBtn.backgroundColor = UIColor.blue
                slf.NextBtn.isEnabled = true
            } else {
                slf.NextBtn.backgroundColor = UIColor.lightGray
                slf.NextBtn.isEnabled = false
            }
            
        }.addDisposableTo(rx_disposeBag)
      
        
        
        //数据结构监听
        let textCountObservable = accText.rx.text.orEmpty.map { (text) -> Int in
            text.characters.count
        }
        textCountObservable.bindTo(textCount).addDisposableTo(rx_disposeBag)
        
        textCount.asObservable().subscribe { [weak self] (count) in
            guard let slf = self else {
                return
            }
            slf.TestLabel.text = "charCount:\(count.element!)"
        }.addDisposableTo(rx_disposeBag)
        
        //KVO
        NotificationCenter.default.rx.notification(NSNotification.Name.UIKeyboardWillShow).subscribe { (noti) in
            //获取键盘的size
            let keyboardSize = (noti.element!.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            print("==>Size: \(keyboardSize)")
        }.addDisposableTo(rx_disposeBag)
    }

    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
