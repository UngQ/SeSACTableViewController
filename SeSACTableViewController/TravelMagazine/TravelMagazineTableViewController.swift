//
//  TravelMagazineTableViewController.swift
//  SeSACTableViewController
//
//  Created by ungq on 1/9/24.
//

import UIKit
import Kingfisher

class TravelMagazineTableViewController: UITableViewController {
    
    @IBOutlet var titleLabel: UILabel!
    let magazineInfo = MagazineInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableViewController()
    }
}

extension TravelMagazineTableViewController {
    func configureTableViewController() {
        navigationItem.title = "Travel Magazine"
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension TravelMagazineTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineInfo.magazine.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelMagazineTableViewCell.identifier, for: indexPath) as! TravelMagazineTableViewCell
        cell.connectData(magazineInfo: magazineInfo, indexPath: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: webViewController.identifier) as! webViewController
        vc.stringURL = magazineInfo.magazine[indexPath.row].link
        navigationController?.pushViewController(vc, animated: true)
    }
}
