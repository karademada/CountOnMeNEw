//
//  CountModel.swift
//  CountOnMe
//
//  Created by Christophe Lazantsy on 02/09/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

class CountModel {
        
    func splittedString(elements: String)-> [String]{
        return elements.split(separator: " ").map { "\($0)" }
    }
    
    func addition(a: Double, b: Double) -> Double {
        return a+b
    }

    func substraction(a: Double, b: Double) -> Double {
        return a-b
    }

    func multiply(a: Double, b: Double) -> Double {
        return a*b
    }

    func divide(a: Double, b: Double) -> Result<Double, CustomError> {
        if(b==0){
            return .failure(.cantDivideByO)
        }
        return .success(a/b)
    }
    
    func expressionHaveEnoughElement(elements: String ) -> Bool {
        return self.splittedString(elements: elements).count >= 3
    }
    
    func canAddOperator(elements: String ) -> Bool {
        let splitString = self.splittedString(elements:elements)
        return splitString.last != "+" && splitString.last != "-" && splitString.last != "/" && splitString.last != "x"
    }
    
    func expressionHaveResult(textView: UITextView ) -> Bool {
        return textView.text.firstIndex(of: "=") != nil
    }

    // MARK: - API
    
    enum CustomError: Error {
        case cantDivideByO
        case canAddOperator
        case haveEnoughElement
        case isNotDouble
        func message()-> String{
            switch self {
            case .cantDivideByO : return "Can't be divide by 0"
            case .canAddOperator : return "Operator can't be add"
            case .haveEnoughElement : return "Don't have enough element to process"
            case .isNotDouble : return "Value is not double"
            }
        }
    }
    
    
    
    func operation(operation: String) -> Result<Double, CustomError> { // Example: operation -> "2 + 4 / 6 X 12 - 3"
       // ['2', '+', '4', '/', '6', '*', '12', '-', '3']
        // Iterate over operations while an operand still here
        var splitString = self.splittedString(elements: operation)
        while splitString.count > 1 {
                var i:Int=1
                if let hasRange = splitString.firstIndex(where: {$0 == "/" || $0 == "x"}){
                    i = hasRange
                } else {
                    print("No range")
                }
                guard let left = Double(splitString[i-1]) else {
                    return .failure(.isNotDouble)
                }
                guard let right = Double(splitString[i+1]) else {
                    return .failure(.isNotDouble)
                }
                
                let operand = splitString[i] // division & multiply prioritaire
            
                let result: Double
                switch operand {
                    case "+": result = self.addition(a: left,b: right)
                    case "-": result = self.substraction(a: left,b: right)
                    case "/":
                        switch self.divide(a: left,b: right){
                            case .success(let resultDiv):
                                result = resultDiv
                            
                            case .failure(let error):
                                return .failure(error)
                        }
                    case "x": result = self.multiply(a: left,b: right)
                default: fatalError("Unknown operator !")
            }
            
            splitString.removeSubrange(i-1...i+1)
            splitString.insert("\(result)", at: i-1)
            print(splitString)
        }
        
        guard self.canAddOperator(elements: operation) else {
            return .failure(.canAddOperator)
        }

        //Return
        guard let total = Double(splitString[0]) else {
            return .failure(.isNotDouble)
        }
        
        return .success(total)
    }
    
}
