//
//  ViewController.swift
//  calculator
//
//  Created by Iram Martinez on 17/08/22.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var displayLabel: UILabel!
    
    let calculatorPresenter: CalculatorPresenter = CalculatorPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calculatorPresenter.delegate = self
    }
    
    @IBAction func writeNumberAction(_ sender: Any) {
        if let numberButton = sender as? UIButton,
            let number: Int = Int(numberButton.titleLabel?.text ?? "") {
            self.calculatorPresenter.numberSelected(number)
        }
    }
    
    @IBAction func makeOperationAction(_ sender: Any) {
        if let operationButton = sender as? UIButton,
           let operationString = operationButton.titleLabel?.text,
           let operation: MathOperation = MathOperation.getOperation(byDescription: operationString) {
            self.calculatorPresenter.operationSelected(operation)
        }
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        self.calculatorPresenter.deleteAll()
    }
    
    @IBAction func enterDotAction(_ sender: Any) {
        self.calculatorPresenter.enterDot()
    }
    
    @IBAction func computeResultAction(_ sender: Any) {
        self.calculatorPresenter.computeResult()
    }
}

extension CalculatorViewController: CalculatorDelegate {
    func showOnCalculatorDisplay(_ content: String) {
        self.displayLabel.text = content
    }
}
