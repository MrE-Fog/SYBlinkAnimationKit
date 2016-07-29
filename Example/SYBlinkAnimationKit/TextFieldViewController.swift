//
//  TextFieldViewController.swift
//  SYBlinkAnimationKit
//
//  Created by Shoehi Yokoyama on 2015/12/13.
//  Copyright © 2015年 CocoaPods. All rights reserved.
//

import UIKit
import SYBlinkAnimationKit

class TextFieldViewController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "SYTextField"
        
        let borderTextField = SYTextField(frame: CGRectMake(40, 100, 300, 50))
        borderTextField.placeholder = "Border Animation"
        borderTextField.delegate = self
        borderTextField.startAnimation()
        self.view.addSubview(borderTextField)

        let border2TextField = SYTextField(frame: CGRectMake(40, 160, 300, 50))
        border2TextField.placeholder = "BorderWithShadow Animation"
        border2TextField.delegate = self
        border2TextField.animationType = .borderWithShadow
        border2TextField.backgroundColor = UIColor.clearColor()
        border2TextField.startAnimation()
        self.view.addSubview(border2TextField)

        let backgrondTextField = SYTextField(frame: CGRectMake(40, 220, 300, 50))
        backgrondTextField.placeholder = "Background Animation"
        backgrondTextField.delegate = self
        backgrondTextField.animationType = .background
        backgrondTextField.startAnimation()
        self.view.addSubview(backgrondTextField)
        
        let rippleTextField = SYTextField(frame: CGRectMake(40, 280, 300, 50))
        rippleTextField.placeholder = "Ripple Animation"
        rippleTextField.delegate = self
        rippleTextField.animationType = .ripple
        rippleTextField.startAnimation()
        self.view.addSubview(rippleTextField)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
