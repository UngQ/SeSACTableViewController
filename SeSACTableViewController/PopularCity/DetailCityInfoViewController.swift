//
//  DetailCityInfoViewController.swift
//  SeSACTableViewController
//
//  Created by ungq on 1/11/24.
//

import UIKit

class DetailCityInfoViewController: UIViewController {

    var travelInfoList = TravelInfo().travel
    
    @IBOutlet var detailCityInfoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
}

//내가 만든 기능
extension DetailCityInfoViewController {
    func configureViewController() {
        detailCityInfoTableView.delegate = self
        detailCityInfoTableView.dataSource = self
        
        navigationItem.title = "도시 상세 정보"
        detailCityInfoTableView.rowHeight = UITableView.automaticDimension
        
        let xib = UINib(nibName: DetailCityInfoTableViewCell.identifier, bundle: nil)
        detailCityInfoTableView.register(xib, forCellReuseIdentifier: DetailCityInfoTableViewCell.identifier)
        
        let xib2 = UINib(nibName: ADTableViewCell.identifier, bundle: nil)
        detailCityInfoTableView.register(xib2, forCellReuseIdentifier: ADTableViewCell.identifier)
    }
}

//테이블뷰 관련 기능
extension DetailCityInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        travelInfoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        if travelInfoList[indexPath.row].ad {
            let cell = tableView.dequeueReusableCell(withIdentifier: ADTableViewCell.identifier, for: indexPath) as! ADTableViewCell

            cell.backView.layer.cornerRadius = 10
            cell.backView.backgroundColor = UIColor(red: .random(in: 0...1),
                                                    green: .random(in: 0...1),
                                                    blue: .random(in: 0...1),
                                                    alpha: 1)
            
            cell.adTitleLabel.text = travelInfoList[indexPath.row].title
            cell.adTitleLabel.font = .boldSystemFont(ofSize: 20)
            cell.adTitleLabel.numberOfLines = 0
            cell.adTitleLabel.textAlignment = .center
            
            cell.adPopLabel.text = "AD"
            cell.adPopLabel.textAlignment = .center
            cell.adPopLabel.backgroundColor = .white
            cell.adPopLabel.font = .systemFont(ofSize: 10)
            cell.adPopLabel.layer.cornerRadius = 5
            cell.adPopLabel.clipsToBounds = true
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailCityInfoTableViewCell.identifier, for: indexPath) as! DetailCityInfoTableViewCell
            
            cell.savedButton.tag = indexPath.row
            
            let gradeStar: String
            switch travelInfoList[indexPath.row].grade! {
            case 0...1: gradeStar = "★☆☆☆☆"
            case 1...2: gradeStar = "★★☆☆☆"
            case 2...3: gradeStar = "★★★☆☆"
            case 3...4: gradeStar = "★★★★☆"
            case 4...5: gradeStar = "★★★★★"
            default: gradeStar = "error"
            }
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let formattedSave = formatter.string(from: travelInfoList[indexPath.row].save! as NSNumber)
            
            cell.travelTitleLabel.text = travelInfoList[indexPath.row].title
            cell.travelTitleLabel.font = .boldSystemFont(ofSize: 14)
            cell.travelDescriptionLabel.text = travelInfoList[indexPath.row].description
            cell.travelDescriptionLabel.numberOfLines = 0
            cell.travelDescriptionLabel.font = .systemFont(ofSize: 12)
            
            cell.starLabel.text = gradeStar
            cell.starLabel.textColor = .systemYellow
            cell.starLabel.font = .systemFont(ofSize: 10)
            
            cell.travelGradeSaveLabel.text = "(\(travelInfoList[indexPath.row].grade!))ㆍ저장 \(formattedSave!)"
            cell.travelGradeSaveLabel.font = .systemFont(ofSize: 10)
            
            let url = URL(string: travelInfoList[indexPath.row].travel_image!)
            cell.travelImageView.kf.setImage(with: url)
            cell.travelImageView.contentMode = .scaleAspectFill
            cell.travelImageView.layer.cornerRadius = 10
            
            let image = travelInfoList[indexPath.row].like! ? "heart" : "heart.fill"
            cell.savedButton.setImage(UIImage(systemName: image), for: .normal)
            cell.savedButton.sizeToFit()
            cell.savedButton.tintColor = .white

            
            cell.savedButton.layer.opacity = 0.8

            cell.savedButton.addTarget(self, action: #selector(savedButtonClicked), for: .touchUpInside)
            
            return cell
        }
    }
    
    @objc func savedButtonClicked(sender: UIButton) {
        travelInfoList[sender.tag].like?.toggle()
        detailCityInfoTableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if travelInfoList[indexPath.row].ad {
            let viewController = storyboard?.instantiateViewController(identifier: ADViewController.identifier) as! ADViewController
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true)
        } else {
            let viewController = storyboard?.instantiateViewController(identifier: TravelViewController.identifier) as! TravelViewController
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
