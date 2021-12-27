//
//  TaskModel.swift
//  BucketListiOSClienSide
//
//  Created by admin on 26/12/2021.
//

import Foundation
class TaskModel {
    // GET
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        // Specify the url that we will be sending the GET Request
        let url = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/")
        // Create a URLSession to handle the request
        let session = URLSession.shared
        // Create a " task" which will request some data from a URL and then run the completion handler that we are passing into the getAllTasks function itself
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        // Actually "execute" the task. This is the line that actually makes the request that we set up above
        task.resume()
        
    }
    
    static func addTasks(objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
     // Create the url to request
            if let url = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/") {
                // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
                var req = URLRequest(url: url)
                // Set the method to POST
                req.httpMethod = "POST"
                // Create some bodyData and attach it to the HTTPBody
                let bodyData = "objective=\(objective)"
                req.httpBody = bodyData.data(using: .utf8)
                // Create the session
                let session = URLSession.shared
                let task = session.dataTask(with: req as URLRequest, completionHandler: completionHandler)
                task.resume()
            }
    }
}
