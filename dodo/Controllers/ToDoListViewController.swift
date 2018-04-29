//
//  ViewController.swift
//  dodo
//
//  Created by Peyman PAKZABAN on 4/29/18.
//  Copyright © 2018 Peyman PAKZABAN. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    let defaults = UserDefaults.standard //instantiates the userDefault class for storage of persistent values on the local device
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "do first"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "do next"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "do last"
        itemArray.append(newItem3)
        
        //retrive itemArray from persistent local storage
        if let items = defaults.array(forKey: "toDoArray") as? [Item]{
            itemArray = items
        }
    }
    @IBAction func createToDoPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField() //creatimg a local varaiable witha bigger reach than alertTextField
        
        // 1 & 2. to create a pop-up alert, must first define the controller and the action button
        let alert = UIAlertController(title: "Add a new item to do.", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //The completion handler describes what that button does.
            let newItem  = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.tableView.reloadData()
            
            self.defaults.set(self.itemArray, forKey: "toDoArray")//stores it locally and persistently
        }
        // 3. must add action (defined above) and the text field to the AlertController
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            //alertTextField is only available inside this closure
            alertTextField.placeholder = "new item"
            textField = alertTextField
        }
        // 4. finally, must present the AlertController
        present(alert, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        // this cell has textLabel and accessoryType properties that can be set
        
        let myItem = itemArray[indexPath.row]//defined during refactoring
        
        cell.textLabel?.text = myItem.title
        
        if myItem.done == true {
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //toggle the fone property of the selected item AND reloadData to make tableView update its data
        self.itemArray[indexPath.row].done = !self.itemArray[indexPath.row].done
        self.tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}

