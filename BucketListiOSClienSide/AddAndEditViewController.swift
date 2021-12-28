//
//  AddAndEditViewController.swift
//  BucketListiOSClienSide
//
//  Created by admin on 26/12/2021.
//

import UIKit



class AddAndEditViewController: UIViewController {

    @IBOutlet weak var taskField: UITextField!
    var selectedTask : TasksClass?
    var delegate : addDelegate?
    var taskEdied: NSDictionary?
    var i: IndexPath?
    
    
    @IBAction func AddPressed(_ sender: UIButton) {
        
        guard let taskObj = taskField.text else { return  }
        
        if selectedTask != nil {
            
            guard let id = selectedTask?.id else {return }
            TaskModel.updateTasks(objective: taskObj, id : id) { data, response, error in
                if data != nil {
                    self.delegate?.relodeTasks()
                    DispatchQueue.main.async {

                        self.navigationController?.popViewController(animated: true)
                    }
                    
                }
            }
        }
        else {
            TaskModel.addTasks(objective: taskObj, completionHandler:{ data, response, error in
                if data != nil
                {do {
                    let  _ = try  JSONDecoder().decode(TasksClass.self, from: data!)
                    if error != nil {
                        print(error?.localizedDescription)
                    }
                    self.delegate?.relodeTasks()
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }catch{
                    print(error.localizedDescription)
                }}
                else {
                    print ("no response")
                }
            })
        }
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedTask == nil {
        
            taskField.text = ""
        }else{
        taskField.text = selectedTask!.objective
            }
}

}

