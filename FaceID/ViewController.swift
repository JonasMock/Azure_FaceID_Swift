//
//  ViewController.swift
//  FaceID
//
//  Created by Jonas Mock on 30.10.17.
//  Copyright © 2017 Jonas Mock. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var person: UILabel!
    @IBOutlet weak var demoBtn: UIButton!
    @IBOutlet weak var verifiedValue: UILabel!
    @IBOutlet weak var confiValue: UILabel!
    @IBOutlet weak var trainedValue: UILabel!
    @IBOutlet weak var personValue: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var trainBtn: UIButton!
    
    let subscriptionKey = "f96086b39cb34c728e8ed9124506d9c9"
    let apiServer = "westcentralus"
    var check = 0
    static var confidence = ""
    static var identical = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // var image = AnalyzeImage()
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        //let test = Services(subscriptionKey: "f96086b39cb34c728e8ed9124506d9c9", azureServerLocation: "westcentralus")
        //test.createPersonGroup(personGroup: "group1", groupName: "test", groupUserData: "")
        //test.deletePersonGroup(personGroup: "group1")
        //test.getPersonGroupTrainingStatus(personGroup: "group1")
        //test.getPersonGroup(personGroup: "group1")
        //test.listPerson(personGroup: "group1")
        //test.createPerson(personGroup: "group1", personName: "Jonas", personUserData: "")
        //test.addPersonFace(personGroup: "group1", person: "9a49b5fd-95bb-4220-9601-2ea7e8394596", source: "http://bilder.augsburger-allgemeine.de/img/nationalelf/crop40866931/532721653-ctopTeaser/Lukas-Podolski-steht-am-22.jpg")
        //test.detectLocal(sourceUrl: "/Users/jonas/Downloads/pickel-im-gesicht-intro.jpg")
        //test.verify(personGroup: "group1", personId: "9a49b5fd-95bb-4220-9601-2ea7e8394596", persitedFaceId: "59cf4b79-2cd4-4037-b6d4-025d18dfd54d")
        //test.getPersonGroupTrainingStatus(personGroup: "demo")
        trainedValue.text = "false"
        verifyBtn.isEnabled = false
        trainBtn.isEnabled = false
        reset()
        
      
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func demo(_ sender: Any) {
        
        
        let test = Services(subscriptionKey: subscriptionKey, azureServerLocation: apiServer)
        test.createPersonGroup(personGroup: "demo", groupName: "demoGroup", groupUserData: "")
        sleep(2)
        demoBtn.isEnabled = false
        demoBtn.isHidden = true
        
        trainBtn.isEnabled = true
        personValue.text = test.createPerson(personGroup: "demo", personName: "demo", personUserData: "")

   
             self.check = 1
             self.showDialog(titel: "Person created", message: "Add an image")
     
        
        
    }
    
    @IBAction func reset(_ sender: Any) {
        
       reset()
    }
    
    
    @IBAction func train(_ sender: Any) {
        self.check = 1
        self.showDialog(titel: "Person created", message: "- Add an image (3 recommended)\n- Train the person",btnTitle: "Add")
        
    }
    
    
    func reset(){
        let test = Services(subscriptionKey: subscriptionKey, azureServerLocation: apiServer)
        test.deletePersonGroup(personGroup: "demo")
        demoBtn.isEnabled = true
        demoBtn.isHidden = false
        personValue.text = ""
        trainedValue.text = "false"
        verifyBtn.isEnabled = false
        trainBtn.isEnabled = false
        check = 0
        confiValue.text = ""
        verifiedValue.text = ""
        imageView.image = nil
        
    }
    
    
    
 
    
    
    
    
    
    
    
    
    
    
    
    func showDialog(titel: String, message: String, btnTitle:String){
        
        
        
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: titel, message: message, preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            self.picImage()
        }
        let trainAction = UIAlertAction(title: "Train", style: .default) { (_) in
            let test = Services(subscriptionKey: self.subscriptionKey, azureServerLocation: self.apiServer)
            test.trainPersonGroup(personGroup: "demo")
            self.trainedValue.text = "true"
            self.verifyBtn.isEnabled = true
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(trainAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    func showDialog(titel: String, message: String){
        
        
        
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: titel, message: message, preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            
            
            
            
            
            self.picImage()
            
           
            
            
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func verify(_ sender: Any) {
        print("pressed")
      self.check = 2
      picImage()
        
        
        
        
    }
    
    
    
    func picImage (){
        
        let sourceAlert = UIAlertController()
        
        sourceAlert.addAction(UIAlertAction(title: "Take Photo", style: .default) { action in
            
            //Check camera permissions
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                if response {
                    //If camera access is enabled, start camera view
                    let pickerController = UIImagePickerController()
                    pickerController.delegate = self
                    pickerController.sourceType = .camera
                    self.present(pickerController, animated: true)
                } else {
                    
                    
                    //Alert if camere access is denied
                    let cameraAlert = UIAlertController(title: "Camera access denied!", message: "Please enable camera access.", preferredStyle: UIAlertControllerStyle.alert)
                    cameraAlert.addAction(UIAlertAction(title: "Go to settings", style: .default) { action in
                        
                        //Open Predict3D settings
                        let settingsUrl = NSURL(string:UIApplicationOpenSettingsURLString)! as URL
                        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
                        
                        
                    })
                    
                    cameraAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { action in
                        
                    })
                    
                    self.present(cameraAlert, animated: true, completion: nil)
                    
                }
            }
            
        })
        
        sourceAlert.addAction(UIAlertAction(title: "Photo Library", style: .default) { action in
            
            
            
            
            
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .savedPhotosAlbum
            self.present(pickerController, animated: true)
            
            
        })
        
        sourceAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        })
        
        
        present(sourceAlert, animated: true)
       
       
        
    }
    
    
    
   
    
    
    
    
}

// MARK: - UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("couldn't load image from Photos")
        }
        
       let mirroredImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .leftMirrored)
        
       
        let imagedata = UIImageJPEGRepresentation(image, 0.5)
        let test = Services(subscriptionKey: subscriptionKey, azureServerLocation: apiServer)
        
        
        print(self.check)
        switch self.check {
        case 1:
            test.addPersonFace(personGroup: "demo", person: test.getPersonId(), source: imagedata!); break
        case 2:
            var verifyy = ""
            imageView.image = mirroredImage
            
            if (imageView != nil){
                verifyy = test.verify(personGroup: "demo", personId: test.getPersonId(), persitedFaceId: test.detectLocal(source: imagedata!))
                
                print("caseDetect")
                
                var prime = true
                while(prime){
                    
                    if (verifyy == "true"){
                        if (Int(test.getIdentical()) == 1){
                            verifiedValue.text = "true"
                        }else{
                            verifiedValue.text = "false"
                        }
                        var test = Double(test.getconfidence())! * 100
                        confiValue.text = "\(test) %"
                        prime = false
                    }else{
                        print("Wait")
                    }
                    
                }
                
            }
     
            
            
           
            
   
            break
        default:
            print("default")
        }
        
       
        
        
        
    }
}

// MARK: - UINavigationControllerDelegate
extension ViewController: UINavigationControllerDelegate {
}
