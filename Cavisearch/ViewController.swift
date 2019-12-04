//
//  ViewController.swift
//  Cavisearch
//
//  Created by Geovani Oneal on 10/6/19.
//  Copyright © 2019 Geovani Oneal. All rights reserved.
//

import UIKit
import Vision
import CoreML
import AVKit




class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var takePhoto = false
    

    
    @IBOutlet weak var picButton: UIButton!
    
    
    
    @IBOutlet weak var resultsViewing: UILabel!
    
    //Caputure session
           let captureSession = AVCaptureSession()
    //Front default position for the camera
           let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
        for: .video, position: .front)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Capture notification Observer to monitor any interruptions phone calls etc...
        
        
        picButton.layer.cornerRadius = 25.0
        
        
      //will start up the camera
        guard let input = try? AVCaptureDeviceInput(device: captureDevice!) else {return}
        
        captureSession.addInput(input)
        
        //Starts the camera session 
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.session = captureSession
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue (label:"PhotoanddataQueue"))
        
        
        let photoOutput = AVCapturePhotoOutput()

        guard captureSession.canAddOutput(photoOutput) else { return }
        captureSession.sessionPreset = .photo
        captureSession.addOutput(photoOutput)
        
        captureSession.addOutput(dataOutput)
        
          _ = AVCapturePhotoSettings()
        
        
        
        
        return print(captureSession)
        
    }
    
    
    //Capture photo button
    @IBAction func takePic(_ sender: Any) {
        
        takePhoto = true
        
        
        
    }
    
    //CaptureOutput for the session to transmit the data to the  resultsVIewcontroller for final results
    
    func captureOutput (_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection )  {
            print("Camera captured results:", Date())
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
           
           
           guard let model = try? VNCoreMLModel (for: CavitySearch().model) else { return }
           
          let request = VNCoreMLRequest(model: model)
           { (finishedReq, error) in
               
               
            print(finishedReq.results!)
            
            guard let results = finishedReq.results as?
                [VNClassificationObservation] else { return }
            
            guard let firstObservation = results.first else { return }
            
            let finalValue = Int(firstObservation.confidence * 100)
            
            let finalIdentifier = String(firstObservation.identifier)
            
            //If the identifier is == to the No cavities it will run this statement depending upon
            
            if finalIdentifier == "No Cavities" {
                
                
                
            }
           
              if self.takePhoto {
                  self.takePhoto = false
                      
                    
                      DispatchQueue.main.async {
                        
                        
                      let photoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
                            "ResultsVC") as! ResultsViewController
                        
                        
                        //To display the results to the user 
                        photoVC.resultsViewC = "You Have \(firstObservation.identifier)"
                        
                        photoVC.resultsViewI = "\(finalValue)% "
                      
                        photoVC.confidence = finalValue
                        
                        photoVC.Identifier = finalIdentifier
                        
                       // let homeJome = self.transitionToHome1()
                        
                        
                       self.present(photoVC, animated: true, completion:  {
                            //self.stopCaptureSession()
                          
                            
                         })
                          
                      }
                 // }
                                  
                                  
                   
               }
            
            //Obtain the results for the user to see
            //DispatchQueue.main.async {
                //self.resultsViewing.text! = "\(firstObservation.identifier)"
                  //Where resultsviewing was printed
                
            //}
            
            //Decrease the results view by a 2 seconds so the user can see
            //DispatchQueue.main.asyncAfter (deadline: .now() + 2.0) {
                
                //self.resultsViewing.text! = "\(firstObservation.identifier)"
                
               // print(self.resultsViewing.text!)
                
           // }
           
            
            //Possible print (firstObservation.identifier alternatively here)
        }
            
           
        
    
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
       
        }
    
    
    
     
    
    func stopCaptureSession () {
        self.captureSession.stopRunning()
        
        if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                self.captureSession.removeInput(input)
            }
        }
        
    }
    
    
    
    @IBAction func backButton(_ sender: Any) {
        
        transitionToHome()
       
       
    }
    
    
    func transitionToHome() {
        
        let ViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.ChooseController) as? ChooseViewController
        
        view.window?.rootViewController = ViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    
    func transitionToHome1() {
        
        let ViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.ResultsController) as? ResultsViewController
        
        view.window?.rootViewController = ViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    
}
    

    


