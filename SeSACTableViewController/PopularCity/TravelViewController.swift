//
//  TravelViewController.swift
//  SeSACTableViewController
//
//  Created by ungq on 1/12/24.
//

import UIKit

class TravelViewController: UIViewController {

    @IBOutlet var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
