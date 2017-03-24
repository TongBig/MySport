//
//  HeardAnimationView.swift
//  MySport
//
//  Created by 宇仝 on 17/3/24.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import UIKit

class HeadAnimationView: UIView {



    override func layoutSubviews() {
        super.layoutSubviews()
        let dotImage = UIImage(named: "animation1")
        let dotImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: (dotImage?.size.width)!, height: (dotImage?.size.height)!))
        dotImageView.image = dotImage
        self.addSubview(dotImageView)
        self.addAnmination(imageView: dotImageView)


    }



    func addAnmination(imageView: UIImageView){

        var imgArray = [UIImage]()
        for i in 1...9 {
            let image = UIImage(named: "animation\(i)")
            imgArray.insert(image!, at: i - 1)
        }
        imageView.animationImages = imgArray
        imageView.animationDuration = 1.5
        imageView.animationRepeatCount = 0
        imageView.startAnimating()

        let centerX = self.width / 2
        let boundingRect: CGRect = CGRect(x: centerX - 50, y: 50, width: self.height / 2, height: self.height / 2)
        let orbit = CAKeyframeAnimation(keyPath:"position")
        orbit.duration = 3
        orbit.path = CGPath(ellipseIn: boundingRect,transform: nil)
        orbit.calculationMode = kCAAnimationPaced
        orbit.repeatCount = HUGE
        imageView.layer.add(orbit, forKey: "Move")

    }




}
