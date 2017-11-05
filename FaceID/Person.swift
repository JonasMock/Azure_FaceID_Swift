//
//  Person.swift
//  FaceID
//
//  Created by Jonas Mock on 31.10.17.
//  Copyright © 2017 Jonas Mock. All rights reserved.
//

import Foundation

class Person:PersonGroup{
    static var personId = "123"
    
    
    func addPersonFace(personGroup groupId:String, person personId:String, source:Data){
        
        
        
        
        //create the url with URL
        let url = URL(string: "https://\(super.server).api.cognitive.microsoft.com/face/v1.0/persongroups/\(groupId)/persons/\(personId)/persistedFaces")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = source
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
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
    
    func createPerson(personGroup id:String, personName name:String, personUserData userData:String) -> String{
        
        
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
                //create json decoder and decode data
                let decoder = JSONDecoder()
              let json = try decoder.decode(Persons.self, from: data)
              print(json.getId())
              
                // Create a FileManager instance
                
                let fileManager = FileManager.default
                
                // Get current directory path
                
                let path = fileManager.currentDirectoryPath
                print(path)
                
                let file = "file.txt" //this is the file. we will write to and read from it
                
                let text = json.getId()  //just a text
                
                if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    
                    let fileURL = dir.appendingPathComponent(file)
                    
                    //writing
                    do {
                        try text.write(to: fileURL, atomically: false, encoding: .utf8)
                    }
                    catch {/* error handling here */}
                    
            
                }
                
                
                
              
                
            } catch let error {
                print(error)}
        })
        
        task.resume()
      
       
        sleep(2)
        // Create a FileManager instance
        
        let fileManager = FileManager.default
        
        // Get current directory path
        
        let path = fileManager.currentDirectoryPath
        
        let file = "file.txt" //this is the file. we will write to and read from it
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(file)
            
            
            //reading
            do {
                Person.personId = try String(contentsOf: fileURL, encoding: .utf8)
            }
            catch {/* error handling here */}
        }
       
        print(Person.personId + "after parse")
        return Person.personId
        
        
        
    }
    
    func getPersonId() -> String {
        
        let fileManager = FileManager.default
        
        // Get current directory path
        
        let path = fileManager.currentDirectoryPath
        
        let file = "file.txt" //this is the file. we will write to and read from it
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(file)
            
            
            //reading
            do {
                Person.personId = try String(contentsOf: fileURL, encoding: .utf8)
            }
            catch {/* error handling here */}
        }
        
        print(Person.personId + "after verifybtn")
        return Person.personId
        
    }
    
    
    func deletePerson(personGroup id:String, personId pId:String){
        
        
        //create the url with URL
        let url = URL(string: "https://\(super.server).api.cognitive.microsoft.com/face/v1.0/persongroups/\(id)/persons/\(pId)")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE" //set http method as POST
        
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
    
    
    func deletePersonFace(personGroup id:String, personId pId:String, persitedFaceId fId:String){
        
        
        //create the url with URL
        let url = URL(string: "https://\(super.server).api.cognitive.microsoft.com/face/v1.0/persongroups/\(id)/persons/\(pId)/persistedFaces/\(fId)")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE" //set http method as POST
        
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
    
    
    func getPerson(personGroup id:String, personId pId:String){
        
        
        //create the url with URL
        let url = URL(string: "https://\(super.server).api.cognitive.microsoft.com/face/v1.0/persongroups/\(id)/persons/\(pId)")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "GET" //set http method as POST
        
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
    
    
    func getPersonFace(personGroup id:String, personId pId:String, persitedFaceId fId:String){
        
        
        //create the url with URL
        let url = URL(string: "https://\(super.server).api.cognitive.microsoft.com/face/v1.0/persongroups/\(id)/persons/\(pId)")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "GET" //set http method as POST
        
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
    
    
    func listPerson(personGroup id:String){
        
        
        //create the url with URL
        let url = URL(string: "https://\(super.server).api.cognitive.microsoft.com/face/v1.0/persongroups/\(id)/persons/")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "GET" //set http method as POST
        
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
                //create json decoder and decode data
                let decoder = JSONDecoder()
                let json = try decoder.decode([PersonArray].self, from: data)
                print(json)
                
                
            } catch let error {
                print(error)}
        })
        task.resume()
        
    }
    
    func updatePerson(personGroup id:String, personName name:String, personUserData userData:String){
        
        
        let parameters = ["name": name, "userData": userData] as [String : Any]
        
        //create the url with URL
        let url = URL(string: "https://\(super.server).api.cognitive.microsoft.com/face/v1.0/persongroups/\(id)/persons/")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH" //set http method as POST
        
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
