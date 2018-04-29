//
//  ViewController.swift
//  dodo
//
//  Created by Peyman PAKZABAN on 4/29/18.
//  Copyright © 2018 Peyman PAKZABAN. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["do first", "do next", "do last"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func createToDoPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField() //creatimg a local varaiable witha bigger reach than alertTextField
        
        let alert = UIAlertController(title: "Add a new item to do.", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //creates button on po-up alert.  The completion handler describes what that button does.
            print(textField.text as Any)
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        
        alert.addTextField { (alertTextField) in
            //alertTextField is only available inside this closure
            alertTextField.placeholder = "new item"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}

