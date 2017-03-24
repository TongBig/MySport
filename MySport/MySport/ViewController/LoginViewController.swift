//
//  LoginViewController.swift
//  MySport
//
//  Created by 宇仝 on 17/3/22.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import UIKit
import SDAutoLayout
import SVProgressHUD

class LoginViewController: UIViewController, loginViewDelegte, UITextFieldDelegate {
    var phoneNum: String?
    var passWord: String?

    var headAnimationView: HeadAnimationView?
    var loginView: LoginView?



    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        self.view.backgroundColor = UIColor.white
        phoneNum = ""
        passWord = ""
        self.initView()

        // Do any additional setup after loading the view.
    }


    func initView() {

        headAnimationView = HeadAnimationView(frame: CGRect(x: 0, y: 64, width: self.view.width, height: 200))

        loginView = LoginView(frame: CGRect(x: 0, y: (headAnimationView?.bottom)!, width: self.view.width, height: 300))
        loginView?.delegate = self
        loginView?.phoneNumTextField?.delegate = self
        loginView?.passWordTextField?.delegate = self

        self.view.addSubview(headAnimationView!)
        self.view.addSubview(loginView!)



    }
// MARK - delegate
    func tapBtnAction(button: UIButton) {
        let btnTag = button.tag
        if btnTag == 104 {
            
            let regVc = RegisterViewController()
            self.navigationController?.pushViewController(regVc, animated: false)


        }else if btnTag == 105{

            




        }else{

            phoneNum = loginView?.phoneNumTextField?.text
            passWord = loginView?.passWordTextField?.text

            let user = User.mr_findFirst(byAttribute: "phoneNum", withValue: phoneNum!)
            if user == nil{

                SVProgressHUD.showError(withStatus: "此账号不存在!")

            }else{
                if (user?.phoneNum == phoneNum)&&(user?.passWord == passWord) {

                    let mainVC = MainViewController()
                    self.navigationController?.pushViewController(mainVC, animated: false)

                }else{

                    SVProgressHUD.showError(withStatus: "手机号密码不匹配!")

                }

            }
        }
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
