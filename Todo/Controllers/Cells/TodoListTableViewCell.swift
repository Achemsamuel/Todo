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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: todoTableCellIdentifier, for: indexPath)
        
        if let item =  todoItems?[indexPath.row] {
              cell.textLabel?.text = item.title
            
            //Ternary Operator
            // Value = condition ? valueIfTrue : valueIfFalse
            cell.accessoryType = item.done ?  .checkmark : .none
        } else {
            cell.textLabel?.text = "No Item Added"
            return cell
        }
       
        return cell
    }
    
    
    
    // TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            
            do {
                try realm.write {
                item.done = !item.done
                }
            } catch {
                    print("Unable to set Item.done property : \(error)")
            }
            
//            //Delete Data
//            do {
//                try realm.write {
//                    realm.delete(item)
//                }            } catch {
//                print(error)
//            }
        }
        updateUI()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK: Search Bar Methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
       todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
       
        updateUI()
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
