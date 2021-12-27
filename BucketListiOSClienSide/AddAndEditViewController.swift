//
//  AddAndEditViewController.swift
//  BucketListiOSClienSide
//
//  Created by admin on 26/12/2021.
//

import UIKit

class AddAndEditViewController: UIViewController {

    @IBOutlet weak var taskField: UITextField!
    
    var delegate: TableViewController?
    
    var taskEdied: NSDictionary?
    var i: IndexPath?
    
    
    @IBAction func AddPressed(_ sender: UIButton) {
        let newString = taskField.text!
        
        
        
        if taskEdied != nil {
            
            
            taskEdied?.setValue(newString, forKey: "objective")
            
            TaskModel.updateTask(task: taskEdied!, completionHandler: { data, response, error in
            if data != nil {
                
                
                do{
                    let w = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    DispatchQueue.main.async {
                        
                        self.delegate?.tasks[self.i!.row] = w
                        print(w)
                        self.delegate?.tableView.reloadData()
                        let _ =  self.navigationController?.viewControllers.popLast()
                    }
                } catch {
                   
                    
                    }
                
            
            }
                
            })
           
            
            
            
        } else {
        TaskModel.addTasks(objective: newString, completionHandler:  { data, response, error in
            
            if data != nil {
                do{
                    let task = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    DispatchQueue.main.async {
                        self.delegate?.tasks.append(task)
                        self.delegate?.tableView.reloadData()
                        let _ =  self.navigationController?.viewControllers.popLast()
                    }
                }catch{
                    print(error)
                }
            }else{
                print("no response")
            }
         })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        taskField.text = taskEdied?.value(forKey: "objective") as? String
    }
}
