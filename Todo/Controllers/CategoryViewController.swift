//
//  CategoryViewController.swift
//  Todo
//
//  Created by Achem Samuel on 2/17/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    //Data Variable
    
    let categoryCellIdentifier = "categoryCell"
    let itemsSegueIdentifier = "goToItems"
    var categoryArray : Results<Category>?
    var selectedCellCatColor = UIColor()
   // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
       // self.tableView.reloadData()
        
    }
    

    //MARK: Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            
            print("Add category Button pressed")
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat.hexValue()
            
            self.save(category: newCategory)
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return  categoryArray?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text  = categoryArray?[indexPath.row].name ?? "No categories Added Yet"
        
        //let categoryColor =
        if let categoryColor = UIColor(hexString: categoryArray?[indexPath.row].color ?? "0096FF") {
            
            cell.backgroundColor = categoryColor
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
            
           // self.selectedCellCatColor = categoryColor
        }
        
        
        return cell
    }
    
    //MARK: - Table View Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: itemsSegueIdentifier, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
            
        }
        
    }
    
    //MARK: - Data Manipulation Methods
    
    func save (category : Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        }
        catch {
            print("Error could not save: \(error)")
        }
        self.tableView.reloadData()
        
    }
    
    func loadCategories () {
        
        categoryArray = realm.objects(Category.self)
        
        self.tableView.reloadData()
        
    }
    
    //Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        
                        if let categoryForDeletion = self.categoryArray?[indexPath.row] {
                            do {
                                try self.realm.write {
                                    self.realm.delete(categoryForDeletion)
                                }
                            }    catch {
                                print("Could not delete Category Item: \(error)")
                            }
        
                          
        
                        }
    }
    
}
