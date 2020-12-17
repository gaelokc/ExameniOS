//
//  NetworkManager.swift
//  GoRestTest
//
//  Created by Rodrigo Hernández Gómez on 17/12/2020.
//  Copyright © 2020 Rodrigo Hernández Gómez. All rights reserved.
//

import Foundation

class Network {
    
    static var shared: Network = Network()
    
    class Post: Codable {
        
        let total: Int
        let pages: Int
        let page: Int
        let limit : Int
        
        init(pages: Int, page: Int, total: Int, limit: Int) {
            self.pages = pages
            self.page = page
            self.total = total
            self.limit = limit
            
        }
    }
    
}


protocol GoRestAPI {
    
    func getUsers()
    
    func postUser()
    
    func patchUser()
    
    func putUser()
    
    func deleteUser()
    
}


extension Network: GoRestAPI {
    
    
    func newPost(){
        
        let headers = ["content-type": "application/json; charset=UTF-8"]

        let newPost = Post(pages: 0, page: 1, total: 0, limit: 20)
        
        let encoder = JSONEncoder.init()
        
        var postData: Data!
        
        do {
            _ = try! encoder.encode(newPost)
            postData = try! Data(encoder.encode(newPost))
        }catch{
            print(error)
        }

        let request = NSMutableURLRequest(url: NSURL(string: "https://gorest.co.in/public-api/users/123/posts?access-token=36d7b3000c6a6060d541178a1b0df81c7e3a2fbb7b80dd506bfd12f4dd8392fb")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error!)
          } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse!)
          }
        })

        dataTask.resume()
    }
    
    
    static let ACCESS_TOKEN = "36d7b3000c6a6060d541178a1b0df81c7e3a2fbb7b80dd506bfd12f4dd8392fb"
    
    //TODO
    func getUsers() {
        var urlRequest = URLRequest(url: URL(string: "https://gorest.co.in/public-api/users/123/posts?access-token=36d7b3000c6a6060d541178a1b0df81c7e3a2fbb7b80dd506bfd12f4dd8392fb")!)
        
        urlRequest.httpMethod = "GET"
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept-Language")
        
        URLSession.shared.dataTask(with: URL(string: "https://gorest.co.in/public-api/users/123/posts?access-token=36d7b3000c6a6060d541178a1b0df81c7e3a2fbb7b80dd506bfd12f4dd8392fb")!){
            data,response,error in
        }.resume()
    }
    
    //TODO
    func postUser() {
        var urlRequest = URLRequest(url: URL(string: "https://gorest.co.in/public-api/users/123/posts?access-token=36d7b3000c6a6060d541178a1b0df81c7e3a2fbb7b80dd506bfd12f4dd8392fb")!)
        
        urlRequest.httpMethod = "POST"
        
        let _: [String: Any] = [
            "total": 0,
            "pages": 0,
            "page": 1,
            "limit": 20
        ]
        //urlRequest.httpBody = parameters.percentEncoded()
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept-Language")
        
        URLSession.shared.dataTask(with: URL(string: "https://gorest.co.in/public-api/users/123/posts?access-token=36d7b3000c6a6060d541178a1b0df81c7e3a2fbb7b80dd506bfd12f4dd8392fb")!){
            data,response,error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
            error == nil else {
                print ("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            
        }.resume()
    }
    
    //TODO
    func patchUser() {
        var urlRequest = URLRequest(url: URL(string: "https://gorest.co.in/public-api/users/123/posts?access-token=36d7b3000c6a6060d541178a1b0df81c7e3a2fbb7b80dd506bfd12f4dd8392fb")!)
        
         urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
         
         urlRequest.httpMethod = "PATCH"
        
        do{
            let json: [String: Any] = ["status": "test"]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            urlRequest.httpBody = jsonData
            print("jsonData: ", String(data: urlRequest.httpBody!, encoding: .utf8) ?? "no body data")
        }catch {
            print("ERROR")
        }
        
        URLSession.shared.dataTask(with: URL(string: "https://gorest.co.in/public-api/users/123/posts?access-token=36d7b3000c6a6060d541178a1b0df81c7e3a2fbb7b80dd506bfd12f4dd8392fb")!){
        data,response,error in
            
        if error != nil {
            print("error=\(String(describing: error))")
            return
        }

        let responseString = NSString(data: data!, encoding:String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString))")
        return
            
        }.resume()
    }
    
    //TODO
    func putUser() {
        var urlRequest = URLRequest(url: URL(string: "https://gorest.co.in/public-api/users/123/posts?access-token=36d7b3000c6a6060d541178a1b0df81c7e3a2fbb7b80dd506bfd12f4dd8392fb")!)
        
         urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
         
         urlRequest.httpMethod = "PUT"

         _ = URLSession(configuration:URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
         let data = "username=self@gmail.com&password=password".data(using: String.Encoding.utf8)
         urlRequest.httpBody = data
         
         URLSession.shared.dataTask(with: URL(string: "https://gorest.co.in/public-api/users/123/posts?access-token=36d7b3000c6a6060d541178a1b0df81c7e3a2fbb7b80dd506bfd12f4dd8392fb")!){
             data,response,error in
             
             if error != nil {
                 
             } else {
                 let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                 print("Parsed JSON: '\(String(describing: jsonStr))'")
             }
         }.resume()
    }
    
    //TODO
    func deleteUser() {
        var urlRequest = URLRequest(url: URL(string: "https://gorest.co.in/public-api/users/123/posts?access-token=36d7b3000c6a6060d541178a1b0df81c7e3a2fbb7b80dd506bfd12f4dd8392fb")!)
        
         urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
         
         urlRequest.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        guard error == nil else {
            print("Error: error calling DELETE")
            print(error!)
            return
        }
            guard data != nil else {
            print("Error: Did not receive data")
            return
        }
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
        do {
            guard let jsonObject = try JSONSerialization.jsonObject(with: (data ?? data)!) as? [String: Any] else {
                print("Error: Cannot convert data to JSON")
                return
            }
            guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                print("Error: Cannot convert JSON object to Pretty JSON data")
                return
            }
            guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                print("Error: Could print JSON in String")
                return
            }
            
            print(prettyPrintedJson)
        } catch {
            print("Error: Trying to convert JSON data to string")
            return
        }
        }.resume()
    }
    
}
