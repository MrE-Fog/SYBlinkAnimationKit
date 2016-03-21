//
//  SYLabel.swift
//  SYBlinkAnimationKit
//
//  Created by Shohei Yokoyama on 12/13/2015.
//  Copyright © 2015年 Shohei. All rights reserved.
//

import UIKit

public enum SYLabelAnimation: Int {
    case Border = 0
    case BorderWithShadow
    case Background
    case Ripple
    case Text
}

@IBDesignable public class SYLabel: UILabel, Animatable {
    
    private let textLayer = CATextLayer()
    
    @IBInspectable public var animationBorderColor: UIColor = UIColor() {
        didSet {
            self.syLayer.setAnimationBorderColor(self.animationBorderColor)
        }
    }
    @IBInspectable public var animationBackgroundColor: UIColor = UIColor() {
        didSet {
            self.syLayer.setAnimationBackgroundColor(self.animationBackgroundColor)
        }
    }
    @IBInspectable public var animationTextColor: UIColor = UIColor() {
        didSet {
            self.syLayer.setAnimationTextColor(self.animationTextColor)
        }
    }
    @IBInspectable public var animationRippleColor: UIColor = UIColor() {
        didSet {
            self.syLayer.setAnimationRippleColor(self.animationRippleColor)
        }
    }
    
    override public var frame: CGRect {
        didSet {
            self.syLayer.resizeSuperLayer()
        }
    }
    override public var bounds: CGRect {
        didSet {
            self.syLayer.resizeSuperLayer()
        }
    }
    
    override public var backgroundColor: UIColor? {
        didSet {
            guard backgroundColor == nil else {
                self.syLayer.setBackgroundColor(backgroundColor!)
                return
            }
        }
    }
    
    override public var text: String? {
        didSet {
            !isFirstSetTextLayer ? self.firstSetTextLayer() : self.firstSetTextLayer()
        }
    }
    
    @IBInspectable public var labelTextColor: UIColor? {
        didSet {
            self.textColor = UIColor.clearColor()
            self.textLayer.foregroundColor = labelTextColor?.CGColor
            self.syLayer.setTextColor(labelTextColor!)
        }
    }
    
    public var isAnimating = false
    
    public var isFirstSetTextLayer = false
    
    public var animationTimingFunction: SYMediaTimingFunction = .Linear {
        didSet {
            self.syLayer.setAnimationTimingFunction(animationTimingFunction)
        }
    }
    @IBInspectable public var animationTimingAdapter: Int {
        get {
            return self.animationTimingFunction.rawValue
        }
        set(index) {
            self.animationTimingFunction = SYMediaTimingFunction(rawValue: index) ?? .Linear
        }
    }
    
    @IBInspectable public var animationDuration: CGFloat = 1.0 {
        didSet {
            self.syLayer.setAnimationDuration(CFTimeInterval(animationDuration))
        }
    }
    
    public func setFontOfSize(fontSize: CGFloat) {
        self.font = UIFont.systemFontOfSize(fontSize)
        self.resetTextLayer()
    }
    public func setFontNameWithSize(name: String, size: CGFloat) {
        self.font = UIFont(name: name, size: size)
        self.resetTextLayer()
    }
    
    public lazy var syLayer: SYLayer = SYLayer(superLayer: self.layer)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setLayer()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setLayer()
    }
    
    public var syLabelAnimation: SYLabelAnimation = .Border {
        didSet {
            switch syLabelAnimation {
            case .Border:
                self.syLayer.syLayerAnimation = .Border
            case .BorderWithShadow:
                self.syLayer.syLayerAnimation = .BorderWithShadow
            case .Background:
                self.syLayer.syLayerAnimation = .Background
            case .Ripple:
                self.syLayer.syLayerAnimation = .Ripple
            case .Text:
                self.syLayer.syLayerAnimation = .Text
            }
        }
    }
    @IBInspectable public  var syLabelAnimationAdapter: Int {
        get {
            return self.syLabelAnimation.rawValue
        }
        set(index) {
            self.syLabelAnimation = SYLabelAnimation(rawValue: index) ?? .Border
        }
    }
    
    public func startAnimation() {
        self.isAnimating = true
        self.syLayer.startAnimation()
    }
    
    public func stopAnimation() {
        self.isAnimating = false
        self.syLayer.stopAnimation()
    }
}

private extension SYLabel {
    
    private func setLayer() {
        self.layer.cornerRadius = 1.5
        self.textColor = UIColor.clearColor()
        self.labelTextColor = UIColor.blackColor()
        self.syLayer.syLayerAnimation = .Border
    }
    
    private func firstSetTextLayer() {
        self.isFirstSetTextLayer = true
        self.setTextLayer()
        self.syLayer.firstSetTextLayer(textLayer)
    }
    
    private func resetTextLayer() {
        self.setTextLayer()
        self.syLayer.resetTextLayer(self.textLayer)
    }
    
    private func setTextLayer() {
        var attributes = [String: AnyObject]()
        attributes[NSFontAttributeName] = self.font
        let size = self.text!.sizeWithAttributes(attributes)
        
        let x = (CGRectGetWidth(self.frame) - size.width) / 2
        let y = (CGRectGetHeight(self.frame) - size.height) / 2
        let height = size.height + self.layer.borderWidth
        let width = size.width
        let frame = CGRectMake(x, y, width, height)
        
        self.textLayer.font = self.font
        self.textLayer.string = self.text
        self.textLayer.fontSize = self.font.pointSize
        
        self.textLayer.foregroundColor = self.labelTextColor!.CGColor
        self.textLayer.contentsScale = UIScreen.mainScreen().scale
        
        self.textLayer.frame = frame
        self.textLayer.alignmentMode = kCAAlignmentCenter
    }
}