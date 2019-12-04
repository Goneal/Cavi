//
//  ViewController3.swift
//  Cavisearch
//
//  Created by Geovani Oneal on 11/14/19.
//  Copyright © 2019 Geovani Oneal. All rights reserved.
//

import UIKit
import Vision
import CoreML
import AVKit

//This mimics the first ViewController as all the controls do the same things but just handles different views

class ViewController3: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate{

    //Properties to be accessed by all functions
           let captureSession = AVCaptureSession()
    //Front default position for the camera
           let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
        for: .video, position: .front)
    
    var takePhoto = false
    
    @IBOutlet weak var picButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        picButton.layer.cornerRadius = 25.0
        
        
         //will start up the camera
               guard let input = try? AVCaptureDeviceInput(device: captureDevice!) else {return}
               
               captureSession.addInput(input)
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
    
    
    @IBAction func takePic(_ sender: Any) {
        
        takePhoto = true
    }
    
    
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
               
              
                 if self.takePhoto {
                     self.takePhoto = false
                         
                       
                         DispatchQueue.main.async {
                           
                           
                         let photoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
                               "ResultsVC") as! ResultsViewController
                           
                         photoVC.resultsViewC = "You Have \(firstObservation.identifier)"
                           
                           photoVC.resultsViewI = "\(finalValue)% "
                         
                           photoVC.confidence = finalValue
                           
                         
                         
       
                           self.present(photoVC, animated: true, completion:  {
                               self.stopCaptureSession()
                             
                               
                            })
                             
                         }
                    // }
                                     
                                     
                      
                  }
               
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
    

}
