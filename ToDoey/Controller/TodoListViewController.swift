//
//  ViewController.swift
//  ToDoey
//
//  Created by Tran Uy Du on 18/03/2018.
//  Copyright © 2018 Tran Uy Du. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    var toDoItems : Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
            readData()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    let defaults = UserDefaults.standard
//    let dataFileManager = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        //readData()
    }
    @IBOutlet weak var searchBar: UISearchBar!
    //MARK -- Add new item
    @IBAction func addButtonPressed(_ sender: Any) {
        let allert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: UIAlertControllerStyle.alert)
        var textField = UITextField()
        let action = UIAlertAction(title: "Add item", style: UIAlertActionStyle.default) { (action) in
             //newItem.parentCategory = selectedCategory?.name
            if let currentCategory = self.selectedCategory {
                  do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        currentCategory.items.append(newItem)
                        
                        self.realm.add(newItem)
                    }
                } catch {
                    print("Error encoding item array", error)
                }
            }
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
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
        if let item = toDoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done == true ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Item added"
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    //MARK -  TableView Delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //itemArray[indexPath.row].setValue("Completed", forKey: "title")
        //context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write {
                    //item.done = !item.done
                    realm.delete(item)
                }
            } catch {
                print ("Error saving done status \(error)")
            }
        }
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK readSaveData
    func readData() {
        if selectedCategory?.items != nil {
            toDoItems = (selectedCategory?.items)!.sorted(byKeyPath: "title", ascending: true)
            tableView.reloadData()
        }
    }
}
//MARK: - Searchbar methods
//extension TodoListViewController : UISearchBarDelegate {
//    //Searchbar
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        readData(with: request, predicate: predicate)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            readData()
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//    }
//}


