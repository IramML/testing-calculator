//
//  PresenterProtocol.swift
//  calculator
//
//  Created by Iram Martinez on 07/09/22.
//

import Foundation

protocol PresenterProtocol {
    var router: RouterProtocol? { get set }
    var interactor: InteractorProtocol? { get set }
    var view: ViewProtocol? { get set }
}
