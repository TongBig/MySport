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
import KVOController

class LoginViewController: UIViewController, loginViewDelegte, UITextFieldDelegate {
    var phoneNum: String?
    var passWord: String?

    var headAnimationView: HeadAnimationView?
    var ballView: BallView?

    var loginView: LoginView?


    var loginViewModel: LoginViewModel?




    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        self.view.backgroundColor = UIColor.groupTableViewBackground;
        phoneNum = ""
        passWord = ""
        self.initView()
        loginViewModel = LoginViewModel()
        self.KVOHandler()

        // Do any additional setup after loading the view.
    }


    func initView() {

        headAnimationView = HeadAnimationView(frame: CGRect(x: 0, y: 64, width: self.view.width, height: 200))

        //let bounceDuration: CFTimeInterval = 0.8
        let ballSize = 28//32,
        let ballMoveTimingFunc = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        let moveUpDuration = 0.2
        let moveUpDist = 32 * 1.5
        let color: UIColor! = UIColor.white

        ballView = BallView(frame: CGRect(x: 100, y: 100, width: 80, height: 80), circleSize: CGFloat(ballSize), timingFunc: ballMoveTimingFunc, moveUpDuration: moveUpDuration, moveUpDist: CGFloat(moveUpDist), color: color)
        ballView?.startAnimation()

        loginView = LoginView(frame: CGRect(x: 0, y: (headAnimationView?.bottom)!, width: self.view.width, height: 300))
        loginView?.delegate = self
        loginView?.phoneNumTextField?.delegate = self
        loginView?.passWordTextField?.delegate = self

        self.view.addSubview(headAnimationView!)
        self.view.addSubview(ballView!)
        self.view.addSubview(loginView!)


    }



     func KVOHandler() {

        self.kvoController.observe(self.loginViewModel, keyPath: "invalid", options: .new) { (viewController, viewModel, change) in
            if (self.loginViewModel!.invalid?.boolValue)!{

                SVProgressHUD.showError(withStatus: self.loginViewModel?.invalidMsg)
                
            }
        }

        kvoController.observe(self.loginViewModel, keyPath: "netFail", options: .new) { (viewController, viewModel, change) in
            if (self.loginViewModel?.netFail?.boolValue)!{

                SVProgressHUD.showError(withStatus: "请检查网络")

            }
        }

        kvoController.observe(self.loginViewModel, keyPath: "loginSuccessOrFail", options: .new) { (viewController, viewModel, change) in
            if (self.loginViewModel?.loginSuccessOrFail?.boolValue)!{
                CoreDataManger.manager.switchToDatabase(name: (self.loginViewModel?.username)!)
                let mainVC = MainViewController()
                self.navigationController?.pushViewController(mainVC, animated: false)

            }else{

                SVProgressHUD.showError(withStatus: "密码错误")

            }
        }


    }
// MARK - delegate
    func tapBtnAction(button: UIButton) {
        let btnTag = button.tag
        if btnTag == 104 {
            
            let regVc = RegisterViewController()
            self.navigationController?.pushViewController(regVc, animated: false)


        }else if btnTag == 105{

            




        }else{

            self.loginViewModel?.username = loginView?.phoneNumTextField?.text
            self.loginViewModel?.password = loginView?.passWordTextField?.text

            loginViewModel?.login()
            
//            CoreDataManger.manager.switchToDatabase(name: phoneNum!)
//            let mainVC = MainViewController()
//            self.navigationController?.pushViewController(mainVC, animated: false)
//
//            let user = User.mr_findFirst(byAttribute: "phoneNum", withValue: phoneNum!)
//            if user == nil{
//
//                SVProgressHUD.showError(withStatus: "此账号不存在!")
//
//            }else{
//                if (user?.phoneNum == phoneNum)&&(user?.passWord == passWord) {
//
//                    let mainVC = MainViewController()
//                    self.navigationController?.pushViewController(mainVC, animated: false)
//
//                }else{
//
//                    SVProgressHUD.showError(withStatus: "手机号密码不匹配!")
//
//                }
//
//            }
        }
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
