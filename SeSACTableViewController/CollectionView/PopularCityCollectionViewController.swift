//
//  PopularCityCollectionViewController.swift
//  SeSACTableViewController
//
//  Created by ungq on 1/9/24.
//

import UIKit
import Kingfisher


class PopularCityCollectionViewController: UICollectionViewController {
    
    let cityInfo = CityInfo().city

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 24
        let cellWidth = UIScreen.main.bounds.width - (spacing * 3) //디바이스 너비 - (spacing * 4(보이고 싶은 갯수 +1))

        layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth / 2 + 70) //셀크기
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing) //시작으로부터 여백
        layout.minimumLineSpacing = spacing //셀과 셀 사이 여백
        layout.minimumInteritemSpacing = 0 //위아래 간격
        layout.scrollDirection = .vertical
        
        collectionView.collectionViewLayout = layout

    }



    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityInfo.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCityCollectionViewCell", for: indexPath) as! PopularCityCollectionViewCell
    
        let url = URL(string: cityInfo[indexPath.item].city_image)
        
        cell.cityImageView.kf.setImage(with: url)
        cell.cityImageView.contentMode = .scaleAspectFill
        
        //원형 이미지 만들기
        let spacing: CGFloat = 24
        let cellWidth = UIScreen.main.bounds.width - (spacing * 3)
        cell.cityImageView.layer.cornerRadius = cellWidth / 4
        
        
        cell.cityNameLabel.text = "\(cityInfo[indexPath.item].city_name) | \(cityInfo[indexPath.item].city_english_name)"
        cell.cityNameLabel.textAlignment = .center
        cell.cityNameLabel.font = .boldSystemFont(ofSize: 16)
        
        cell.cityExplainLabel.text = cityInfo[indexPath.item].city_explain
        cell.cityExplainLabel.textAlignment = .center
        cell.cityExplainLabel.numberOfLines = 2

        cell.cityExplainLabel.font = .systemFont(ofSize: 12)
        cell.cityExplainLabel.textColor = .gray
    
        return cell
    }

}
