//
//  ViewController.swift
//  FaceID
//
//  Created by Jonas Mock on 30.10.17.
//  Copyright © 2017 Jonas Mock. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // var image = AnalyzeImage()
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        let test = Person(subscriptionKey: "f96086b39cb34c728e8ed9124506d9c9", azureServerLocation: "westcentralus")
        //test.createPersonGroup(personGroup: "group2", groupName: "test", groupUserData: "")
        //test.deletePersonGroup(personGroup: "group1")
        //test.getPersonGroupTrainingStatus(personGroup: "group1")
        //test.getPersonGroup(personGroup: "group1")
        test.listPerson(personGroup: "group1")
        //test.createPerson(personGroup: "group1", personName: "Jonas", personUserData: "")
        
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

