//
//  thirdTableViewController.swift
//  SeSACTableViewController
//
//  Created by ungq on 1/7/24.
//

import UIKit

struct ShoppingList: Codable {
    let itemName: String
    var checkBool: Bool
    var starBool: Bool
}

class ThirdTableViewController: UITableViewController {
    
    func designMainView() {
        view.tintColor = .black
  
        inputTextField.clipsToBounds = true
        inputTextField.backgroundColor = .systemGray6
        inputTextField.layer.cornerRadius = 15
        inputTextField.layer.borderColor = UIColor.systemGray6.cgColor
        inputTextField.layer.borderWidth = 1
        inputTextField.placeholder = "무엇을 구매하실 건가요?"

        titleTextLabel.text = "Shopping List"
        titleTextLabel.font = .boldSystemFont(ofSize: 24)
        
        appendButton.layer.cornerRadius = 15
        appendButton.setTitle("Add", for: .normal)
        appendButton.backgroundColor = .systemGray5
    }

    @IBOutlet var titleTextLabel: UILabel!
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var appendButton: UIButton!
    @IBOutlet var topView: UIView!
    
    var shoppingList: [ShoppingList] = []
    
// ShoppingList를 구조체로 구현하니, 기존처럼 UserDefault.standard.array가 먹히지 않아서 찾아봄..
// 아래 코드가 지금까지의 진도로는 잘 이해가 안가지만, 기존에 UserDefault 기능을 구현했어서 살려보고 싶어서 복붙함
    var savedShoppingList: [ShoppingList] {
        get {
            if let data = UserDefaults.standard.data(forKey: "list") {
                return (try? JSONDecoder().decode([ShoppingList].self, from: data)) ?? []
            }
            return []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: "list")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designMainView()
        shoppingList = savedShoppingList
    }
    
    @IBAction func appendButtonClicked(_ sender: UIButton) {
        if inputTextField.text == "" {
            showAlert(title: "추가할 아이템을 입력하세요", message: .none)
        } else {
            shoppingList.append(ShoppingList(itemName: inputTextField.text!, checkBool: false, starBool: false))
            savedShoppingList = shoppingList
            showAlert(title: "아이템 추가 성공", message: "언능 구매합시다")
            inputTextField.text = ""
            tableView.reloadData()
        }
    }
    
    //체크 버튼 클릭
//    @IBAction func checkButtonClicked(_ sender: UIButton) {
//        shoppingList[sender.tag].checkBool.toggle()
//        savedShoppingList = shoppingList
//        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
//    }
//    
    @objc func checkButtonClicked(sender: UIButton) {
        shoppingList[sender.tag].checkBool.toggle()
        savedShoppingList = shoppingList
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
    }

    //스타 버튼 클릭
//    @IBAction func starButtonClicked(_ sender: UIButton) {
//        shoppingList[sender.tag].starBool.toggle()
//        savedShoppingList = shoppingList
//        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
//    }
    
    @objc func starButtonClicked(sender: UIButton) {
    shoppingList[sender.tag].starBool.toggle()
    savedShoppingList = shoppingList
    tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
    }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdTableViewCell", for: indexPath) as! ThirdTableViewCell
        cell.configureCell(shoppingList, indexPath: indexPath)
        
        cell.checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)

        cell.starButton.addTarget(self, action: #selector(starButtonClicked), for: .touchUpInside)

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
            savedShoppingList = shoppingList
            tableView.reloadData()
        }
    }
    

}



