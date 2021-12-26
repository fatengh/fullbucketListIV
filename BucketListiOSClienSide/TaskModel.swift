//
//  TaskModel.swift
//  BucketListiOSClienSide
//
//  Created by admin on 26/12/2021.
//

import Foundation
class TaskModel {
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        // Specify the url that we will be sending the GET Request
        let url = URL(string: "https://dojo-recipes.herokuapp.com/test/")
        // Create a URLSession to handle the request
        let session = URLSession.shared
        // Create a " task" which will request some data from a URL and then run the completion handler that we are passing into the getAllTasks function itself
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        // Actually "execute" the task. This is the line that actually makes the request that we set up above
        task.resume()
        
    }
}
