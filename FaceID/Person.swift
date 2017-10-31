//
//  Person.swift
//  FaceID
//
//  Created by Jonas Mock on 31.10.17.
//  Copyright © 2017 Jonas Mock. All rights reserved.
//

import Foundation

class Person:PersonGroup{
    
    
    func addPersonFace(personGroup groupId:String, person personId:String, source url:String){
        
        
        let parameters = ["url": url] as [String : Any]
        
        //create the url with URL
        let url = URL(string: "https://\(super.server).api.cognitive.microsoft.com/face/v1.0/persongroups/\(groupId)/persons/\(personId)/persistedFaces")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(super.key, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        
    }
    
    func createPerson(personGroup id:String, personName name:String, personUserData userData:String){
        
        
        let parameters = ["name": name, "userData": userData] as [String : Any]
        
        //create the url with URL
        let url = URL(string: "https://\(super.server).api.cognitive.microsoft.com/face/v1.0/persongroups/\(id)/persons/")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(super.key, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        
    }
    
    
    
    
    
}
