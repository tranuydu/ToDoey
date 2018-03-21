//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by Tran Uy Du on 20/03/2018.
//  Copyright © 2018 Tran Uy Du. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    //Define core data constain
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var dataSource : [Category] = [Category]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    //MARK: Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row].name
        return cell
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print ("Error when saving data \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            dataSource = try context.fetch(request)
        }
        catch {
            print("Error when fetching the data \(error)")
        }
    }
    
    //MARK: Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = dataSource[indexPath.row]
        }
    }
    
    //MARK: Data Manipulation Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    //MARK: Add new categories
    @IBAction func buttinPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new item", message: "Please add a category", preferredStyle: UIAlertControllerStyle.alert)
        let addAction = UIAlertAction(title: "Add item", style: UIAlertActionStyle.default) { (addItem) in
            let newItem = Category(context: self.context)
            newItem.name = textField.text!
            self.dataSource.append(newItem)
            self.saveData()
        }
        alert.addAction(addAction)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create a new category"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
}
