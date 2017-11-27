//
//  PersonGroup.swift
//  FaceID
//
//  Created by Jonas Mock on 30.10.17.
//  Copyright © 2017 Jonas Mock. All rights reserved.
//

import Foundation
import UIKit
import SQLite


class Initialize {
    
    init(subscriptionKey key: String, azureServerLocation server: String){
        self.key = key
        self.server = server
    }
    var key = ""
    var server = ""
    var database: Connection!
  
    func dbConnection(){
        
        do {
            
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        }catch {
            print(error)
        }
    }
   
    func createTable(){
        
        
        
        
        
        
        
        
        
        
        
    }

    
    
    
    
    
    
}
