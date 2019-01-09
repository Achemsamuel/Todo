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
    var itemArray = [String]()
    let defaults = UserDefaults.standard
    
    
    
    //LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateUI()
       
    }

    
    //Add New Actions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //what happens when the user clicks the add item button on UI Alert
            print("add button pressed")
            
                self.itemArray.append(textField.text!)
              self.defaults.set(self.itemArray, forKey: "Todo List Array")
           
                self.updateUI()
            
        }
       
            alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //Mark: Update UI
    
    func updateUI () {
        tableView.reloadData()
        if let items = defaults.array(forKey: "Todo List Array") as? [String] {
            itemArray = items
        }
        
    }
   
}

