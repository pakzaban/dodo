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
    
    //get the file path to the documents folder and append a newplist to it to hold persistent data
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItemsFromPlist()//retrieves saved items from p_list and repopulates itemArray
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
            
            self.saveItemsToPlist()
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
        //toggle the done property of the selected item AND save it to pList
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItemsToPlist()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func saveItemsToPlist(){
        //make a p_list and write the itemArray onto it to create persistent storage
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }
        catch{
            print("Error encoding itemArray \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItemsFromPlist(){
        
        do{
            let data = try Data(contentsOf: dataFilePath!)
            let decoder = PropertyListDecoder()
            itemArray = try decoder.decode([Item].self, from: data)
        }
        catch{
            print("decoding failed. \(error)")
        }
    
    }
}

