//
//  RegisterViewController.swift
//  MySport
//
//  Created by 宇仝 on 17/3/23.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import UIKit
import SDAutoLayout
import SVProgressHUD

class RegisterViewController: UIViewController, registerViewDelegte, UITextFieldDelegate {

    var phoneNum: String?
    var passWord: String?
    var userName: String?



    var registerView: RegisterView?
    var backgroundView: UIView?

    var registerViewModel: RegisterViewModel?



    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
        phoneNum = ""
        passWord = ""
        self.registerViewModel = RegisterViewModel();
        self.KVOHandler()
        self.initView()
        // Do any additional setup after loading the view.
    }


    func initView() {
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height - 64))
        backgroundView?.backgroundColor = UIColor.white

        registerView = RegisterView(frame: CGRect(x: 0, y: 64, width: self.view.width, height: self.view.height))
        registerView?.delegate = self

        self.view.addSubview(backgroundView!)
        self.view.addSubview(registerView!)

    }

    func tapBtnAction(button: UIButton) {
        SVProgressHUD.show()
        self.registerViewModel?.username = registerView?.phoneNumTextField?.text
        self.registerViewModel?.password = registerView?.passWordTextField?.text
        self.registerViewModel?.realName = registerView?.userNameTextField?.text
        self.registerViewModel?.againPassword = registerView?.rePassWordTextField?.text
        self.registerViewModel?.Register()
        SVProgressHUD.dismiss()

//        let user = User.mr_find(byAttribute: "phoneNum", withValue: phoneNum!)
//        if user?.count == 0{
//            phoneNum = registerView?.phoneNumTextField?.text
//            passWord = registerView?.passWordTextField?.text
//
//            let dic:NSMutableDictionary = [:]
//            dic.setObject(phoneNum!, forKey: "phoneNum" as NSCopying)
//            dic.setObject(passWord!, forKey: "passWord" as NSCopying)
//            dic.setObject("我的", forKey:"name" as NSCopying)
//            CoreDataManger.addUser(dic: dic, completionHandler: { (contextDidSave, error) in
//                if error == nil{
//
//                    SVProgressHUD.showSuccess(withStatus: "注册成功")
//                    self.navigationController?.dismiss(animated: true, completion: nil)
//
//                }
//                
//            })
//
//
//
//        }else{
//
//            print("用户存在！")
//
//
//        }




    }


    func KVOHandler(){

        kvoController.observe(registerViewModel, keyPath: "invalid", options: .new) { (viewController, viewModel, change) in
            if (self.registerViewModel!.invalid?.boolValue)!{

                SVProgressHUD.showError(withStatus: self.registerViewModel?.invalidMsg)
                
            }
            
        }

        kvoController.observe(registerViewModel, keyPath: "netFail", options: .new) { (viewController, viewModel, change) in
            if (self.registerViewModel?.netFail?.boolValue)!{

                SVProgressHUD.showError(withStatus: "请检查网络")

            }
        }

        kvoController.observe(self.registerViewModel, keyPath: "registerSuccessOrFail", options: .new) { (viewController, viewModel, change) in
            if (self.registerViewModel?.registerSuccessOrFail?.boolValue)!{

                let loginVC = LoginViewController()
                self.navigationController?.pushViewController(loginVC, animated: false)

            }else{

                SVProgressHUD.showError(withStatus: "密码错误")
                
            }
        }





    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
