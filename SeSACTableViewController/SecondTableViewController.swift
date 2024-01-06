//
//  SecondTableViewController.swift
//  SeSACTableViewController
//
//  Created by ungq on 1/7/24.
//

import UIKit

class SecondTableViewController: UITableViewController {

    @IBOutlet var titleLabel: UILabel!
    
    var sectionList = ["전체 설정", "개인 설정", "기타"]
    var cellList = [
        ["공지사항", "실험실", "버전 정보"],
        ["개인/보안", "알림", "채팅", "멀티프로필"],
        ["고객센터/도움말"]
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        designTitleLabel()
    }
    
    //0. 섹션 갯수 및 타이틀 설정
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionList.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionList[section]
    }
    
    //1. 행 갯수 설정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if section == 0 {
//            return cellList[section].count
//        } else if section == 1 {
//            return cellList[section].count
//        } else if section == 2 {
//            return cellList[section].count
//        } else {
//            return 0
//        }
        
        return cellList[section].count
    }

    
    //2. 셀 디자인
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell")! as! SecondTableViewCell
//        
//        if indexPath.section == 0 {
//            cell.titleLabel.text = cellList[indexPath.section][indexPath.row]
//        } else if indexPath.section == 1 {
//            cell.titleLabel.text = cellList[indexPath.section][indexPath.row]
//        }
        //            if indexPath.row == 0 {
        //                cell.titleLabel.text = cellList[0][0]
        //            } else if indexPath.row == 1 {
        //                cell.titleLabel.text = cellList[0][1]
        //            }
        
        cell.titleLabel.text = cellList[indexPath.section][indexPath.row]
        cell.titleLabel.font = .systemFont(ofSize: 14)

        return cell
    }
    
    //3. 셀 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func designTitleLabel() {
        titleLabel.text = "설정"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 20)
    }
    
}
     
