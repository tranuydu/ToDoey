//
//  ViewController.swift
//  ToDoey
//
//  Created by Tran Uy Du on 18/03/2018.
//  Copyright © 2018 Tran Uy Du. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy Eggos" , "Destroy Demogoron" ]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let item = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = item
        }
    }
    
    //MARK -- Add new item
    @IBAction func addButtonPressed(_ sender: Any) {
        let allert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: UIAlertControllerStyle.alert)
        var textField = UITextField()
        let action = UIAlertAction(title: "Add item", style: UIAlertActionStyle.default) { (action) in
            // When user clicks
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        
        allert.addAction(action)
        allert.addTextField { (alertTextView) in
            alertTextView.placeholder = "Create new item"
            textField = alertTextView
        }
        
        present(allert, animated: true, completion: nil)
    }
    
    //MARK - Tableviw Datasource Methodes
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK -  TableView Delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

