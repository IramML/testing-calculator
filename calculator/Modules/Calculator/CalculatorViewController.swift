//
//  ViewController.swift
//  calculator
//
//  Created by Iram Martinez on 17/08/22.
//

import UIKit

class CalculatorViewController: UIViewController {
    var presenter: CalculatorPresenter?
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayLabel.accessibilityIdentifier = "displayLabel"
    }
    
    @IBAction func writeNumberAction(_ sender: Any) {
        if let numberButton = sender as? UIButton,
            let number: Int = Int(numberButton.titleLabel?.text ?? "") {
            self.presenter?.numberSelected(number)
        }
    }
    
    @IBAction func makeOperationAction(_ sender: Any) {
        if let operationButton = sender as? UIButton,
           let operationString = operationButton.titleLabel?.text,
           let operation: MathOperation = MathOperation.getOperation(byDescription: operationString) {
            self.presenter?.operationSelected(operation)
        }
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        self.presenter?.deleteAll()
    }
    
    @IBAction func enterDotAction(_ sender: Any) {
        self.presenter?.enterDot()
    }
    
    @IBAction func computeResultAction(_ sender: Any) {
        self.presenter?.computeResult()
    }
}

extension CalculatorViewController: CalculatorDelegate {
    func showOnCalculatorDisplay(_ content: String) {
        self.displayLabel.text = content
    }
}
