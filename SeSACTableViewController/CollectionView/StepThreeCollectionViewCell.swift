//
//  StepThreeCollectionViewCell.swift
//  SeSACTableViewController
//
//  Created by ungq on 1/10/24.
//

import UIKit


class StepThreeCollectionViewCell: UICollectionViewCell {

    @IBOutlet var cityImageView: UIImageView!
    
    @IBOutlet var cityNameLabel: UILabel!
    
    @IBOutlet var cityExplainLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityImageView.contentMode = .scaleAspectFill
        
        let spacing: CGFloat = 24
        let cellWidth = UIScreen.main.bounds.width - (spacing * 3)
        cityImageView.layer.cornerRadius = cellWidth / 4
        
        cityNameLabel.textAlignment = .center
        cityNameLabel.font = .boldSystemFont(ofSize: 16)
        
        cityExplainLabel.textAlignment = .center
        cityExplainLabel.numberOfLines = 2

        cityExplainLabel.font = .systemFont(ofSize: 12)
        cityExplainLabel.textColor = .gray
    }
    
    func configureCell(cityInfo: [City], indexPath: IndexPath) {
        let url = URL(string: cityInfo[indexPath.item].city_image)
        cityImageView.kf.setImage(with: url)
        cityNameLabel.text = "\(cityInfo[indexPath.item].city_name) | \(cityInfo[indexPath.item].city_english_name)"
        cityExplainLabel.text = cityInfo[indexPath.item].city_explain
    }
    
}
