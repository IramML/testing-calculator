//
//  CalculatorRouter.swift
//  calculator
//
//  Created by Iram Martinez on 07/09/22.
//

import Foundation
import UIKit

class CalculatorRouter: RouterProtocol {
    var entry: EntryPoint?
    
    static func start() -> RouterProtocol {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let router = CalculatorRouter()
        
        let navigation: UINavigationController? = storyboard.instantiateInitialViewController()
        let view: CalculatorViewController = navigation?.visibleViewController as! CalculatorViewController
        let presenter: CalculatorPresenter = CalculatorPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        router.entry = view
        
        return router
    }
}