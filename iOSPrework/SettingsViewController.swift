//
//  SettingsViewController.swift
//  iOSPrework
//
//  Created by Weiwei Shi on 7/29/21.
//  Copyright © 2021 Weiwei Shi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var tip1TextField: UITextField!
    @IBOutlet weak var tip2TextField: UITextField!
    @IBOutlet weak var tip3TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        
        tip1TextField.becomeFirstResponder()
        
        //set up TapGestureRecognizer
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        view.addGestureRecognizer(recognizer)
        view.isUserInteractionEnabled = true
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let tipPercentages = defaults.object(forKey:"tipPercentages")as?[Double] ?? [Double]()
        
        let tip1 = Double(tip1TextField.text!) ?? tipPercentages[0]*100
        let tip2 = Double(tip2TextField.text!) ?? tipPercentages[1]*100
        let tip3 = Double(tip3TextField.text!) ?? tipPercentages[2]*100
        
        defaults.set([tip1/100, tip2/100, tip3/100], forKey: "tipPercentages")
        defaults.synchronize()
    }
    
    @objc func dismissKeyboard(_ gesture: UITapGestureRecognizer){
        view.endEditing(true)
    }
}
