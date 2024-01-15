//
//  PopularCityViewController.swift
//  SeSACTableViewController
//
//  Created by ungq on 1/9/24.
//

import UIKit



class PopularCityViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var domesticTravelSegmentedControl: UISegmentedControl!
    @IBOutlet var cityCollectionView: UICollectionView!
    
    let originalList = CityInfo().city
    var list: [City] = CityInfo().city {
        didSet {
            cityCollectionView.reloadData()
        }
    }
    var domesticList: [City] = []
    var nonDomesticList: [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        domesticFilteredList()
        
        designMainView()
    }
    
    func domesticFilteredList() {
        for item in originalList {
            if item.domestic_travel == true {
                domesticList.append(item)
            } else {
                nonDomesticList.append(item)
            }
        }
    }
    
    
    @IBAction func changedSegments(_ sender: Any) {

        switch domesticTravelSegmentedControl.selectedSegmentIndex {
        case 1:
            list = domesticList
        case 2:
            list = nonDomesticList
        default:
            list = originalList
        }
        
        searchBar.text = ""
    }
    
    
    func textFilteredList(list: [City], searchText: String) -> [City] {
        var filteredList: [City] = []
        var capitalizedSearchText: String = ""
        
        for item in list {
            capitalizedSearchText = searchText.capitalized
            if item.city_name.contains(capitalizedSearchText) ||
                item.city_english_name.contains(capitalizedSearchText) ||
                item.city_explain.contains(capitalizedSearchText) {
                filteredList.append(item)
            }
        }
        return filteredList
    }
}



extension PopularCityViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var filteredList: [City] = []
        
        trimmingTextField(textfield: searchBar.searchTextField)
        
        switch domesticTravelSegmentedControl.selectedSegmentIndex {
        case 1:
            if searchText == "" {
                filteredList = domesticList
            } else {
                filteredList = textFilteredList(list: domesticList, searchText: searchText)
            }
        case 2:
            if searchText == "" {
                filteredList = nonDomesticList
            } else {
                filteredList = textFilteredList(list: nonDomesticList, searchText: searchText)
            }
        default:
            if searchText == "" {
                filteredList = originalList
            } else {
                filteredList = textFilteredList(list: originalList, searchText: searchText)
            }
        }
        
        list = filteredList
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        changedSegments(searchBar)
    }
    
    

}



extension PopularCityViewController: UIProtocol {
    
    func designMainView() {
        navigationItem.title = "인기 도시"
        
        let xib = UINib(nibName: "PopularCityCollectionViewCell", bundle: nil)
        cityCollectionView.register(xib, forCellWithReuseIdentifier: "PopularCityCollectionViewCell")
        
        cityCollectionView.dataSource = self
        cityCollectionView.delegate = self
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.layer.borderWidth = 1
        searchBar.layer.masksToBounds = true
        
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
    
    func trimmingTextField(textfield: UITextField) {
        textfield.text = textfield.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
}




extension PopularCityViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCityCollectionViewCell", for: indexPath) as! PopularCityCollectionViewCell
        cell.configureCell(cityInfo: list, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "DetailCityInfoViewController") as! DetailCityInfoViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}
