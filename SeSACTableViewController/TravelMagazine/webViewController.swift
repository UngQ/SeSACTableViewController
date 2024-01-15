//
//  webViewController.swift
//  SeSACTableViewController
//
//  Created by ungq on 1/15/24.
//

import UIKit
import WebKit

class webViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    var stringURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let url = URL(string: stringURL) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        

        
    }
    


}
