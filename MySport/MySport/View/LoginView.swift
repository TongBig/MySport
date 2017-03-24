//
//  LoginView.swift
//  MySport
//
//  Created by 宇仝 on 17/3/22.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import UIKit
import SDAutoLayout

@objc public protocol loginViewDelegte:NSObjectProtocol{

    @objc optional func tapBtnAction(button:UIButton)


}

class LoginView: UIView, UITextFieldDelegate {

    weak var delegate:loginViewDelegte?
    var phoneNumTextField: UITextField?
    var passWordTextField: UITextField?
    override func layoutSubviews() {

        phoneNumTextField = UITextField(frame: .zero)
        passWordTextField = UITextField(frame: .zero)
        let loginBtn = UIButton(frame: .zero)
        let registerBtn = UIButton(frame: .zero)
        let forgetBtn = UIButton(frame: .zero)
        let phoneNumBottomLine = UIView(frame: .zero)
        let passWordNumBottomLine = UIView(frame: .zero)

        phoneNumTextField?.addSubview(phoneNumBottomLine)
        passWordTextField?.addSubview(passWordNumBottomLine)
        self.sd_addSubviews([phoneNumTextField!, passWordTextField!, loginBtn, registerBtn,forgetBtn])


        phoneNumTextField?.frame = CGRect(x: 0, y: 0, width: self.width, height: 49)
        phoneNumTextField?.textAlignment = .center
        phoneNumTextField?.clearButtonMode = .whileEditing
        phoneNumTextField?.keyboardType = .numberPad
        phoneNumTextField?.tag = 101
        phoneNumTextField?.placeholder = "输入手机号"

        phoneNumBottomLine.frame = CGRect(x: 0, y: (phoneNumTextField?.height)!, width: self.width, height: 1);
        phoneNumBottomLine.backgroundColor = UIColor.lightGray


        passWordTextField?.frame = CGRect(x: 0, y: (phoneNumTextField?.bottom)! + 30, width: self.width, height: 49)
        passWordTextField?.textAlignment = .center
        passWordTextField?.tag = 102
        passWordTextField?.isSecureTextEntry = true
        passWordTextField?.placeholder = "输入密码"

        passWordNumBottomLine.frame = CGRect(x: 0, y: (passWordTextField?.height)!, width: self.width, height: 1);
        passWordNumBottomLine.backgroundColor = UIColor.lightGray

        registerBtn.frame = CGRect(x: 10, y: (passWordTextField?.bottom)! + 10, width: 80, height: 30)
        registerBtn.tag = 104
        registerBtn.setTitle("注册", for: .normal)
        registerBtn.setTitleColor(UIColor.red
            , for: .normal)
        registerBtn.layer.cornerRadius = 3
        registerBtn.layer.masksToBounds = true
        registerBtn.layer.borderWidth = 1
        registerBtn.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        registerBtn.addTarget(self, action: #selector(tapBtnAction(button:)), for: .touchUpInside)

        forgetBtn.frame = CGRect(x: self.width - 80 - 10, y: (passWordTextField?.bottom)! + 10, width: 80, height: 30)
        forgetBtn.tag = 105
        forgetBtn.setTitle("忘记？", for: .normal)
        forgetBtn.setTitleColor(UIColor.red
            , for: .normal)
        forgetBtn.layer.cornerRadius = 3
        forgetBtn.layer.masksToBounds = true
        forgetBtn.layer.borderWidth = 1
        forgetBtn.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        forgetBtn.addTarget(self, action: #selector(tapBtnAction(button:)), for: .touchUpInside)

         loginBtn.frame = CGRect(x: (self.width - 300) / 2, y: registerBtn.bottom + 50, width: 300, height: 49)
        loginBtn.tag = 103
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(UIColor.red
            , for: .normal)
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        loginBtn.addTarget(self, action: #selector(tapBtnAction(button:)), for: .touchUpInside)





    }

    func tapBtnAction(button:UIButton)  {
        if(delegate?.responds(to: #selector(tapBtnAction(button:))))!{

            delegate?.tapBtnAction!(button: button)

        }


    }


}
