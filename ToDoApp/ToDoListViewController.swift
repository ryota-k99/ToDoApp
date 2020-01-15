//
//  ViewController.swift
//  ToDoApp
//
//  Created by Kato Ryota  on 13/01/20.
//  Copyright © 2020 Kato Ryota . All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
   var itemList: Results<DataModel>!
   let realm = try! Realm()

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item:DataModel = self.itemList[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = item.toDoThing
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let realm = try! Realm()
        
        self.itemList = realm.objects(DataModel.self)
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Items", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default){(action)in
            
            let toDoData: DataModel = DataModel()
            toDoData.toDoThing = textField.text!
            
            let realmData = try! Realm()
            
            try! realmData.write {
                realmData.add(toDoData)
            }
            
            self.tableView.reloadData()

        }
        
        alert.addTextField{(alertTextField)in
            alertTextField.placeholder = "Create"
            textField = alertTextField
            
        }
        
        
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            if let item: DataModel = itemList[indexPath.row]{
                do{
                    try realm.write {
                        realm.delete(item)
                         self.tableView.reloadData()
                    }
                }catch{
                    print(error)
                }
            }
        }
        
       }
            
            
            
            
    

}

