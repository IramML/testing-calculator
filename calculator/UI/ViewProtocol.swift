//
//  ViewProtocol.swift
//  calculator
//
//  Created by Iram Martinez on 07/09/22.
//

import Foundation
import UIKit

protocol ViewProtocol {
    var presenter: PresenterProtocol? { get set }
}
