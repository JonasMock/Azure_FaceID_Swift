//
//  ViewController.swift
//  FaceID
//
//  Created by Jonas Mock on 30.10.17.
//  Copyright © 2017 Jonas Mock. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
    @IBOutlet weak var start: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // var image = AnalyzeImage()
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        let test = Services(subscriptionKey: "f96086b39cb34c728e8ed9124506d9c9", azureServerLocation: "westcentralus")
        //test.createPersonGroup(personGroup: "group1", groupName: "test", groupUserData: "")
        //test.deletePersonGroup(personGroup: "group1")
        //test.getPersonGroupTrainingStatus(personGroup: "group1")
        //test.getPersonGroup(personGroup: "group1")
         //test.listPerson(personGroup: "group1")
        //test.createPerson(personGroup: "group1", personName: "Jonas", personUserData: "")
        //test.addPersonFace(personGroup: "group1", person: "9a49b5fd-95bb-4220-9601-2ea7e8394596", source: "http://bilder.augsburger-allgemeine.de/img/nationalelf/crop40866931/532721653-ctopTeaser/Lukas-Podolski-steht-am-22.jpg")
  test.detectLocal(sourceUrl: "/Users/jonas/Downloads/pickel-im-gesicht-intro.jpg")
  //test.verify(personGroup: "group1", personId: "9a49b5fd-95bb-4220-9601-2ea7e8394596", persitedFaceId: "59cf4b79-2cd4-4037-b6d4-025d18dfd54d")
        
        
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func test(_ sender: Any) {
        showDialog()
    }
    
    
    func showDialog(){
        
        
        
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Enter details?", message: "Enter your name and email", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            let name = alertController.textFields?[0].text
            let email = alertController.textFields?[1].text
            
           
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Name"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Email"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }

    
}

