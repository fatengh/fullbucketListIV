//
//  TaskModel.swift
//  BucketListiOSClienSide
//
//  Created by admin on 26/12/2021.
//

import Foundation


protocol addDelegate {
    func relodeTasks()
}

class TaskModel {
  
        static func getTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
           let url = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/")
            let session = URLSession.shared
            let task = session.dataTask(with: url!, completionHandler: completionHandler)
            task.resume()
        }
        
        
        
        static func addTasks(objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
                if let url = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/") {
                    var req = URLRequest(url: url)
                    req.httpMethod = "POST"
                    let bodyData = "objective=\(objective)"
                    req.httpBody = bodyData.data(using: .utf8)
                    let session = URLSession.shared
                    let task = session.dataTask(with: req as URLRequest, completionHandler: completionHandler)
                    task.resume()
                }
        }
        
    
    

        static func updateTasks(objective: String,id: Int, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void){
            let url = URL(string:"https://saudibucketlistapi.herokuapp.com/tasks/\(id)/")!
            var req = URLRequest(url: url)
            req.httpMethod = "PUT"
            do{
                let objReq = TaskRequest.init(objective: objective)
                let BodyData = try JSONEncoder().encode(objReq)
                req.httpBody = BodyData
                req.addValue("application/json", forHTTPHeaderField: "Content-Type")
                print(req.httpBody)
                let task = URLSession.shared.dataTask(with: req) { data, response, error in
                    if error != nil {
                        completionHandler(nil, nil, error)
                    } else {
                        completionHandler(data, response, error)
                    }
                }
                task.resume()
                
            }catch{
                print(error.localizedDescription)
            }
            
        }
        static func deleteTasks(id : Int, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void){
            let url = URL(string:"https://saudibucketlistapi.herokuapp.com/tasks/\(id)/")!
            var req = URLRequest(url: url)
            req.httpMethod = "DELETE"
           let BodyData = "id=\(id)"
            req.httpBody = BodyData.data(using: String.Encoding.utf8)
            let task = URLSession.shared.dataTask(with: req) { data, response, error in
                if error != nil {
                    completionHandler(nil, nil, error)
                } else {
                    completionHandler(data, response, error)
                }
            }
            task.resume()
            
       
        }

    }

