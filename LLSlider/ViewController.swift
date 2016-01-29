//
//  ViewController.swift
//  LLSlider
//
//  Created by liuk on 16/1/28.
//  Copyright © 2016年 Liu Kai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LLSliderDelegate {

    var sliderView: LLSliderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        self.addSliderView()
    }
    func addSliderView(){
        sliderView = LLSliderView(frame: CGRect(x: (kScreenWidth - 200) / 2 , y: 200, width: 240, height: 50), defaultValue: 80)
        sliderView.delegate = self
        self.view.addSubview(sliderView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - LLSliderDelegate
    func sliderValueChanged(value: Int) {
        print("slider value changed: \(value)")
    }
    
}

