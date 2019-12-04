//
//  ChooseViewController.swift
//  Cavisearch
//
//  Created by Geovani Oneal on 11/11/19.
//  Copyright © 2019 Geovani Oneal. All rights reserved.
//

import UIKit

class ChooseViewController: UIViewController {

    
    
    @IBOutlet weak var frontCheck: UIButton!
    
    @IBOutlet weak var leftCheck: UIButton!
    
    @IBOutlet weak var rightCheck: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        frontCheck.layer.cornerRadius = 25.0
        leftCheck.layer.cornerRadius = 25.0
        rightCheck.layer.cornerRadius = 25.0
   

    }
    
    
    //Methods for Left, Front, Right Buttons
    
    @IBAction func leftCheck(_ sender: Any) {
        
         let ViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.Viewcontroller4) as? ViewController4
                                
                                view.window?.rootViewController = ViewController
                                view.window?.makeKeyAndVisible()
    }
    
    @IBAction func frontCheck(_ sender: Any) {
        
         let ViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.ViewController) as? ViewController
                         
                         view.window?.rootViewController = ViewController
                         view.window?.makeKeyAndVisible()
    }
    
    @IBAction func rightCheck(_ sender: Any) {
        
         let ViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.ViewController3) as? ViewController3
                         
                         view.window?.rootViewController = ViewController
                         view.window?.makeKeyAndVisible()
    }
    


}
