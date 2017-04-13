//
//  ViewController.swift
//  RxSwiftTest
//
//  Created by 悦生活 on 2017/4/13.
//  Copyright © 2017年 ICE. All rights reserved.
//

import UIKit
import NSObject_Rx
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var testSwitch: UISwitch!
    @IBOutlet weak var changeColorSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//MARK: -----简单绑定
//        testSwitch.rx.value.bindTo(blueView.rx.isHidden).addDisposableTo(rx_disposeBag)
        // or
        let switchObservable =  testSwitch.rx.value.map{$0 == false}
        switchObservable.bindTo(blueView.rx.isHidden).addDisposableTo(rx_disposeBag)

//MARK: -----自定义属性绑定
        changeColorSwitch.isOn = false
        changeColorSwitch.rx.value.bindTo(blueView.ex_validState).addDisposableTo(rx_disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

