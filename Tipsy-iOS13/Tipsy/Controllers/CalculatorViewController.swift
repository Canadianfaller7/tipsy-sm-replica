//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
   
    @IBAction func tipChanged(_ sender: UIButton) {
        
        billTextField.endEditing(true)
        
        // this makes it so when you select on one of the tips it will put a background color on it showing it is selected. We have all the others as false so none are selected right now but once the sender (user) selects one then it will highlight the one selected.
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        // having the button selected be the current title
        let selectedValue = sender.currentTitle!
        // removing the percentage sign so it shows as just a decimal point
        let removePrctSign = String(selectedValue.dropLast())
        // this converts the value from above to a double decimal
        let buttonValue = Double(removePrctSign)
        // this will now take that value from above and force unwrap it and divide it by 100 to get the decimal value of the percentage
        tip = buttonValue! / 100
        
        
        
    }
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
        
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let bill = billTextField.text!
        if bill != "" {
            billTotal = Double(bill)!
            let total = billTotal * (1 + tip) / Double(numberOfPeople)
            finalResult = String(format: "%.2f", total)
        }
        self.performSegue(withIdentifier: "goToResults", sender: self)
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            
            destinationVC.result = finalResult
            destinationVC.split = numberOfPeople
            destinationVC.tipPercentage = Int(100 * tip)
            
        }
        
    }
    
}

