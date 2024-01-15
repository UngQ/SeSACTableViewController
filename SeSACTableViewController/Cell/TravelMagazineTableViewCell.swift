//
//  TravelMagazineTableViewCell.swift
//  SeSACTableViewController
//
//  Created by ungq on 1/9/24.
//

import UIKit

class TravelMagazineTableViewCell: UITableViewCell {

    @IBOutlet var mainImageView: UIImageView!
    

    @IBOutlet var mainTitle: UILabel!
    @IBOutlet var subTitle: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear

        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.cornerRadius = 15
        mainImageView.clipsToBounds = true

        
        mainTitle.font = .boldSystemFont(ofSize: 20)
        mainTitle.numberOfLines = 0

        subTitle.font = .systemFont(ofSize: 14)
        subTitle.textColor = .systemGray

        
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .systemGray2

     

    }
    
    func connectData(magazineInfo: MagazineInfo, indexPath: IndexPath) {
        let url = URL(string: magazineInfo.magazine[indexPath.row].photo_image)!
        mainImageView.kf.setImage(with: url)
        mainTitle.text = magazineInfo.magazine[indexPath.row].title
        subTitle.text = magazineInfo.magazine[indexPath.row].subtitle
        dateLabel.text = changeDateFormat(date: magazineInfo.magazine[indexPath.row].date)
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
