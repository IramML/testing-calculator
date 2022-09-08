//
//  RouterProtocol.swift
//  calculator
//
//  Created by Iram Martinez on 07/09/22.
//

import Foundation
import UIKit

typealias EntryPoint = ViewProtocol & UIViewController

protocol RouterProtocol {
    var entry: EntryPoint? { get }
    static func start() -> RouterProtocol
}
