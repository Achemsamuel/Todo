////
////  CellibateTableViewController.swift
////  Todo
////
////  Created by Achem Samuel on 2/26/19.
////  Copyright © 2019 Achem Samuel. All rights reserved.
////
//
//import UIKit
//import RealmSwift
//
//class CellibateTableViewController: UITableViewController {
//
//    let realmy = try! Realm()
//    var cellibateArray : Results<Cellibate>?
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        loadCellibateDudes()
//
//  
//    }
//
//    // MARK: - Table view data source
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return cellibateArray?.count ?? 1
//    }
//
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellibate", for: indexPath)
//
//        cell.textLabel?.text = cellibateArray?[indexPath.row].cellibateToby ?? "Toby ain't Cellibate shit!!"
//
//        return cell
//    }
// 
//
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//    /*
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
//    */
//
//    /*
//    // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//    }
//    */
//
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the item to be re-orderable.
//        return true
//    }
//    */
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//    
//    @IBAction func cellibateButtonPressed(_ sender: UIBarButtonItem) {
//        
//        var textfield = UITextField()
//        
//        let alert = UIAlertController(title: "Add Cellibate Name", message: "Add Cellibacy Status", preferredStyle: .alert)
//        
//        let action = UIAlertAction(title: "Add Name", style: .default) { (action) in
//            print("Alert Button Pressed")
//            
//            let newCellibateDude = Cellibate()
//            newCellibateDude.cellibateToby = textfield.text!
//            
//            self.saveCellibateDude(cellibate: newCellibateDude)
//            
//        }
//        
//        alert.addAction(action)
//        present(alert, animated:true, completion: nil)
//        alert.addTextField { (alertTextField) in
//        alertTextField.placeholder = "Add New Cellibate Dude"
//        textfield = alertTextField
//            
//        }
//        
//    }
//    
//    func saveCellibateDude(cellibate : Cellibate) {
//        do {
//            try realmy.write {
//                realmy.add(cellibate)
//            }
//        } catch {
//            print("Could Not Save Realmy Add")
//        }
//        self.tableView.reloadData()
//    
//    }
//    
//    func loadCellibateDudes () {
//        cellibateArray = realmy.objects(Cellibate.self)
//        
//        self.tableView.reloadData()
//    }
//    
//
//}
