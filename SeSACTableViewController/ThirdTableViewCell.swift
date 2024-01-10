//
//  thirdTableViewCell.swift
//  SeSACTableViewController
//
//  Created by ungq on 1/7/24.
//

import UIKit

class ThirdTableViewCell: UITableViewCell {

    @IBOutlet var cellView: UIView!
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var starButton: UIButton!
    
    @IBOutlet var itemTextLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.backgroundColor = .systemGray6
        cellView.layer.cornerRadius = 15
        cellView.layer.borderColor = UIColor.white.cgColor
        cellView.layer.borderWidth = 1
        
    }
    
    func configureCell(_ shoppingList: [ShoppingList], indexPath: IndexPath) {
        
        checkButton.tag = indexPath.row
        starButton.tag = indexPath.row

        itemTextLabel.text = shoppingList[indexPath.row].itemName
        
        let checkImage = shoppingList[indexPath.row].checkBool ? "checkmark.square.fill" : "checkmark.square"
        let starImage = shoppingList[indexPath.row].starBool ? "star.fill" : "star"
        checkButton.setImage(UIImage(systemName: checkImage), for: .normal)
        starButton.setImage(UIImage(systemName: starImage), for: .normal)
    }
    
}
