//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var countModel = CountModel()
    
    // Error check computed variables

    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clearAll(_ sender: UIButton){
        textView.text = ""
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if countModel.expressionHaveResult(textView: textView) {
            textView.text = ""
        }
        
        textView.text.append(numberText)
    }
    
    @IBAction func tappeOperationButton(_ sender: UIButton) {
        guard let operande = sender.titleLabel?.text else {
            return
        }
        
        if countModel.canAddOperator(elements: textView.text) {
            textView.text.append(" "+operande+" ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "There is allready an operator !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard countModel.canAddOperator(elements: textView.text) else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Enter a valid expression !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard countModel.expressionHaveEnoughElement(elements: textView.text) else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Start a new operation !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        let textToDisplay = countModel.operation(operation: textView.text)
        
        switch textToDisplay {
        case .success(let result):
            var textClean = ""
            
            if result.truncatingRemainder(dividingBy: 1) == 0 {
                textClean = String(format: "%.0f",result)
            } else {
                textClean = String(result)
            }
                    
            self.textView.text.append(" = \(String(textClean))")
        case .failure(let error):
            let alertVC = UIAlertController(title: "Error", message: error.message(), preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                return self.present(alertVC, animated: true, completion: nil)
        }
        
        
        
        
        
    }

}

