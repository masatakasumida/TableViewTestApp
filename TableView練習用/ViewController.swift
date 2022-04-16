//
//  ViewController.swift
//  TableView練習用
//
//  Created by 住田雅隆 on 2022/02/12.
//

import UIKit

class ViewController: UIViewController {
    
    var vegetable = ["人参","玉葱","南瓜"]
    var fruits = ["キウイ","オレンジ","メロン"]
    let sectionTitle: NSArray = ["野菜", "フルーツ"]
        
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func toSecondViewButton(_ sender: Any) {
        let secondVC = storyboard?.instantiateViewController(identifier: "secondView") as! SecondViewController
        navigationController?.pushViewController(secondVC,animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //空白のセルの表示を設定。デフォルトで空白は表示されない
        tableView.tableFooterView = UIView(frame: .zero)
        // trueでセルの選択、falseで選択無効※isEditingモードでは無効になる
        //tableView.allowsSelection = true
        // trueで複数選択、falseで単一選択※isEditingモードでは無効になる
        //tableView.allowsMultipleSelection = true
        //編集を可能にする
        tableView.isEditing = true
        
        //セルの選択が出来る様にになる※isEditingモードで有効になる
        //tableView.allowsSelectionDuringEditing = false
        //左にチェックマークが付く※isEditingモードで有効になる　同時に複数選択可能になる
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let indexPaths = tableView.indexPathsForSelectedRows
    
        self.tableView.reloadData()
        
                
        indexPaths?.forEach {
            tableView.selectRow(at: $0, animated: false, scrollPosition: .none)
        }
    }
    
    //    func makeContextMenu(indexPathRow: Int) -> UIMenu {
    //
    //        let edit = UIAction(title: "編集", image: UIImage(systemName: "pencil")) { action in
    //            var uiTextField = UITextField()
    //            let ac = UIAlertController(title: "編集内容を記入して下さい", message: "", preferredStyle: .alert)
    //            let ok = UIAlertAction(title: "編集する", style: .default) { (action) in
    //                print(uiTextField.text!)
    //            }
    //            let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
    //                print("キャンセルされました")
    //            }
    //            ac.addTextField { (textField) in
    //                uiTextField.placeholder = "メモ"
    //                uiTextField = textField
    //                textField.keyboardType = .namePhonePad
    //            }
    //            ac.addAction(ok)
    //            ac.addAction(cancel)
    //            self.present(ac, animated: true, completion: nil)
    //            print("編集します")
    //
    //        }
    //        let delete = UIAction(title: "削除", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
    //            let indexPath = IndexPath(row: indexPathRow, section: 0)
    //            self.vegetable.remove(at: indexPathRow)
    //            self.tableView.deleteRows(at: [indexPath], with: .automatic)
    //            //self.tableView.reloadData()
    //        }
    //        return UIMenu(title: "Menu", children: [edit, delete])
    //    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //並び替えの許可
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //セルの右側に並び替えマークが付き、指定したindexPathの並び替えが出来る
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let itemToMove = vegetable.remove(at: sourceIndexPath.row)
        vegetable.insert(itemToMove, at: destinationIndexPath.row)
    }
    //    //セルの編集許可デフォルトで全ての行が編集可能みたい
    //    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    //    {
    //        return true
    //    }
    //
    //    //スワイプしたセルを削除
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == UITableViewCell.EditingStyle.delete {
    //            if indexPath.section == 0 {
    //                vegetable.remove(at: indexPath.row)
    //            }else if indexPath.section == 1 {
    //                fruits.remove(at: indexPath.row)
    //            }
    //
    //            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
    //        }
    //    }
    //セルの長押し時、実行されるメソッド
    //    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    //        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
    //            var indexPathRow = 0
    //            indexPathRow = indexPath.row
    //            return self.makeContextMenu(indexPathRow: indexPathRow)
    //        })
    //    }
    // セクション数を指定
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    // セクションタイトルを指定
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label : UILabel = UILabel()
        label.textColor = UIColor.systemGreen
        if(section == 0){
            label.text = (sectionTitle[section] as! String)
        } else if (section == 1){
            label.text = (sectionTitle[section] as! String)
        }
        return label
    }
    
    // セル数を指定
    // これはマスト！
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return vegetable.count
        }
        else if section == 1 {
            return fruits.count
        }
        else {
            return 0
        }
    }
    
    // 実際にCellを作る
    // これはマスト！
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        if indexPath.section == 0 {
            cell.textLabel?.text = String(describing: vegetable[indexPath.row])
            cell.detailTextLabel?.text = "行番号 : \(indexPath.row)"
            cell.imageView?.image = UIImage(named: "blue")
            cell.textLabel?.textColor = UIColor.red
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 30)
            return cell
        }
        else if indexPath.section == 1 {
            cell.textLabel?.text = String(describing: fruits[indexPath.row])
            cell.textLabel?.textColor = UIColor.blue
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 40)
            
        }
        return cell
    }
    //Cellがタップされた時の処理はここ
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)がtapされたよ")
        if let cell = tableView.cellForRow(at: indexPath) {
            let attributeString =  NSMutableAttributedString(string: vegetable[indexPath.row])
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            cell.textLabel?.attributedText = attributeString
            
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let attributeString =  NSMutableAttributedString(string: vegetable[indexPath.row])
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 0, range: NSMakeRange(0, attributeString.length))
            cell.textLabel?.attributedText = attributeString
        }
    }
}
