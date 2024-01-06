//
//  thirdTableViewController.swift
//  SeSACTableViewController
//
//  Created by ungq on 1/7/24.
//

import UIKit

class ThirdTableViewController: UITableViewController {

    @IBOutlet var titleTextLabel: UILabel!
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var appendButton: UIButton!
    
    var list: [String] = []
    var checkAndStar: [[Bool]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextLabel.text = "쇼핑"
        titleTextLabel.font = .boldSystemFont(ofSize: 20)

    }
    
    //추가 버튼 클릭시 기능
    @IBAction func appendButtonClicked(_ sender: UIButton) {
        list.append(inputTextField.text!)
        checkAndStar.append([false, false])
        tableView.reloadData()
    }
    
    //체크 버튼 클릭
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        if checkAndStar[sender.tag][0] == false {
            checkAndStar[sender.tag][0] = true
        } else if checkAndStar[sender.tag][0] == true {
            checkAndStar[sender.tag][0] = false
        }
        tableView.reloadData()
    }
    
    //스타 버튼 클릭
    @IBAction func starButtonClicked(_ sender: UIButton) {
        if checkAndStar[sender.tag][1] == false {
            checkAndStar[sender.tag][1] = true
        } else if checkAndStar[sender.tag][1] == true {
            checkAndStar[sender.tag][1] = false
        }
        print(checkAndStar)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdTableViewCell", for: indexPath) as! ThirdTableViewCell
        
        cell.checkButton.tag = indexPath.row
        cell.starButton.tag = indexPath.row
    
        cell.itemTextLabel.text = list[indexPath.row]
        
        if checkAndStar[indexPath.row][0] == false {
            cell.checkButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else if checkAndStar[indexPath.row][0] == true {
            cell.checkButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
        
        if checkAndStar[indexPath.row][1] == false {
            cell.starButton.setImage(UIImage(systemName: "star"), for: .normal)
        } else if checkAndStar[indexPath.row][1] == true {
            cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
