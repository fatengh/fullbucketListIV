//
//  TableViewController.swift
//  BucketListiOSClienSide
//
//  Created by admin on 26/12/2021.
//

import UIKit

class TableViewController: UITableViewController {
var tasks = [NSDictionary]()
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]["objective"] as? String
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let c = segue.destination as! AddAndEditViewController
        c.delegate = self
    }
}
