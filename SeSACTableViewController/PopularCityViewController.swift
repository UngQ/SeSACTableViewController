//
//  PopularCityViewController.swift
//  SeSACTableViewController
//
//  Created by ungq on 1/9/24.
//

import UIKit



class PopularCityViewController: UIViewController {
    
    @IBOutlet var domesticTravelSegmentedControl: UISegmentedControl!
    @IBOutlet var cityCollectionView: UICollectionView!
    
    let cityInfo = CityInfo().city
    var filteredCityInfo: [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        filteredCityInfo = cityInfo
        designMainView()
    }
    
    @IBAction func changedSegments(_ sender: UISegmentedControl) {
        filterCityInfo(index: domesticTravelSegmentedControl.selectedSegmentIndex)
        cityCollectionView.reloadData()
    }
    
    func filterCityInfo(index: Int) {
        guard let travelType = TravelType(rawValue: index) else { return }
        switch travelType {
        case .모두:
            filteredCityInfo = cityInfo
        case .국내:
            filteredCityInfo = cityInfo.filter{ $0.domestic_travel }
        case .해외:
            filteredCityInfo = cityInfo.filter{ !$0.domestic_travel }
        }
    }
}


extension PopularCityViewController: UIProtocol {
    
    func designMainView() {
        navigationItem.title = "인기 도시"
        
        let xib = UINib(nibName: "PopularCityCollectionViewCell", bundle: nil)
        cityCollectionView.register(xib, forCellWithReuseIdentifier: "PopularCityCollectionViewCell")
        
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
        
        domesticTravelSegmentedControl.setTitle("모두", forSegmentAt: 0)
        domesticTravelSegmentedControl.setTitle("국내", forSegmentAt: 1)
        domesticTravelSegmentedControl.insertSegment(withTitle: "해외", at: 2, animated: false)
    }
}

extension PopularCityViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCityInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCityCollectionViewCell", for: indexPath) as! PopularCityCollectionViewCell
        cell.configureCell(cityInfo: filteredCityInfo, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "DetailCityInfoViewController") as! DetailCityInfoViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}
