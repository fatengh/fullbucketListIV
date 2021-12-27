//
//  TableViewController.swift
//  BucketListiOSClienSide
//
//  Created by admin on 26/12/2021.
//

import UIKit

class TableViewController: UITableViewController {
var tasks = [NSDictionary]()
    var i : IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()

        TaskModel.getAllTasks() {
                 data, response, error in
                 do {
                     if data != nil {
                     let tasksDic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray
                            for task in tasksDic!{
                         self.tasks.append(task as! NSDictionary)
                     }
                         DispatchQueue.main.async {
                             self.tableView.reloadData()
                         }
                     }
                 } catch {
                     print("Something went wrong")
                 }
             }
             super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let v = segue.destination as? AddAndEditViewController
        v?.delegate = self
        
        if let taskEdited  = sender as? NSDictionary{
            v!.i = self.i
            v?.taskEdied = taskEdited
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.i = indexPath
        performSegue(withIdentifier: "AddSegue", sender: tasks[i!.row])
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]["objective"] as? String
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let i = tasks[indexPath.row].value(forKey: "id")
        TaskModel.delTask(i: i) { data, response, error in
            JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            
        }
        tasks.remove(at: indexPath.row)
        tableView.reloadData()
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let c = segue.destination as! AddAndEditViewController
//        c.delegate = self
//    }
}
