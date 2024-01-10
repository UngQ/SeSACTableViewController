//
//  UIViewController+Extension.swift
//  SeSACTableViewController
//
//  Created by ungq on 1/10/24.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}


extension StepThreeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
}
