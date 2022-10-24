//
//  MathOperation.swift
//  calculator
//
//  Created by Iram Martinez on 21/08/22.
//

import Foundation

enum MathOperation {
    case addition, substraction, division, multiplication
    
    var description: String {
        switch self {
        case .addition:
            return "+"
        case .substraction:
            return "-"
        case .division:
            return "/"
        case .multiplication:
            return "X"
        }
    }
    
    static func getOperation(byDescription operation: String) -> MathOperation? {
        switch operation {
        case MathOperation.addition.description:
            return .addition
        case MathOperation.substraction.description:
            return .substraction
        case MathOperation.division.description:
            return .division
        case MathOperation.multiplication.description:
            return .multiplication
        default:
            return nil
        }
    }
}
