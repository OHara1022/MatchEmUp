//
//  GameViewController.swift
//  Match Em Up
//
//  Created by Scott O'Hara on 2/6/16.
//  Copyright © 2016 Scott O'Hara. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    //create imageCollectionView for images
    @IBOutlet var cardOutletCollection: [UIImageView]!
    
    //outlet for timer
    @IBOutlet weak var timerOutlet: UILabel!   
    
    //outlet to show and hide button when game is paused
    @IBOutlet weak var resumeButtonOutlet: UIButton!
    
    //action for back button
    @IBAction func backButton(_ sender: AnyObject) {
        
        //dismiss VC
        dismiss(animated: true) {
      
           //call reset game function 
            self.reset()
            
            print("dismissedVC")
        }
    }
    
    //action to pause the game
    @IBAction func pauseButton(_ sender: AnyObject) {
        
        //disable imageViews
        imagesDisabled()
        
        //stop timer
        cardDetail.timer.invalidate()
        
        //show resume button
        resumeButtonOutlet.isHidden = false
        
        //test action
        print("pauseGame")
    }
    
    @IBAction func resumePlay(_ sender: UIButton) {
        
        //enable imageViews
        imagesEnabled()
        
        //start timer
        timer()
        
        //hide resume button
        resumeButtonOutlet.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide resumeButton
        resumeButtonOutlet.isHidden = true
        
        //set timeOutlet text to the timers value
        timerOutlet.text = "Time: \(cardDetail.counter)"
        
        //start timer
        timer()
        
        //enable user interaction with imageViews
        imagesEnabled()
        
        
        //shuffle cards when view loads
        shuffle()
        
        
        //imageCollection loop and add tapGesture
        tapGestureLoop()
        
    }
}
