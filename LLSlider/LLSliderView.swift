//
//  LLSliderView.swift
//  LLSlider
//
//  Created by liuk on 16/1/28.
//  Copyright © 2016年 Liu Kai. All rights reserved.
//

import UIKit
protocol LLSliderDelegate{
    func sliderValueChanged(value: Int)
}

class ADButton: UIButton {
    var onClick: () -> () = {_ in ()}
    func tapped(sender: AnyObject){
        onClick()
    }
}

class LLSliderView: UIView {

    var numberLabel: UILabel!
    var number: Int!
    var delegate: LLSliderDelegate!
    private var minusButton: ADButton!
    private var plusSignButton: ADButton!
    var slider: LLSlider!
    private override init(frame: CGRect) {
        super.init(frame: frame)

    }
    convenience init(frame: CGRect, minimumValue: Double = 0, maximumValue: Double = 100, defaultValue: Double) {
        self.init(frame: frame)
        self.initViews()
        self.addAdSlider(minimumValue, maximumValue: maximumValue, thumbValue: defaultValue)
        self.addPlusSignButton()
        self.number = Int(defaultValue)
        self.updateLabel()
    }
    
    //MARK: - Add SubViews
    func initViews(){
        self.addNumberLabel()
        self.addMinusButton()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addNumberLabel(){
        
        numberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: self.height))
        numberLabel.textColor = UIColor.whiteColor()
        self.addSubview(numberLabel)
    }
    func addMinusButton(){
        let image = UIImage(named: "set_reduce")!
        minusButton = button(CGRect(x: numberLabel.right, y: 0, width: image.width, height: self.height), text: "", image: image, highlighted: image, onClick: { () -> () in
            if self.number == Int(self.slider.minimumValue!){
                return
            }
            self.number! -= 1
            self.updateLabel()
            self.slider.thumbValue = Double(self.number)
            self.slider.updateThumbFrame()
            self.delegate.sliderValueChanged(self.number)
        })
        self.addSubview(minusButton)
        
    }
    func addAdSlider(minimumValue: Double, maximumValue: Double, thumbValue: Double){
        slider = LLSlider(frame: CGRect(x: minusButton.right, y: 0, width: 140, height: self.height))
        slider.addTarget(self, action: "sliderValueChanged:", forControlEvents: .ValueChanged)

        slider.thumbValue = thumbValue
        slider.minimumValue = minimumValue
        slider.maximumValue = maximumValue
        slider.updateThumbFrame()
        self.addSubview(slider)
    }
    func addPlusSignButton(){
        let image = UIImage(named: "set_increase")!
        plusSignButton = button(CGRect(x: slider.right, y: 0, width: image.width, height: self.height), text: "", image: image, highlighted: image, onClick: { () -> () in
            if self.number == Int(self.slider.maximumValue!){
                return
            }
            self.number! += 1
            self.updateLabel()
            self.slider.thumbValue = Double(self.number)
            self.slider.updateThumbFrame()
            self.delegate.sliderValueChanged(self.number)

        })
        self.addSubview(plusSignButton)
        
    }
    //MARK: - Private Method
    func button(frame: CGRect, text: String, image: UIImage, highlighted: UIImage, onClick: () -> ()) -> ADButton{
        let button = ADButton(type: .Custom)
        button.setTitle(text, forState: .Normal)
        button.setImage(image, forState: .Normal)
        button.setImage(highlighted, forState: .Normal)
        button.addTarget(button, action: "tapped:", forControlEvents: .TouchUpInside)
        button.frame = frame
        button.onClick = onClick
        return button
    }
    func updateLabel(){
        numberLabel.text = String(number)
    }
    
    //MARK: - Action 
    func sliderValueChanged(slider: LLSlider){
        number = Int(slider.thumbValue!)
        self.delegate.sliderValueChanged(self.number)

        self.updateLabel()
    }

}
