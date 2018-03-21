//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by Tran Uy Du on 20/03/2018.
//  Copyright © 2018 Tran Uy Du. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    //Define core data constain
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let realm = try! Realm()
    var dataSource : Results<Category>? //: [Category] = [Category]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    //MARK: Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = dataSource?[indexPath.row].name ?? "No category added"
        return cell
    }
    
    func saveData(category : Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print ("Error when saving data \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData() {
        dataSource = realm.objects(Category.self)
//        do {
//            dataSource = try context.fetch(request)
//        }
//        catch {
//            print("Error when fetching the data \(error)")
//        }
    }
    
    //MARK: Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = dataSource?[indexPath.row] as Category?
        }
    }
    
    //MARK: Data Manipulation Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 1
    }
    
    //MARK: Add new categories
    @IBAction func buttinPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new item", message: "Please add a category", preferredStyle: UIAlertControllerStyle.alert)
        let addAction = UIAlertAction(title: "Add item", style: UIAlertActionStyle.default) { (addItem) in
            let newItem = Category()
            newItem.name = textField.text!
            self.saveData(category:  newItem)
        }
        alert.addAction(addAction)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create a new category"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
}
