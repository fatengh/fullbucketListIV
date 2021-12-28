//
//  TableViewController.swift
//  BucketListiOSClienSide
//
//  Created by admin on 26/12/2021.
//

import UIKit

class TableViewController: UITableViewController, addDelegate {

    
 
    func relodeTasks() {
        fecthData()
    }
 
    var  tasks = [TasksClass]()
    var i : IndexPath?
    var names = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fecthData()
    }
    
    
    func fecthData()
    {
        TaskModel.getAllTasks() {
            data, response, error in
            do {
                self.tasks = try  JSONDecoder().decode([TasksClass].self, from: data!)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Something went wrong")
            }
        }
    }

    // ADD BUTTON
    @IBAction func nextPage(_ sender: UIBarButtonItem) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddAndEditViewController") as! AddAndEditViewController
        vc.delegate = self
        vc.selectedTask = nil
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        cell.textLabel?.text = String("\(tasks[indexPath.row].objective)")
        return cell
        
    }
 // UPDATE
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.i = indexPath
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddAndEditViewController") as! AddAndEditViewController
        vc.delegate = self
        vc.selectedTask = tasks[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    // DELETE
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if  let id = tasks[indexPath.row].id
        {
            print("id= \(id)")
            TaskModel.deleteTask(id: id) { data, response, error in
                if error != nil {
                    print(error)
                }
                if data != nil {
                    self.fecthData()}
            }
        }
}
}
