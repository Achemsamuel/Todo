//
//  TodoListTableViewCell.swift
//  Todo
//
//  Created by Achem Samuel on 1/8/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import UIKit
import CoreData

extension TodoListViewController : UISearchBarDelegate  {
    
    
    //MARK: TableView DataSource Methods
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return itemArray[section]
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: todoTableCellIdentifier, for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        //Ternary Operator
        // Value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ?  .checkmark : .none
        
        return cell
    }
    
    
    
    // TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
                            itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        saveItems()
        updateUI()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK: Search Bar Methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
         request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
            }
        
        }
    }
    
    
}
