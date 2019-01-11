//
//  ViewController.swift
//  Todo
//
//  Created by Achem Samuel on 1/8/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    

    //MARK: Variable Declaratons
    
    let todoTableCellIdentifier = "todoItemCell"
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    //LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath!)
        // Do any additional setup after loading the view, typically from a nib.

        
//        if let items = defaults.array(forKey: "Todo List Array") as? [Item] {
//            itemArray = items
//        }

      loadItems()
      updateUI()
       
    }

    
    //Add New Actions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //what happens when the user clicks the add item button on UI Alert
            print("add button pressed")
            
                let newItem = Item()
                newItem.title = textField.text!
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
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            
            try data.write(to: dataFilePath!)
            
        } catch {
            print("Error encoding item array, \(error )")
        }
        
    }
    
    func loadItems () {
        if  let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
                
            } catch {
                print("Could not decode \(error)")
            }
        }
    }
    
    
    
    
    
    //Mark: Update UI
    
    func updateUI () {
        
         self.tableView.reloadData()
    }
   
    
    
}

