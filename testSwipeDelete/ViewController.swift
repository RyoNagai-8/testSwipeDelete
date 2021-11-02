//
//  ViewController.swift
//  testSwipeDelete
//
//  Created by RyoNagai on 2021/10/26.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var testTableView: UITableView!
    var textlist = [Entity]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testTableView.delegate = self
        testTableView.dataSource = self
        addTextlist()
    }
    
    //MARK: - 新しい項目を追加する
    /**
     新しい項目を追加する
     */
    func addTextlist(){
        //データを入力する
        let newItem = Entity(context: self.context)
        newItem.test = "test"
        textlist.append(newItem)
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
        
        cell.textLabel?.text = "test"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

            // 先にデータを削除しないと、エラーが発生する。
            //tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    
    
}

