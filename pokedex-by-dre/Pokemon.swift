//
//  Pokemon.swift
//  pokedex-by-dre
//
//  Created by D'Andre Ealy on 1/9/16.
//  Copyright © 2016 D'Andre Ealy. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLvl: String!
    private var _pokemonUrl: String!
    
    
    var name: String {
        get {
            return _name
        }
    }
    
    var description: String {
        
        get {
            if _description == nil {
                return ""
            }
        } else {
            return _description
        }
        
        
    }
    
    var type: String {
        return _type
    }
    
    var defense: String {
        return _defense
    }
    
    var height: String {
        return _height
    }
    
    var weight: String {
        return _weight
    }
    
    var attack: String {
        return _attack
    }
    
    var nextEvolutionTxt: String {
        return _nextEvolutionTxt
    }
    
    var nextEvolutionId: String {
        return _nextEvolutionId
    }
    
    var nextEvolutionLvl: String {
        return _nextEvolutionLvl
    }
    
    var pokemonUrl: String {
        return _pokemonUrl
    }
    
    var pokedexId: Int {
        get {
            return _pokedexId
        }
    }
    
    
    init(name:String, pokedexId:Int){
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetails(complete: DownloadComplete){
        
        let url = NSURL(string: _pokemonUrl)!
        
        Alamofire.request(.GET, url).responseJSON {response in
            
            if let JSON = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = JSON["weight"] as? String {
                    self._weight = weight
                }
                if let height = JSON["height"] as? String {
                    self._height = height
                }
                if let attack = JSON["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = JSON["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let evolutions = JSON["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    if let to = evolutions [0]["to"] as? String {
                        if to.rangeOfString("mega") == nil {
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newString = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = newString.stringByReplacingOccurrencesOfString("/", withString: "")
                                
                                self._nextEvolutionId = num
                                self._nextEvolutionTxt = to
                                if let level = evolutions [0]["level"] as? Int {
                                    self._nextEvolutionLvl = "\(level)"
                                }
                            }
                        }
                        
                        
                    }
                }
                
                if let types = JSON["types"] as? [Dictionary<String, AnyObject>] where types.count > 0 {
                    
                    if let name = types [0]["name"] as? String {
                        self._type = name.capitalizedString
                    }
                    
                    if types.count > 1 {
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                }else {
                    self._type = ""
                }
                
                if let descriptions = JSON["descriptions"] as? [Dictionary<String, AnyObject>]  where descriptions.count > 0 {
                    if let description = descriptions[0]["resource_uri"] {
                        
                        let url = description
                        let fullUrl = "\(URL_BASE)\(url)"
                        if let nsurl = NSURL(string: fullUrl) {
                            
                            Alamofire.request(.GET, nsurl).responseJSON {response in
                                
                                if let desc = response.result.value as? Dictionary<String,AnyObject> {
                                    if let description = desc["description"] as? String {
                                        print(description)
                                        self._description = description
                                    }
                                }
                                complete()
                                
                            }
                            
                        }else {
                            self._description = ""
                        }
                        
                        
                        
                        
                    }
                }
            }
            
        }
    }
}





