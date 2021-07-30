//
//  ViewController.swift
//  iOSPrework
//
//  Created by Weiwei Shi on 7/29/21.
//  Copyright © 2021 Weiwei Shi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Sets the title in the Navigation Bar
        self.title = "Tip Calculator"
        defaults.set([0.15, 0.18, 0.2], forKey: "tipPercentages")
        
        //set up tapGestureRecognizer
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        view.addGestureRecognizer(recognizer)
        view.isUserInteractionEnabled = true
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if(UserDefaults.standard.object(forKey: "tipPercentages") != nil){
            let tipPercentages = defaults.object(forKey:"tipPercentages")as?[Double] ?? [Double]()
            tipControl.setTitle(String(format: "%.0f%%", tipPercentages[0]*100), forSegmentAt: 0)
            tipControl.setTitle(String(format: "%.0f%%", tipPercentages[1]*100), forSegmentAt: 1)
            tipControl.setTitle(String(format: "%.0f%%", tipPercentages[2]*100), forSegmentAt: 2)
        }
        else{
            defaults.set([0.15, 0.18, 0.2], forKey: "tipPercentages")
        }
        calculateTip()
    }
    
    @IBAction func changedTip(_ sender: Any) {
        calculateTip()
    }
    
    
    @objc func dismissKeyboard(_ gesture: UITapGestureRecognizer){
        view.endEditing(true)
        calculateTip()
    }
    
    @objc func calculateTip(){
        // Get bill amount from text field input
        let bill = Double(billAmountTextField.text!) ?? 0
        // Get Total tip by multiplying tip * tipPercentage
        
        let tipPercentages = defaults.object(forKey:"tipPercentages")as?[Double] ?? [Double]()
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        // Update Tip Amount Label
        tipAmountLabel.text = String(format: "$%.2f", tip)
        // Update Total Amount
        totalLabel.text = String(format: "$%.2f", total)
    }
}

