//
//  CardFunctions.swift
//  Match Em Up
//
//  Created by Scott O'Hara on 2/9/16.
//  Copyright © 2016 Scott O'Hara. All rights reserved.
//

import Foundation
import UIKit

//extension to gameViewController
extension GameViewController {
    
    //enable userInteraction
    func imagesEnabled(){
        
        //loop through image collection
        for i in cardOutletCollection{
            
            //set  user interaction to true
            i.isUserInteractionEnabled = true
        }
    }
    
    //disable userInteraction
    func imagesDisabled(){
        
        //loop through image collection
        for i in cardOutletCollection{
            
            //set user interaction to false
            i.isUserInteractionEnabled = false
        }
    }
    
    //covert seconds to minutes for timer label
    func formatToMin(_ totalSeconds: Int) -> String {
        //get minutes & seconds
        let minutes = totalSeconds / 60;
        let seconds = totalSeconds % 60;
        
        return String(format:"%02d:%02d", minutes, seconds);
    }
    
    //update timer label
    @objc func updateTimer(){
        
        //update counter
        cardDetail.counter += 1
        
        //set timer label to count up from zero
        timerOutlet.text = "Time: \(cardDetail.counter)"
        
        //check if counter is over 60 seconds 
        if cardDetail.counter >= 60{
            
            //dev
            print(formatToMin(cardDetail.counter))
            
            timerOutlet.text = "Time: \(formatToMin(cardDetail.counter))"
        }
    }
    
    //set timer 
    func timer(){
        
        cardDetail.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    //function to hide cards
    func deleteCards(){
        
        //hide imageSelection
        cardDetail.selection1?.isHidden = true
        cardDetail.selection2?.isHidden = true
    }
    
    //shuffle images
    func shuffle(){
        
        if UIDevice.current.model == "iPad"{
            
            //loop through imageCollection
            //             for i in ((0 + 1)...cardDetail.ipadImageArray.count - 1).reversed() -= 1{
            for i in ((0 + 1)...cardDetail.ipadImageArray.count - 1).reversed() {
                
                var j = Int(arc4random_uniform(UInt32(i + 1)))
                
                //if i and j are equal add one to i until they do not match
                while i == j{
                    
                    j = Int(arc4random_uniform(UInt32(i + 1)))
                    
                }
                
                //swap the values of the array
                //               swap(&cardDetail.ipadImageArray[i], &cardDetail.ipadImageArray[j])
                cardDetail.ipadImageArray.swapAt(i, j)
                
            }
            
            //make sure image array shuffles
            print(cardDetail.ipadImageArray)
        }
        
        //loop through imageCollection
        for i in ((0 + 1)...cardDetail.imageCollectionArray.count - 1).reversed() {
            
            var j = Int(arc4random_uniform(UInt32(i + 1)))
            
            //if i and j are equal add one to i until they do not match
            while i == j{
                
                j = Int(arc4random_uniform(UInt32(i + 1)))
                
            }
            print(i)
            print(j)
            //swap the values of the array
            cardDetail.imageCollectionArray.swapAt(i, j)
            
            //            swap(&cardDetail.imageCollectionArray[i], &cardDetail.imageCollectionArray[j])
        }
        
        //make sure image array shuffles
        print(cardDetail.imageCollectionArray)
        
    }
    
    //reset values to zero
    func reset(){
        
        //stop timer
        cardDetail.timer.invalidate()
        
        //reset counter to 0
        cardDetail.counter = 0
        
        //reset cardCount to 0
        cardDetail.cardCount = 0
        
        //reset timerText to counter value
        self.timerOutlet.text = "Time: \(cardDetail.counter)"
    }
    
    
    //TODO: -- Save users time on completion, Add date on completioin to save to CoreData
    
    
    //covert seconds to minutes for end of game alert
    func formatMinutes(_ totalSeconds: Int) -> String {
        
        let minutes = totalSeconds / 60;
        let seconds = totalSeconds % 60;
        
        return String(format:"%2d Minute & %02d Seconds!", minutes, seconds);
    }
    
    //TODO: Add high scores as option to alert at end game
    //reset game once all cards are matched
    func endGame(){
        
        //stop timer
        cardDetail.timer.invalidate()
        
        //create an alert that the user has won
        var alert = UIAlertController(title: "Congratulations!!!", message: "Your time was \(cardDetail.counter) Seconds!", preferredStyle: .alert)
        
        //check if counter is over 60 seconds
        if cardDetail.counter >= 60{
            
            //dev
            print(formatMinutes(cardDetail.counter))
            
            alert = UIAlertController(title: "Congratulations!!!", message: "Your time was\(formatMinutes(cardDetail.counter))", preferredStyle: .alert)
        }
        
        //add action to alert, reset data back to orignal values
        let action = UIAlertAction(title: "Play Again?", style: .default) { (ACTION)  in
            
            //reset game values
            self.reset()
            
            //reset timer function
            self.timer()
            
            //reshuffle deck
            self.shuffle()
            
            //loop through imageCollection
            for i in self.cardOutletCollection{
                
                //display views back to ui
                i.isHidden = false
                
                //set imageCollection to cardBackImage
                i.image = cardDetail.backImage
                
            }
        }
        
        //add action to alert
        alert.addAction(action)
        
        //present the alertVC
        self.present(alert, animated: true){
        }
        
    }
    
    
    func compareCards(){
        
        //set time interval to delay selected imageView
        //let delay = DispatchTime(uptimeNanoseconds: 300) + Double(1 * Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
        
        //delay after
        let delay = DispatchTime.now() + Double(1 * Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
        
        //deperected
        //let delayTime = DispatchTime.now() + 2
        
        //dispatch to main after speficed delayed time
        DispatchQueue.main.asyncAfter(deadline: delay + 0.2) { () -> Void in
            
            //check if card selection is equal
            if cardDetail.selection1?.image == cardDetail.selection2?.image{
                
                //add 1 to cardCount
                cardDetail.cardCount += 1
                
                //dissolve animation when images match
                UIView.transition(with: cardDetail.selection1!, duration: 1, options: UIViewAnimationOptions.transitionCrossDissolve, animations: { () -> Void in
                    cardDetail.selection1?.image = cardDetail.backImage
                }, completion: nil)
                UIView.transition(with: cardDetail.selection2!, duration: 1, options: UIViewAnimationOptions.transitionCrossDissolve, animations: { () -> Void in
                    cardDetail.selection2?.image = cardDetail.backImage
                }, completion: nil)
                
                print(cardDetail.cardCount)
                
                //remove cards if image matches
                self.deleteCards()
                
                if UIDevice.current.model == "iPad"{
                    
                    //end of game
                    if cardDetail.cardCount == 15{
                        
                        //call end game function
                        self.endGame()
                        
                    }
                    
                    
                }else{
                    //end of game
                    if cardDetail.cardCount == 10{
                        
                        //call endGame function
                        self.endGame()
                    }
                    
                }
                
                
            }else{
                
                //if cards do not match set image to backImage and enable user interaction
                UIView.transition(with: cardDetail.selection1!, duration: 1, options: UIViewAnimationOptions.transitionFlipFromTop, animations: { () -> Void in
                    cardDetail.selection1?.image = cardDetail.backImage
                }, completion: nil)
                
                UIView.transition(with: cardDetail.selection2!, duration: 1, options: UIViewAnimationOptions.transitionFlipFromTop, animations: { () -> Void in
                    cardDetail.selection2?.image = cardDetail.backImage
                }, completion: nil)
                
            }
            
            //enable user interaction
            cardDetail.selection1?.isUserInteractionEnabled = true
            cardDetail.selection2?.isUserInteractionEnabled = true
            
            //set image views back to nil
            cardDetail.selection1 = nil
            cardDetail.selection2 = nil
            
        }
        
    }
    
    //function to loop through imageCollection and add tapGesture to each imageView
    func tapGestureLoop(){
        
        //add tap gesture to imageCollectionOutlet
        //loop through imageCollection
        //deprcated method
        //        for i in 0 ..< cardOutletCollection.count += 1{
        //
        //            //tapGesture
        //            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GameViewController.tapGestureRecognized(_:)))
        //
        //            //add tap gesture to each imageView in imageCollection
        //            cardOutletCollection[i].addGestureRecognizer(tapGesture)
        //        }
        
        for i in (0 ..< cardOutletCollection.count){
            //tapGesture
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GameViewController.tapGestureRecognized(_:)))
            
            //add tap gesture to each imageView in imageCollection
            cardOutletCollection[i].addGestureRecognizer(tapGesture)
        }
    }
    
    //tapGestureRecognized function
    @objc func tapGestureRecognized(_ sender: UITapGestureRecognizer){
        
        //check if first selection is nil
        if cardDetail.selection1 == nil {
            
            //assign sender as imageView
            if let firstSelection = sender.view as? UIImageView{
                
                
                //assign image from sender to selected imageView
                cardDetail.selection1 = firstSelection
                
                //account for iPad (30 images)
                if UIDevice.current.model == "iPad"{
                    
                    cardDetail.selection1?.image = UIImage(named: cardDetail.ipadImageArray[firstSelection.tag])
                    
                    
                }else{
                    
                    cardDetail.selection1?.image = UIImage(named: cardDetail.imageCollectionArray[firstSelection.tag])
                    
                    //disable user interaction
                    if cardDetail.selection1 == cardDetail.selection1{
                        
                        cardDetail.selection1?.isUserInteractionEnabled = false
                    }
                    
                }
                
            }
            
        }else{
            
            //check if second selection is nil
            if cardDetail.selection2 == nil{
                
                //assign sender as imageView
                if let secondSelection = sender.view as? UIImageView{
                    
                    //assign image from sender to selected imageView
                    cardDetail.selection2 = secondSelection
                    
                    if UIDevice.current.model == "iPad"{
                        
                        cardDetail.selection2?.image = UIImage(named: cardDetail.ipadImageArray[secondSelection.tag])
                        
                    }else{
                        
                        cardDetail.selection2?.image = UIImage(named: cardDetail.imageCollectionArray[secondSelection.tag])
                        
                        //disable user interaction
                        if cardDetail.selection2 == cardDetail.selection2{
                            
                            cardDetail.selection2?.isUserInteractionEnabled = false
                        }
                    }
                    
                    compareCards()
                }
                
            }
            
        }
        
    }
    
}
