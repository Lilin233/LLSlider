//
//  LLSlider.swift
//  LLSlider
//
//  Created by liuk on 16/1/28.
//  Copyright © 2016年 Liu Kai. All rights reserved.
//

import UIKit

class LLSlider: UIControl {

    var minimumValue: Double?
    var maximumValue: Double?
    var thumbValue: Double?
//        {
//        didSet{
//            self.updateThumbFrame()
//        }
//    }
    
    private var trackLayer: CALayer!
    private var thumbView: UIImageView!
    private var thumbHighLighted: Bool = false
    private var previousLocation = CGPoint()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
        self.backgroundColor = UIColor.clearColor()
    }
    func initViews(){
        self.addSliderLine()
        self.addThumbView()
    }
    func addSliderLine(){
        trackLayer = CALayer()
        trackLayer.frame = CGRect(x: 0, y: (self.height - 1) / 2, width: self.width, height: 1)
        trackLayer.backgroundColor = UIColor.whiteColor().CGColor
        self.layer.addSublayer(trackLayer)
    }
    func addThumbView(){
        let image = UIImage(named: "set_slider_button")!
        thumbView = UIImageView(frame: CGRect(x: 0, y: (self.height - image.height) / 2, width: image.width, height: image.height))
        thumbView.image = image
        self.addSubview(thumbView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        previousLocation = touch.locationInView(self)
        if thumbView.frame.contains(previousLocation){
            highlighted = true
        }
        return highlighted
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let location = touch.locationInView(self)
        
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (maximumValue! - minimumValue!) * deltaLocation / Double(bounds.width)
        previousLocation = location
        if self.highlighted{
            thumbValue! += deltaValue
            thumbValue = boundValue(thumbValue!)
            
            self.updateThumbFrame()
        }
        sendActionsForControlEvents(.ValueChanged)
        return highlighted
    }
    
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {

        highlighted = false
    }
    func boundValue(thumbValue: Double) -> Double{
        return min(max(minimumValue!, thumbValue), maximumValue!)
    }
    func updateThumbFrame(){
        let value = self.positionForValue(thumbValue!)
        thumbView.center = CGPointMake(CGFloat(value), self.height / 2)
    }
    func positionForValue(value: Double) -> Double{
        let value = Double(bounds.width - thumbView.width) * (value - minimumValue!) / (maximumValue! - minimumValue!) + Double (thumbView.width / 2.0)
        return value
    }

}
