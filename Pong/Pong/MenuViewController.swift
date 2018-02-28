//
//  MenuViewController.swift
//  Pong
//
//  Created by Tao Ong on 2/27/18.
//  Copyright © 2018 Tao Ong. All rights reserved.
//

import Foundation
import UIKit

enum gameType {
    case easy
    case medium
    case hard
}

class MenuViewController : UIViewController {
    
    @IBAction func easy(_ sender: Any) {
        moveToGame(game: .easy)
    }
    
    @IBAction func medium(_ sender: Any) {
        moveToGame(game: .medium)
    }
    
    @IBAction func hard(_ sender: Any) {
        moveToGame(game: .hard)
    }
    
    func moveToGame(game : gameType) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        currentGameType = game
        self.navigationController?.pushViewController(gameVC, animated: true)
        
        
    }
}
