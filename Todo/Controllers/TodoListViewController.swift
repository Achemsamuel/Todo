//
//  ViewController.swift
//  Todo
//
//  Created by Achem Samuel on 1/8/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class TodoListViewController: UITableViewController {
    

    //MARK: Variable Declaratons
    
    let realm = try! Realm()
//    var dateFormatter : DateFormatter {
//        self.dateFormatter.dateFormat = "dd.MM.yyyy"
//    }
    
    
    let todoTableCellIdentifier = "todoItemCell"
    var todoItems : Results<Item>?
    var selectedCategory : Category? {
        didSet {
           loadItems()
        }
    }
   // let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
  print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

        updateUI()
       
    }

    
    //Add New Actions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //what happens when the user clicks the add item button on UI Alert
            print("add button pressed")
            
            if let currentCategory = self.selectedCategory {
                
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error Saving Items \(error)")
                }
                
            }
            
         
            self.updateUI()
            
        }
       
            alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: Model Adjusting Methods
    
    
    func loadItems () {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        self.tableView.reloadData()

    }
    
    
    
    //Mark: Update UI
    
    func updateUI () {
        
         self.tableView.reloadData()
    }
    
}

