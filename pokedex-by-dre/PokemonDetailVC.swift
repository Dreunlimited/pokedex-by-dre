//
//  PokemonDetailVC.swift
//  pokedex-by-dre
//
//  Created by D'Andre Ealy on 1/14/16.
//  Copyright © 2016 D'Andre Ealy. All rights reserved.
//

import UIKit
import  Alamofire

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
