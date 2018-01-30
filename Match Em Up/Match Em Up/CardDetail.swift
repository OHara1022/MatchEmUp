//
//  CardDetail.swift
//  Match Em Up
//
//  Created by Scott O'Hara on 2/9/16.
//  Copyright © 2016 Scott O'Hara. All rights reserved.
//

import Foundation

//import UIKit
import UIKit

class CardDetail {
    
    //array of image names as stings
    var imageCollectionArray: [String] = ["asphalt", "asphalt", "bottle", "bottle", "bulb", "bulb", "dice", "dice", "emptybottle", "emptybottle", "goldbars",  "goldbars", "goldcoins", "goldcoins", "lightbulb","lightbulb", "minerals", "minerals", "mushroom", "mushroom"]
    
    var ipadImageArray: [String] = ["asphalt", "asphalt", "bottle", "bottle", "bulb", "bulb", "dice", "dice", "emptybottle", "emptybottle", "goldbars",  "goldbars", "goldcoins", "goldcoins", "lightbulb","lightbulb", "minerals", "minerals", "mushroom", "mushroom","music","music","piano","piano","redstone","redstone","rock","rock","stone","stone"]
    
    
    //set back image for imageViews
    let backImage = UIImage(named: "mainImage")
    
    //timer
    var timer = Timer()
    
    //counter interger for game timer
    var counter = 0
    
    //card count to inform the user when they have won
    var cardCount = 0
    
    //optional(empty) UIImageViews to hold users selection
    var selection1: UIImageView?
    var selection2: UIImageView?

}
