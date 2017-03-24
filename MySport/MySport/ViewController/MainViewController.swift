//
//  MainViewController.swift
//  MySport
//
//  Created by 宇仝 on 17/3/23.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var backgroundView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "主页"

        // Do any additional setup after loading the view.
    }

    func initView() {

        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height - 64))
        backgroundView?.backgroundColor = UIColor.white
        self.view.addSubview(backgroundView!)

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
