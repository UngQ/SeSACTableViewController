//
//  TravelMagazineTableViewController.swift
//  SeSACTableViewController
//
//  Created by ungq on 1/9/24.
//

import UIKit
import Kingfisher

class TravelMagazineTableViewController: UITableViewController, UIProtocol {
    
    func designMainView() {
        titleLabel.text = "SeSAC TRAVEL"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        tableView.separatorStyle = .none
    }
    
    @IBOutlet var titleLabel: UILabel!
    let magazineInfo = MagazineInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        designMainView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineInfo.magazine.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelMagazineTableViewCell", for: indexPath) as! TravelMagazineTableViewCell
        cell.connectData(magazineInfo: magazineInfo, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 480
    }
    

}
