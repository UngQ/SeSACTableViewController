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
        
        titleLabel.text = "SeSAC TRAVEL"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        tableView.separatorStyle = .none
        

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineInfo.magazine.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelMagazineTableViewCell", for: indexPath) as! TravelMagazineTableViewCell
        
        //디자인
        cell.backgroundColor = .white
        
        cell.mainImageView.contentMode = .scaleAspectFill
        cell.mainImageView.layer.cornerRadius = 15
        
        cell.mainTitle.font = .boldSystemFont(ofSize: 24)
        cell.mainTitle.numberOfLines = 2
        
        cell.subTitle.font = .systemFont(ofSize: 16)
        cell.subTitle.textColor = .lightGray
        
        cell.dateLabel.textAlignment = .right
        
        cell.selectionStyle = .none
        
        
        //데이터 연결
        let url = URL(string: magazineInfo.magazine[indexPath.row].photo_image)!
        cell.mainImageView.kf.setImage(with: url)
        cell.mainTitle.text = magazineInfo.magazine[indexPath.row].title
        cell.subTitle.text = magazineInfo.magazine[indexPath.row].subtitle
        cell.dateLabel.text = changeDateFormat(date: magazineInfo.magazine[indexPath.row].date)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 480
    }
    
    func changeDateFormat(date: String) -> String {
        let beforeDateFormatter = DateFormatter()
        beforeDateFormatter.dateFormat = "yyMMdd"

        let date = beforeDateFormatter.date(from: date)
        
        let afterDateFormatter = DateFormatter()
        afterDateFormatter.dateFormat = "yy년 MM월 dd일"
        
        let result = afterDateFormatter.string(from: date!)
        
        return result
    }

}
