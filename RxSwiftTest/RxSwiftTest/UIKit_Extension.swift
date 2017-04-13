//
//  UIKit_Extension.swift
//  RxSwiftTest
//
//  Created by 悦生活 on 2017/4/13.
//  Copyright © 2017年 ICE. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

extension UIView {
    var ex_validState:AnyObserver<Bool>{
        return UIBindingObserver(UIElement: self) { view, valid in
            view.backgroundColor = valid ? UIColor.red:UIColor.cyan
            }.asObserver()
    }
}
