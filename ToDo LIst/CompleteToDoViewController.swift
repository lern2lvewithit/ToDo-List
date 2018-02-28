//
//  CompleteToDoViewController.swift
//  ToDo LIst
//
//  Created by Steven Lerner on 2/27/18.
//  Copyright © 2018 Steven Lerner. All rights reserved.
//

import UIKit

class CompleteToDoViewController: UIViewController {
    
    var previousVC = ToDoTableViewController()
    var selectedToDo = ToDo()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //titleLabel.text = selectedToDo.name
        
        if selectedToDo.important {
            titleLabel.text = "❗️" + selectedToDo.name
        } else {
            titleLabel.text = selectedToDo.name
        }
        
    }
    @IBAction func completeTapped(_ sender: Any) {
        
        var index = 0
        
        for toDo in previousVC.toDos {
            if toDo.name == selectedToDo.name{
                previousVC.toDos.remove(at: index)
                previousVC.tableView.reloadData()
                navigationController?.popViewController(animated: true)
                break
            }
            index += 1
        }
        
    }
    
}
