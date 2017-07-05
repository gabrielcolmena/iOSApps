//
//  Pokemon.swift
//  PokeApp
//
//  Created by Gabriel Colmenares on 7/4/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: Int!
    private var _height: Int!
    private var _weight: Int!
    private var _baseAttack: Int!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    private var _movesNames: Array<String> = []
    private var _movesTypes: Array<String> = []
    private var _pokemonURLV2: String!

    var movesTypes: Array<String>{
        return _movesTypes
    }
    
    var movesNames: Array<String>{
        return _movesNames
    }

    var nextEvolutionLevel: String{
        if _nextEvolutionLevel == nil{
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var nextEvolutionID: String{
        if _nextEvolutionID == nil{
            _nextEvolutionID = ""
        }
        return _nextEvolutionID
    }
    
    var nextEvolutionName: String{
        if _nextEvolutionName == nil{
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var name: String{
        if _name == nil{
            _name = ""
        }
        return _name
    }
    
    var pokedexId: Int{
        if _pokedexId == nil{
            _pokedexId = 0
        }
        return _pokedexId
    }
    
    var description: String{
        if _description == nil{
            _description = ""
        }
        return _description
    }

    var type: String{
        if _type == nil{
            _type = ""
        }
        return _type
    }
    
    var defense: Int{
        if _defense == nil{
            _defense = 0
        }
        return _defense
    }
    
    var height: Int{
        if _height == nil{
            _height = 0
        }
        return _height
    }
    
    var weight: Int{
        if _weight == nil{
            _weight = 0
        }
        return _weight
    }
    
    var baseAttack: Int{
        if _baseAttack == nil{
            _baseAttack = 0
        }
        return _baseAttack
    }
    
    var nextEvolutionTxt: String{
        if _nextEvolutionTxt == nil{
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var pokemonURL: String{
        if _pokemonURL == nil{
            _pokemonURL = ""
        }
        return _pokemonURL
    }
    
    var pokemonURLV2: String{
        if _pokemonURLV2 == nil{
            _pokemonURLV2 = ""
        }
        return _pokemonURLV2
    }
    
    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(BASE_URL)\(self._pokedexId!)"
        self._pokemonURLV2 = "\(V2BASE_URL)\(self._pokedexId!)"
    }
    
    func downloadDetails(completed: @escaping DownloadComplete){
        Alamofire.request(_pokemonURL).responseJSON{ response in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String{
                    self._weight = Int(weight)
                }
                
                if let height = dict["height"] as? String{
                    self._height = Int(height)
                }
                
                if let attack = dict["attack"] as? Int{
                    self._baseAttack = attack
                }
                
                if let defense = dict["defense"] as? Int{
                    self._defense = defense
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0{
                    
                    var typeArrays = [String]()
                    
                    for type in types{
                        typeArrays.append(type["name"]!)
                    }
                    
                    self._type = typeArrays.joined(separator: "/").capitalized
                    
                }else{
                    self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>], descArr.count > 0{
                    
                    if let url = descArr[0]["resource_uri"]{
                        let FULLURL = "http://pokeapi.co/\(url)"
                            
                        Alamofire.request(FULLURL).responseJSON{ response in
                            if let descDict = response.result.value as? Dictionary<String, AnyObject>{
                                if let description = descDict["description"] as? String{
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = newDescription
                                    
                                }
                            }
                            completed()
                        }
                    }
                }
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0{
                    if let nextEvo = evolutions[0]["to"] as? String{
                        if nextEvo.range(of: "mega") == nil{
                            self._nextEvolutionName = nextEvo.capitalized
                            if let uri = evolutions[0]["resource_uri"] as? String{
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon", with: "")
                                let nextEvoID = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionID = nextEvoID
                                
                                if let lvlExist = evolutions[0]["level"]{
                                    if let lvl = lvlExist as? Int{
                                        self._nextEvolutionLevel = "\(lvl)"
                                    }
                                }else{
                                    self._nextEvolutionLevel = ""
                                }
                            }
                        }
                    }
                }else{
                    self._nextEvolutionTxt = ""
                    self._nextEvolutionID = "none"
                }
                
            }
            
            Alamofire.request(self._pokemonURLV2).responseJSON{ response in
                if let dict = response.result.value as? Dictionary<String, AnyObject>{
                    if let fullMoves = dict["moves"] as? [Dictionary<String, AnyObject>]{
                        let moves = fullMoves[0...3]
                        for i in 0...moves.count - 1{
                            if let moveDict = moves[i]["move"] as? Dictionary<String, AnyObject>{
                                if let moveName = moveDict["name"] as? String{
                                    self._movesNames.append(moveName)
                                }
                                if let moveURL = moveDict["url"] as? String{
                                    Alamofire.request(moveURL).responseJSON{ response in
                                        if let moveDict = response.result.value as? Dictionary<String, AnyObject>{
                                            if let type = moveDict["type"] as? Dictionary<String, AnyObject>{
                                                if let typeName = type["name"] as? String{
                                                    self._movesTypes.append(typeName)
                                                }
                                            }
                                        }
                                        completed()
                                    }
                                }
                            }
                        }
                    }
                }
                completed()
            }
            
            completed()
        }
    }
}
