//
//  ViewController.swift
//  Match Em Up
//
//  Created by Scott O'Hara on 2/5/16.
//  Copyright © 2016 Scott O'Hara. All rights reserved.
//

import UIKit

//init class so it can be used throughtout each file 
var cardDetail: CardDetail = CardDetail()
var gameViewController: GameViewController = GameViewController()

class ViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //testing new color pallet
//        playButton.backgroundColor = UIColor(red: 0.73, green: 0.88, blue: 1.00, alpha: 1.0)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

