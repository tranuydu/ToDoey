//
//  ViewController.swift
//  ToDoey
//
//  Created by Tran Uy Du on 18/03/2018.
//  Copyright © 2018 Tran Uy Du. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    let defaults = UserDefaults.standard
    let dataFileManager = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        if let item = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = item
//        }
        //create()
        //readData()
    }
    
    //MARK -- Add new item
    @IBAction func addButtonPressed(_ sender: Any) {
        let allert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: UIAlertControllerStyle.alert)
        var textField = UITextField()
        let action = UIAlertAction(title: "Add item", style: UIAlertActionStyle.default) { (action) in
            // When user clicks
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.saveData()
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
        newItem1.title = "Find Du"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Find Tony"
        itemArray.append(newItem2)
        
        
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
        
        saveData()
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK saveData
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error encoding item array", error)
        }
    }
    
    //MARK readSaveData
//    func readData() {
//        if let data = try? Data(contentsOf: dataFileManager!) {
//            let decoder = PropertyListDecoder()
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("Decode itemArray error \(error)")
//            }
//        }
//    }
}

