//
//  RegisterView.swift
//  MySport
//
//  Created by 宇仝 on 17/3/23.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import UIKit

@objc public protocol registerViewDelegte:NSObjectProtocol{

    @objc optional func tapBtnAction(button:UIButton)
    
    
}
class RegisterView: UIView {
    weak var delegate:registerViewDelegte?
    var phoneNumTextField: UITextField?
    var passWordTextField: UITextField?
    var rePassWordTextField: UITextField?


    override func layoutSubviews() {
        phoneNumTextField = UITextField(frame: .zero)
        passWordTextField = UITextField(frame: .zero)
        rePassWordTextField = UITextField(frame: .zero)


        let doneBtn = UIButton(frame: .zero)
        let phoneNumBottomLine = UIView(frame: .zero)
        let passWordBottomLine = UIView(frame: .zero)
        let rePassWordBottomLine = UIView(frame: .zero)


        phoneNumTextField?.addSubview(phoneNumBottomLine)
        passWordTextField?.addSubview(passWordBottomLine)
        rePassWordTextField?.addSubview(rePassWordBottomLine)
        self.sd_addSubviews([phoneNumTextField!, passWordTextField!, rePassWordTextField!,doneBtn])

        phoneNumTextField?.frame = CGRect(x: 0, y: 0, width: self.width, height: 49)
        phoneNumTextField?.textAlignment = .center
        phoneNumTextField?.keyboardType = .numberPad
        phoneNumTextField?.tag = 101
        phoneNumTextField?.placeholder = "输入手机号"

        phoneNumBottomLine.frame = CGRect(x: 0, y: (phoneNumTextField?.height)!, width: self.width, height: 1);
        phoneNumBottomLine.backgroundColor = UIColor.lightGray


        passWordTextField?.frame = CGRect(x: 0, y: (phoneNumTextField?.bottom)! + 30, width: self.width, height: 49)
        passWordTextField?.tag = 102
        passWordTextField?.textAlignment = .center
        passWordTextField?.isSecureTextEntry = true
        passWordTextField?.placeholder = "输入密码"

        passWordBottomLine.frame = CGRect(x: 0, y: (passWordTextField?.height)!, width: self.width, height: 1);
        passWordBottomLine.backgroundColor = UIColor.lightGray

        rePassWordTextField?.frame = CGRect(x: 0, y: (passWordTextField?.bottom)! + 30, width: self.width, height: 49)
        rePassWordTextField?.tag = 103
        rePassWordTextField?.textAlignment = .center
        rePassWordTextField?.isSecureTextEntry = true
        rePassWordTextField?.placeholder = "确认密码"

        rePassWordBottomLine.frame = CGRect(x: 0, y: (rePassWordTextField?.height)!, width: self.width, height: 1);
        rePassWordBottomLine.backgroundColor = UIColor.lightGray


        doneBtn.frame = CGRect(x: (self.width - 300) / 2, y: (rePassWordTextField?.bottom)! + 50, width: 300, height: 49)
        doneBtn.tag = 104
        doneBtn.setTitle("确定", for: .normal)
        doneBtn.setTitleColor(UIColor.red
            , for: .normal)
        doneBtn.layer.cornerRadius = 5
        doneBtn.layer.masksToBounds = true
        doneBtn.layer.borderWidth = 1
        doneBtn.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        doneBtn.addTarget(self, action: #selector(tapBtnAction(button:)), for: .touchUpInside)


    }

    func tapBtnAction(button:UIButton)  {
        if(delegate?.responds(to: #selector(tapBtnAction(button:))))!{

            delegate?.tapBtnAction!(button: button)

        }
        
        
    }

    
}
