//
//  PokemonDetailVC.swift
//  pokedex-by-dre
//
//  Created by D'Andre Ealy on 1/14/16.
//  Copyright © 2016 D'Andre Ealy. All rights reserved.
//

import UIKit
import Alamofire

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var wightLbl: UILabel!
    @IBOutlet weak var baseLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name.capitalizedString
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
      
        
        pokemon.downloadPokemonDetails { () -> () in
            //This will be called after download is done
            self.updateUI()
        }
        
    }
    
    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func updateUI(){
        typeLbl.text = pokemon.type
        wightLbl.text = pokemon.weight
        descriptionLbl.text = pokemon.description
        heightLbl.text = pokemon.height
        defenseLbl.text = pokemon.defense
        currentEvoImg.image = UIImage(named: "\(pokemon.pokedexId)")
        
        if pokemon.nextEvolutionId == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImg.hidden = true
        }else{
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.nextEvolutionId)"
            
            if pokemon.nextEvolutionLvl != "" {
                    str += " -Lvl \(pokemon.nextEvolutionLvl)"
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
