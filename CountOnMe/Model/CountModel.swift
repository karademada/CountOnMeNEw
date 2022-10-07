//
//  CountModel.swift
//  CountOnMe
//
//  Created by Christophe Lazantsy on 02/09/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

class CountModel {
    
    /* var elements = [String]()
    
    init(elements: [String]) {
        self.elements = elements
    } */
    
    func addition(a: Double, b: Double) -> Double {
        return a+b
    }

    func substraction(a: Double, b: Double) -> Double {
        return a-b
    }

    func multiply(a: Double, b: Double) -> Double {
        return a*b
    }

    func divide(a: Double, b: Double) -> Double {
        return a/b
    }
    
    func expressionIsCorrect: Bool() {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "x"
    }
    
    func expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    func canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "x"
    }
    
    func expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }

    // MARK: - API
    
    enum CustomError {
        case general
        case cantDivideByO
    }
    
    func operation(operation: String) -> Double { // Example: operation -> "2 + 4 / 6 X 12 - 3"

        // 1. Tab of operations => [..,..,..]
        var elements = operation.split(separator: " ").map { "\($0)" }
         
       // ['2', '+', '4', '/', '6', '*', '12', '-', '3']
        // Iterate over operations while an operand still here
            while elements.count > 1 {
                var i:Int=1
                if let hasRange = elements.firstIndex(where: {$0 == "/" || $0 == "x"}){
                    i = hasRange
                } else {
                    print("pas de range")
                }
                let left = Double(elements[i-1])!
                let operand = elements[i] // division & multiply prioritaire
                let right = Double(elements[i+1])!
            
                let result: Double
                switch operand {
                    case "+": result = self.addition(a: left,b: right)
                    case "-": result = self.substraction(a: left,b: right)
                    case "/":
                        if(right==0){
                            print("Impossible de diviser par Zero!")
                            result = .infinity
                        }else{
                            result = self.divide(a: left,b: right)
                        }
                    case "x": result = self.multiply(a: left,b: right)
                default: fatalError("Unknown operator !")
            }
            
            elements.removeSubrange(i-1...i+1)
            elements.insert("\(result)", at: i-1)
            print(elements)
        }


        // Return
        guard let total = Double(elements[0]) else {
            return 0
        }
        
        return total
    }
    
}
