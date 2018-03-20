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
        readData()
    }
    @IBOutlet weak var searchBar: UISearchBar!
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
        //itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //itemArray[indexPath.row].setValue("Completed", forKey: "title")
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
        
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
    func readData(with request : NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            itemArray  = try context.fetch(request)
        } catch {
            print("Error fetching data from contect")
        }
        tableView.reloadData()
    }
}
//MARK: - Searchbar methods
extension TodoListViewController : UISearchBarDelegate {
    //Searchbar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        readData(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            readData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

