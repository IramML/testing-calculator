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
        var view: ViewProtocol = navigation?.visibleViewController as! ViewProtocol
        var presenter: PresenterProtocol = CalculatorPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
