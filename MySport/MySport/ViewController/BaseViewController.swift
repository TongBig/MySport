//
//  BaseViewController.swift
//  MySport
//
//  Created by 宇仝 on 17/3/29.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.initViewModel()
        self.KVOHandler()
        // Do any additional setup after loading the view.
    }

    func initViewModel() {

    }

   func KVOHandler() {

    }

   func configureView() {


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
