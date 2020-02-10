//
//  ViewController.swift
//  calculator
//
//  Created by kimjunseong on 2020/02/05.
//  Copyright © 2020 kimjunseong. All rights reserved.
//

import UIKit

enum Operation: String {
    case Add = "+"
    case Subtract = "-"
    case Divide = "/"
    case Multiply = "*"
    case NULL = "Null"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    
    private var runningNumber = ""
    private var leftValue = 0.0
    private var rightValue = 0.0
    private var result = 0.0
    private var currentOperation: Operation = .NULL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputLbl.text = "0"
    }

    @IBAction func numberPressed(_ sender: RoundButton) {
        if runningNumber.count <= 7 {
            runningNumber += "\(sender.tag)"
            outputLbl.text = runningNumber
        }
        if runningNumber[runningNumber.startIndex] == "0" {
            runningNumber = ""
        }
    }
    
    @IBAction func allClearPressed(_ sender: RoundButton) {
        leftValue = 0.0
        rightValue = 0.0
        result = 0.0
        currentOperation = .NULL
        outputLbl.text = "0"
    }
    
    @IBAction func dotPressed(_ sender: RoundButton) {
        if runningNumber.contains(".") {
            print((". can be input one time"))
            return
        }
        
        if runningNumber.count > 7 {
            print("input number is long.")
            return
        }
        
        runningNumber += "."
        outputLbl.text = runningNumber
    }
    
    @IBAction func equalPressed(_ sender: RoundButton) {
        operation(operation: currentOperation)
    }
    
    @IBAction func addPressed(_ sender: RoundButton) {
        operation(operation: .Add)
    }
    
    @IBAction func subtractPressed(_ sender: RoundButton) {
        operation(operation: .Subtract)
    }
    
    @IBAction func multiplyPressed(_ sender: RoundButton) {
        operation(operation: .Multiply)
    }
    
    @IBAction func dividePressed(_ sender: RoundButton) {
        operation(operation: .Divide)
    }
    
    @IBAction func percentPressed(_ sender: RoundButton) {
        if runningNumber != "" {
          runningNumber = "\(Double(runningNumber)! / 100.00)"
          outputLbl.text = runningNumber
          leftValue = Double(runningNumber)!

        }
        
        if result != 0.0 {
            result = Double(result) / 100.00
            outputLbl.text = String(result)
            leftValue = result
            currentOperation = .NULL
        }
    }
    
    @IBAction func convertPressed(_ sender: RoundButton) {
        if runningNumber == "."{
            return
        }
        
        if runningNumber != ""{
            runningNumber = "\(Double(runningNumber)! * (-1))"
            outputLbl.text = "\(runningNumber)"
        }
    
        if result != 0.0 {
            result = Double(result) * (-1)
            leftValue = result
            outputLbl.text = "\(result)"
        }
    }

    func operation(operation: Operation){
        if runningNumber == "" {
            currentOperation = operation
            return
        }
        if runningNumber == "." {
            return
        }
        
        if currentOperation == .NULL {
            leftValue = Double(runningNumber)!
            runningNumber = ""
            currentOperation = operation
            return
        }
        
        rightValue = Double(runningNumber)!
        runningNumber = ""
        
        switch currentOperation {
        case .Add: result = calc(a: leftValue, b: rightValue){$0 + $1}
        case .Subtract: result = calc(a: leftValue, b: rightValue){$0 - $1}
        case .Multiply: result = calc(a: leftValue, b: rightValue){$0 * $1}
        case .Divide: result = calc(a: leftValue, b: rightValue){$0 / $1}
        default: break
        }

        leftValue = result
//        if result.truncatingRemainder(dividingBy: 1) == 0 {result = }
        print(result)
        outputLbl.text = String(result)
        currentOperation = operation
    }
    func calc(a: Double, b: Double, method: (Double, Double) -> Double) -> Double{
      return method(a, b)
    }
}

