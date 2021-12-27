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
    
    @IBAction func AddPressed(_ sender: UIButton) {
        let newString = taskField.text!
        TaskModel.addTasks(objective: newString) { data, response, error in
            
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
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


}
