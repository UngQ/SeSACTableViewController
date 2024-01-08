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
    
    var savedList = UserDefaults.standard.array(forKey: "list") as? [String]
    var savedCheckAndStar = UserDefaults.standard.array(forKey: "bool") as? [[Bool]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designMainView()

        list = savedList ?? []
        checkAndStar = savedCheckAndStar ?? []
    }
    
    //추가 버튼 클릭시 기능
    @IBAction func appendButtonClicked(_ sender: UIButton) {
        
        if inputTextField.text != "" {
            list.append(inputTextField.text!)
            checkAndStar.append([false, false])
            
            UserDefaults.standard.set(list, forKey: "list")
            UserDefaults.standard.set(checkAndStar, forKey: "bool")
            
            successAlert()
            inputTextField.text = ""
            
            tableView.reloadData()
        } else {
            cancelAlert()
        }
    }
    
    //체크 버튼 클릭
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        if checkAndStar[sender.tag][0] == false {
            checkAndStar[sender.tag][0] = true
        } else if checkAndStar[sender.tag][0] == true {
            checkAndStar[sender.tag][0] = false
        }
        UserDefaults.standard.set(checkAndStar, forKey: "bool")
        tableView.reloadData()
    }
    
    //스타 버튼 클릭
    @IBAction func starButtonClicked(_ sender: UIButton) {
        if checkAndStar[sender.tag][1] == false {
            checkAndStar[sender.tag][1] = true
        } else if checkAndStar[sender.tag][1] == true {
            checkAndStar[sender.tag][1] = false
        }
        UserDefaults.standard.set(checkAndStar, forKey: "bool")
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdTableViewCell", for: indexPath) as! ThirdTableViewCell
        
        switch checkAndStar {
        case []:
            return cell
        default:
            cell.backgroundColor = .systemGray6
            cell.layer.cornerRadius = 15
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 1

            //Check, Star 버튼에서 indexPath.row를 활용하기 위해 tag에 담기
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
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            list.remove(at: indexPath.row)
            checkAndStar.remove(at: indexPath.row)
            
            UserDefaults.standard.set(list, forKey: "list")
            UserDefaults.standard.set(checkAndStar, forKey: "bool")
            
            tableView.reloadData()
        }
    }
    
    func successAlert() {
        let alert = UIAlertController(title: "추가 성공", message: .none, preferredStyle: .alert)
        let alertOKButton = UIAlertAction(title: "확인", style: .default)
        alert.addAction(alertOKButton)
        present(alert, animated: true)
    }
    
    func cancelAlert() {
        let alert = UIAlertController(title: "추가할 아이템을 입력하세요.", message: .none, preferredStyle: .alert)
        let alertCancleButton = UIAlertAction(title: "확인", style: .default)
        alert.addAction(alertCancleButton)
        present(alert, animated: true)
    }
    
    func designMainView() {
        view.tintColor = .black
  
        inputTextField.layer.cornerRadius = 15
        inputTextField.layer.borderColor = UIColor.black.cgColor
        inputTextField.layer.borderWidth = 1
        appendButton.layer.cornerRadius = 15
        
        titleTextLabel.text = "Shopping List"
        titleTextLabel.font = .boldSystemFont(ofSize: 24)
        
        appendButton.setTitle("Add", for: .normal)
        appendButton.backgroundColor = .systemGray5
    }
}
