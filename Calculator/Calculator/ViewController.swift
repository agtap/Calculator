//
//  ViewController.swift
//  Calculator
//
//  Created by Agnes Otap on 5/24/18.
//  Copyright © 2018 Agnes Otap. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var displayText: String = ""
    
    var activeOperation: String = ""
        
    var displayArray = [String]()
    
    var calculationArray = [Double]()
    
    var operationArray = [String]()
    
    var readyForNumbers = true
    
    func addToDisplay() {
        displayText += displayArray.removeLast()
    }
    
    func updateUI() {
        displayWindow.text = displayText
    }
    
    @IBOutlet weak var displayWindow: UILabel!
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        displayText = ""
        displayArray.removeAll()
        activeOperation = ""
        operationArray.removeAll()
        calculationArray.removeAll()
        updateUI()
    }
    
    @IBOutlet var numberButtons: [UIButton]!
    
    @IBOutlet var operationButtons: [UIButton]!
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        let numberString = sender.title(for: .normal)!
        if numberString == "." && displayText.contains(".") {
            // don't add a second period
        } else if displayText == "Undefined" {
            displayText = ""
            displayArray.removeAll()
            activeOperation = ""
            operationArray.removeAll()
            calculationArray.removeAll()
            displayArray.append(numberString)
            addToDisplay()
            updateUI()
        } else if readyForNumbers == false {
            displayArray.removeAll()
            displayText = ""
            displayArray.append(numberString)
            addToDisplay()
            updateUI()
            readyForNumbers = true
        } else {
            displayArray.append(numberString)
            addToDisplay()
            updateUI()
        }
    }
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        if displayText != "" {
            let operatorString = sender.title(for: .normal)!
            activeOperation = operatorString
            let saveNumber = Double(displayText)
            calculationArray.append(saveNumber!)
            calculate()
            operationArray.append(activeOperation)
            activeOperation = ""
            readyForNumbers = false
        } else {
            // nothing!
        }
    }
    
    func calculate() {
        if !operationArray.isEmpty && operationArray[0] == "+" {
            let additionResult = calculationArray[0] + calculationArray[1]
            calculationArray.removeAll()
            displayArray.removeAll()
            displayText = "\(additionResult)"
            calculationArray.append(additionResult)
            operationArray.removeAll()
            updateUI()
        } else if !operationArray.isEmpty && operationArray[0] == "-" {
            let subtractionResult = calculationArray[0] - calculationArray[1]
            calculationArray.removeAll()
            displayArray.removeAll()
            displayText = "\(subtractionResult)"
            calculationArray.append(subtractionResult)
            operationArray.removeAll()
            activeOperation = ""
            updateUI()
        } else if !operationArray.isEmpty && operationArray[0] == "×" {
            let multiplicationResult: Double = calculationArray[0] * calculationArray[1]
            calculationArray.removeAll()
            displayArray.removeAll()
            displayText = "\(multiplicationResult)"
            calculationArray.append(multiplicationResult)
            operationArray.removeAll()
            activeOperation = ""
            updateUI()
        } else if !operationArray.isEmpty && operationArray[0] == "÷" {
            if calculationArray[1] == 0 {
                displayText = "Undefined"
                calculationArray.removeAll()
                updateUI()
            } else {
                let divisionResult = calculationArray[0] / calculationArray[1]
                calculationArray.removeAll()
                displayText = "\(divisionResult)"
                calculationArray.append(divisionResult)
                operationArray.removeAll()
                activeOperation = ""
                updateUI()
            }
        } else {
           // nothing here!
        }
    }
    
    @IBAction func equals(_ sender: UIButton) {
        if !calculationArray.isEmpty {
            let saveNumber = Double(displayText)
            calculationArray.append(saveNumber!)
            calculate()
        } else {
            // nothing to see here, folks
        }
    }
    
    @IBAction func positiveNegative(_ sender: UIButton) {
        if displayText != "" {
            var saveNumber:Double = Double(displayText)!
            saveNumber = saveNumber * (Double(-1))
            displayText = "\(saveNumber)"
            updateUI()
        } else {
            displayArray.append("-")
            addToDisplay()
            updateUI()
        }
    }
    
    @IBAction func percent(_ sender: UIButton) {
        if displayText != "" {
            var saveNumber:Double = Double(displayText)!
            saveNumber = saveNumber / (Double(100))
            displayText = "\(saveNumber)"
            updateUI()
        } else {
            // nothing to see here, folks
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

