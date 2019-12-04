//
//  HomeViewController.swift
//  Cavisearch
//
//  Created by Geovani Oneal on 10/14/19.
//  Copyright © 2019 Geovani Oneal. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searching: UIButton!
    
    
    @IBOutlet weak var magImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        searching.layer.borderColor = UIColor.black.cgColor
        searching.layer.shadowColor = UIColor.black.cgColor
    
   
        searching.layer.cornerRadius = 25.0
         
        
        //Animation for the maginifying glass
        magImage.center.x = self.view.frame.width + 30
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: [], animations: ({
            self.magImage.center.x = self.view.frame.width / 2
        }), completion: nil)
        
    }
    
  //search button that transitions to the choose screen
    @IBAction func searching(_ sender: UIButton) {
        
        transitionToHome()
    }
    
    
     func transitionToHome() {
           
           let ViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.ChooseController) as? ChooseViewController
           
           view.window?.rootViewController = ViewController
           view.window?.makeKeyAndVisible()
           
       }
    
  
}


