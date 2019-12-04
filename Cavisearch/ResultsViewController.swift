//
//  ResultsViewController.swift
//  Cavisearch
//
//  Created by Geovani Oneal on 11/11/19.
//  Copyright © 2019 Geovani Oneal. All rights reserved.
//

import UIKit
import AVKit
import Vision
import CoreML

class ResultsViewController: UIViewController {

    
    @IBOutlet weak var resultsViewConfidence: UILabel?
    
    
    @IBOutlet weak var greetMessage: UILabel!
    
    
    @IBOutlet weak var resultsViewIdentifier: UILabel!
    
    
    var resultsViewC: String?
    var greetViewC: String?
    var resultsViewI: String?
    var confidence: Int?
    var Identifier: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsViewConfidence?.text = resultsViewC
        
        resultsViewIdentifier?.text = resultsViewI
        
        
        //If the identifier is == to the No cavities String it will run this statement depending upon the results
                
        if Identifier == "No Cavities" {
                       
             greetViewC = "You're doing great keep up the brushing!"
                                  
             greetMessage?.text = greetViewC
                                 
            print(greetMessage.text!)
                       
        
         }else {
            
            greetViewC = "Did you check with your dentist yet?"
            
            greetMessage?.text = greetViewC
            
            print(greetMessage.text!)
            
            
            
        }
        
    }
    
    // To go back to the check screen
    @IBAction func backButton(_ sender: Any) {
        
         self.dismiss(animated: true, completion: nil)
         
        }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  

}

//extension UIFont {
    
    /**
     Will return the best font conforming to the descriptor which will fit in the provided bounds.
     */
   // static func bestFittingFontSize(for text: String, in bounds: CGRect, fontDescriptor: UIFontDescriptor, additionalAttributes: [NSAttributedString.Key: Any]? = nil) -> CGFloat {
       // let constrainingDimension = min(bounds.width, bounds.height)
      //  let properBounds = CGRect(origin: .zero, size: bounds.size)
      //  var attributes = additionalAttributes ?? [:]
        
       // let infiniteBounds = CGSize(width: CGFloat.infinity, height: CGFloat.infinity)
      //  var bestFontSize: CGFloat = constrainingDimension
        
      //  for fontSize in stride(from: bestFontSize, through: 0, by: -1) {
        //    let newFont = UIFont(descriptor: fontDescriptor, size: fontSize)
        //    attributes[.font] = newFont
            
        //    let currentFrame = text.boundingRect(with: infiniteBounds, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
            
        //    if properBounds.contains(currentFrame) {
            //    bestFontSize = fontSize
            //    break
           // }
       // }
      //  return bestFontSize
   // }
    
   // static func bestFittingFont(for text: String, in bounds: CGRect, fontDescriptor: UIFontDescriptor, additionalAttributes: [NSAttributedString.Key: Any]? = nil) -> UIFont {
     //   let bestSize = bestFittingFontSize(for: text, in: bounds, fontDescriptor: fontDescriptor, additionalAttributes: additionalAttributes)
    //    return UIFont(descriptor: fontDescriptor, size: bestSize)
  //  }
//}


//extension UILabel {
    
    /// Will auto resize the contained text to a font size which fits the frames bounds.
    /// Uses the pre-set font to dynamically determine the proper sizing
   // func fitTextToBounds() {
   //     guard let text = text, let currentFont = font else { return }
    
     //   let bestFittingFont = UIFont.bestFittingFont(for: text, in: bounds, fontDescriptor: currentFont.fontDescriptor, additionalAttributes: basicStringAttributes)
     //   font = bestFittingFont
   // }
    
   // private var basicStringAttributes: [NSAttributedString.Key: Any] {
     //   var attribs = [NSAttributedString.Key: Any]()
        
      //  let paragraphStyle = NSMutableParagraphStyle()
      //  paragraphStyle.alignment = self.textAlignment
      //  paragraphStyle.lineBreakMode = self.lineBreakMode
      //  attribs[.paragraphStyle] = paragraphStyle
        
       // return attribs
   // }
//}
