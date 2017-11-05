//
//  Services.swift
//  FaceID
//
//  Created by Jonas Mock on 01.11.17.
//  Copyright © 2017 Jonas Mock. All rights reserved.
//

import Foundation
import UIKit
class Services: Person {
    
    
    var faceId: String = ""
    
    
    
  
    
    
    func verify(personGroup id:String, personId pId:String, persitedFaceId fId:String){
        
        let parameters = ["faceId": fId, "personId": pId, "personGroupId": id] as [String : Any]
        
        //create the url with URL
        let url = URL(string: "https://\(super.server).api.cognitive.microsoft.com/face/v1.0/verify")! //change the url
        
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
                let json = try decoder.decode(Verify.self, from: data)
                print(json.getIsIdentical())
                
                // Create a FileManager instance
                
                let fileManager = FileManager.default
                
                // Get current directory path
                
                let path = fileManager.currentDirectoryPath
                print(path)
                
                let file = "confidence.txt" //this is the file. we will write to and read from it
                
                let text = String(json.getConfidence()) //just a text
                
                if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    
                    let fileURL = dir.appendingPathComponent(file)
                    
                    //writing
                    do {
                        try text.write(to: fileURL, atomically: false, encoding: .utf8)
                    }
                    catch {/* error handling here */}
                    
                    
                }
                
                let file2 = "identical.txt" //this is the file. we will write to and read from it
                
                let text2 = String(json.getIsIdentical()) //just a text
                
                if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    
                    let fileURL = dir.appendingPathComponent(file2)
                    
                    //writing
                    do {
                        try text2.write(to: fileURL, atomically: false, encoding: .utf8)
                    }
                    catch {/* error handling here */}
                    
                    
                }
                
                
                
                
                
            } catch let error {
                print(error)}
        })
        task.resume()
        
        if (Int(getIdentical()) == 1){
            ViewController.identical = "true"
        }else{
            
        }
        ViewController.confidence = getconfidence()
        
    }
    
    func getconfidence() -> String {
        
        var confidence = ""
        let fileManager = FileManager.default
        
        // Get current directory path
        
        let path = fileManager.currentDirectoryPath
        
        let file = "confidence.txt" //this is the file. we will write to and read from it
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(file)
            
            
            //reading
            do {
                confidence = try String(contentsOf: fileURL, encoding: .utf8)
            }
            catch {/* error handling here */}
        }
        
        return confidence
        
    }
    
    func getIdentical() -> String {
        
        var confidence = ""
        let fileManager = FileManager.default
        
        // Get current directory path
        
        let path = fileManager.currentDirectoryPath
        
        let file = "identical.txt" //this is the file. we will write to and read from it
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(file)
            
            
            //reading
            do {
                confidence = try String(contentsOf: fileURL, encoding: .utf8)
            }
            catch {/* error handling here */}
        }
        
        return confidence
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func detectUrl(sourceUrl url:String){
        
        let parameters = ["url": url] as [String : Any]
        
        //create the url with URL
        let url = URL(string: "https://\(super.server).api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false")! //change the url
        
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
                let json = try decoder.decode([DetectArray].self, from: data)
                print(json)
                
                
            } catch let error {
                print(error)}
        })
        task.resume()
        
    }
    
    func detectLocal(source:Data) -> String{
        
        
        
        //create the url with URL
        let url = URL(string: "https://\(super.server).api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false")! //change the url
        
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
                let json = try decoder.decode([DetectArray].self, from: data)
                print(json[0].getId())
                
                // Create a FileManager instance
                
                let fileManager = FileManager.default
                
                // Get current directory path
                
                let path = fileManager.currentDirectoryPath
                print(path)
                
                let file = "detect.txt" //this is the file. we will write to and read from it
                
                let text = json[0].getId()   //just a text
                
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
        
        let file = "detect.txt" //this is the file. we will write to and read from it
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(file)
            
            
            //reading
            do {
                self.faceId = try String(contentsOf: fileURL, encoding: .utf8)
            }
            catch {/* error handling here */}
        }
        
        print(self.faceId + "from file")
        
        
        
        return self.faceId
        
        
        
        
    }
    
    
    

        
        
        
    
    
    
    
    
    
    
    
    
    
    
}
