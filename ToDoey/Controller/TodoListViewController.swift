//
//  ViewController.swift
//  ToDoey
//
//  Created by Tran Uy Du on 18/03/2018.
//  Copyright © 2018 Tran Uy Du. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()// ["Find Mike", "Buy Eggos" , "Destroy Demogoron", "a", "b", "c", "d", "e", "z", "w", "t", "lol", "azerty", "qsd", "plo", "qsd" , "aze", "ope", "azqs", "aqdd", "plp", "qsdaze"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let item = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = item
        }
        create()
    }
    
    //MARK -- Add new item
    @IBAction func addButtonPressed(_ sender: Any) {
        let allert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: UIAlertControllerStyle.alert)
        var textField = UITextField()
        let action = UIAlertAction(title: "Add item", style: UIAlertActionStyle.default) { (action) in
            // When user clicks
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
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
    
    func create() {
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Find Mike"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Find Mike"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Find Mike"
        itemArray.append(newItem3)
        
        let newItem4 = Item()
        newItem4.title = "Find Mike "
        itemArray.append(newItem4)
        
        let newItem5 = Item()
        newItem5.title = "Find Mike"
        itemArray.append(newItem5)
        
        let newItem6 = Item()
        newItem6.title = "Find Mike"
        itemArray.append(newItem6)
        
        let newItem7 = Item()
        newItem7.title = "Find Mike"
        itemArray.append(newItem7)
        
        let newItem8 = Item()
        newItem8.title = "Find Mike"
        itemArray.append(newItem8)
        
        let newItem9 = Item()
        newItem9.title = "Find Mike"
        itemArray.append(newItem9)
        
        let newItem10 = Item()
        newItem10.title = "Find Mike"
        
    }
    //MARK - Tableviw Datasource Methodes
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        print("cell for row call")
        cell.textLabel?.text = itemArray[indexPath.row].title
        let item = itemArray[indexPath.row]
        cell.accessoryType = item.done == true ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK -  TableView Delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

