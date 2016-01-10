//
//  Pokemon.swift
//  pokedex-by-dre
//
//  Created by D'Andre Ealy on 1/9/16.
//  Copyright © 2016 D'Andre Ealy. All rights reserved.
//

import Foundation


class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String {
        get {
            return _name
        }
    }
    
    var pokedexId: Int {
        get {
            return _pokedexId
        }
    }
    
    init(name:String, pokedexId:Int){
        self._name = name
        self._pokedexId = pokedexId
    }
}