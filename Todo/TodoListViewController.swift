//
//  ViewController.swift
//  Todo
//
//  Created by Achem Samuel on 1/8/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    // Variables
    
    let todoTableCellIdentifier = "todoItemCell"
    var itemArray = [String]()
    
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
                print(self.itemArray)
                
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
    }
   
}

