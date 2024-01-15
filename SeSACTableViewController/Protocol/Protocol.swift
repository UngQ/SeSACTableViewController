//
//  UIProtocol.swift
//  SeSACTableViewController
//
//  Created by ungq on 1/10/24.
//

import UIKit

protocol ReusableProtocol {
    static var identifier: String { get }
}

extension ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController: ReusableProtocol {
}

extension UIView: ReusableProtocol {
}


