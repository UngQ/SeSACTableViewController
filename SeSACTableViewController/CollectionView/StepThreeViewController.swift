//
//  StepThreeViewController.swift
//  SeSACTableViewController
//
//  Created by ungq on 1/9/24.
//

import UIKit

class StepThreeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
 
    var cityInfo = CityInfo().city

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StepThreeCollectionViewCell", for: indexPath) as! StepThreeCollectionViewCell
        
        let url = URL(string: cityInfo[indexPath.item].city_image)
        cell.cityImageView.kf.setImage(with: url)
        
        cell.cityNameLabel.text = "\(cityInfo[indexPath.item].city_name) | \(cityInfo[indexPath.item].city_english_name)"
        
        cell.cityExplainLabel.text = cityInfo[indexPath.item].city_explain
        
        return cell
    }

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var domesticTravelSegmentedControl: UISegmentedControl!
    
    @IBOutlet var cityCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let xib = UINib(nibName: "StepThreeCollectionViewCell", bundle: nil)
        cityCollectionView.register(xib, forCellWithReuseIdentifier: "StepThreeCollectionViewCell")
        
        cityCollectionView.dataSource = self
        cityCollectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 24
        let cellWidth = UIScreen.main.bounds.width - (spacing * 3) //디바이스 너비 - (spacing * 4(보이고 싶은 갯수 +1))

        layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth / 2 + 70) //셀크기, 높이는 1:1비율인 이미지의 높이에 텍스트라벨 2개 높이+콘스트레인츠 = 70
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing) //시작으로부터 여백
        layout.minimumLineSpacing = spacing //셀과 셀 사이 여백
        layout.minimumInteritemSpacing = 0 //위아래 간격
        layout.scrollDirection = .vertical
        
        cityCollectionView.collectionViewLayout = layout
        
        titleLabel.text = "인기 도시"
        titleLabel.font = .boldSystemFont(ofSize: 20)

        domesticTravelSegmentedControl.setTitle("모두", forSegmentAt: 0)
        domesticTravelSegmentedControl.setTitle("국내", forSegmentAt: 1)
        domesticTravelSegmentedControl.setTitle("해외", forSegmentAt: 2)
    }
}
