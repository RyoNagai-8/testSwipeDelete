//
//  ViewController.swift
//  testSwipeDelete
//
//  Created by Ryo on 2021/10/26.
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
        self.loadTextlist()
        self.saveTextlist()
    }
    
    //MARK: - CoreData 読み込み
    func loadTextlist() {
        let request : NSFetchRequest<Entity> = Entity.fetchRequest()
        do{
            textlist = try context.fetch(request)
        } catch {
            print("Error loading checklist \(error)")
        }
    }
    
    //MARK: - CoreData 保存する
    func saveTextlist() {
        do {
            try context.save()
        } catch {
            print("Error saving Item \(error)")
        }
    }
    
    //MARK: - セルにデータを追加
    @IBAction func addText(_ sender: Any) {
        //空のデータを追加
        let newItem = Entity(context: self.context)
        //テキストを追加
        newItem.test = "test"
        textlist.append(newItem)
        //テーブルビューをリロード
        testTableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
        
        cell.textLabel?.text = textlist[indexPath.row].test
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 先にデータを削除しないと、エラーが発生する。
        let task = textlist[indexPath.row]
        context.delete(task)
        do {
            textlist = try context.fetch(Entity.fetchRequest())
        }
        catch{
            print("Error delete \(error)")
        }
        tableView.deleteRows(at: [indexPath], with: .automatic)
        self.saveTextlist()
    }
}

