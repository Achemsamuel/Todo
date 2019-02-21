//
//  ViewController.swift
//  Todo
//
//  Created by Achem Samuel on 1/8/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    

    //MARK: Variable Declaratons
    
    let todoTableCellIdentifier = "todoItemCell"
    var itemArray = [Item]()
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        print(dataFilePath!)
        // Do any additional setup after loading the view, typically from a nib.
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//        if let items = defaults.array(forKey: "Todo List Array") as? [Item] {
//            itemArray = items
//        }


        updateUI()
       
    }

    
    //Add New Actions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //what happens when the user clicks the add item button on UI Alert
            print("add button pressed")
            
            let newItem = Item(context: self.context)
                newItem.title = textField.text!
                newItem.done = false
                newItem.parentCategory = self.selectedCategory
                self.itemArray.append(newItem)
            
            self.saveItems()
            
         
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
    
    func saveItems () {
        
        do {
       try  context.save()
        } catch {
            print("Error, Could not save context properly\(error)")
        }
        
    }
    
    func loadItems (with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
            
        } else {
            request.predicate = categoryPredicate
        }

        do {
          itemArray =  try context.fetch(request)
        } catch {
            print("Error Could not fetch request from context \(error)")
        }
        self.tableView.reloadData()
    
    }
    
    
    
    //Mark: Update UI
    
    func updateUI () {
        
         self.tableView.reloadData()
    }
    
}

