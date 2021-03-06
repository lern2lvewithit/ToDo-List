//
//  ToDoTableViewController.swift
//  ToDo LIst
//
//  Created by Steven Lerner on 2/26/18.
//  Copyright © 2018 Steven Lerner. All rights reserved.
//

import UIKit
import CoreData

class ToDoTableViewController: UITableViewController {
    
    var toDos : [ToDoCoreData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getToDos()
    }
    
    func getToDos() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            
            let fetchRequest: NSFetchRequest<ToDoCoreData> = ToDoCoreData.fetchRequest()
            let descriptors = [NSSortDescriptor(key: "important", ascending: false)]
            
            fetchRequest.sortDescriptors = descriptors
            
            if let coreDataToDos = try? context.fetch(fetchRequest) {
/*                if let theToDos = coreDataToDos {
                    toDos = theToDos
                    tableView.reloadData()
                }
*/
                toDos = coreDataToDos
                tableView.reloadData()
            }
        }
    }
    
    /*
    func createToDos() -> [ToDo] {
        
        let eggs = ToDo()
        eggs.name = "Buy Eggs"
        eggs.important = true
        
        let dog = ToDo()
        dog.name = "Walk the dog"
        
        let cheese = ToDo()
        cheese.name = "Eat Cheese"
        
        return [eggs, dog, cheese]
    }
    */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let toDo = toDos[indexPath.row]
        
        if let name = toDo.name {
            
            if toDo.important {
                cell.textLabel?.text = "❗️" + name
            } else {
                cell.textLabel?.text = toDo.name
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDo = toDos[indexPath.row]
        performSegue(withIdentifier: "moveToComplete", sender: toDo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddToDoViewController {
            addVC.previousVC = self
        }
        
        if let completeVC = segue.destination as? CompleteToDoViewController {
            
            if let toDo = sender as? ToDoCoreData {
                completeVC.selectedToDo = toDo
                completeVC.previousVC = self
            }
        }
        
    }
}
