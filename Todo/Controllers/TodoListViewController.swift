//
//  ViewController.swift
//  Todo
//
//  Created by Achem Samuel on 1/8/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {
    

    //MARK: Variable Declaratons
    
    let realm = try! Realm()
//    var dateFormatter : DateFormatter {
//        self.dateFormatter.dateFormat = "dd.MM.yyyy"
//    }
    
    
    let todoTableCellIdentifier = "Cell"
    var todoItems : Results<Item>?
    var selectedCategory : Category? {
        didSet {
           loadItems()
        }
    }
    
    let categoryVC = CategoryViewController()
   // let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
            title =  selectedCategory?.name
            guard let hexColor = selectedCategory?.color else { fatalError() }
            updateNavigationBar(withHexColor: hexColor)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        updateNavigationBar(withHexColor: "310076")
    }
    
    
    //MARK: Navigation Bar Update Methods
    func updateNavigationBar (withHexColor colorHexColor : String) {

        guard let navigationBar = navigationController?.navigationBar else {
            fatalError("Navigation Contrller Does not exist")}
        
            guard let navigationBarColor = UIColor(hexString: colorHexColor) else { fatalError() }
            navigationBar.tintColor = ContrastColorOf(navigationBarColor, returnFlat: true)
            navigationBar.barTintColor = navigationBarColor
            searchBarDesign.barTintColor = navigationBarColor
            navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navigationBarColor, returnFlat: true)]
    }

    @IBOutlet weak var searchBarDesign : UISearchBar!
    
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
                      //  newItem.color = UIColor.flatPurpleDark.hexValue()
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
    
    //Swipe Delete Method
    
    override func updateModel(at indexPath: IndexPath) {
        
        if let itemForDeletion = todoItems?[indexPath.row] {
            
            do {
                try realm.write {
                    realm.delete(itemForDeletion)
                }
            } catch {
                print("Error, could not delete item: \(error)")
            }
        }
        
    }
    
    
}

