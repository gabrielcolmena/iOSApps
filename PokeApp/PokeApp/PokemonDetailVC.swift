//
//  PokemonDetailVC.swift
//  PokeApp
//
//  Created by Gabriel Colmenares on 7/4/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet var nextEvoImageLoading: UIActivityIndicatorView!
    @IBOutlet var descriptionLoading: UIActivityIndicatorView!
    @IBOutlet var movesLoading: UIActivityIndicatorView!
    @IBOutlet var tabController: UISegmentedControl!
    @IBOutlet var nextEvolutionImage: UIImageView!
    @IBOutlet var nextEvolutionLbl: UILabel!
    @IBOutlet var descriptionLbl: UILabel!
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var baseAttackLbl: UILabel!
    @IBOutlet var pokedexIDLbl: UILabel!
    @IBOutlet var movesTabView: UIView!
    @IBOutlet var defenseLbl: UILabel!
    @IBOutlet var bioTabView: UIView!
    @IBOutlet var weightLbl: UILabel!
    @IBOutlet var heightLbl: UILabel!
    @IBOutlet var typeLbl: UILabel!
    @IBOutlet var nameLbl: UILabel!
    
    @IBOutlet var firstMove: RoundedLabel!
    @IBOutlet var secondMove: RoundedLabel!
    @IBOutlet var thirdMove: RoundedLabel!
    @IBOutlet var fourthMove: RoundedLabel!
    
    var labels = [UILabel]()
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labels.append(firstMove)
        labels.append(secondMove)
        labels.append(thirdMove)
        labels.append(fourthMove)
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImage.image = img
        
        nameLbl.text = pokemon.name.capitalized
        pokedexIDLbl.text = "\(pokemon.pokedexId)"
        
        descriptionLoading.startAnimating()
        nextEvoImageLoading.startAnimating()
        movesLoading.startAnimating()
        
        pokemon.downloadDetails{
            
            if self.pokemon.description != ""{
                self.descriptionLoading.stopAnimating()
                self.descriptionLoading.isHidden = true
            }
            
            if self.pokemon.nextEvolutionID != ""{
                self.nextEvoImageLoading.stopAnimating()
                self.nextEvoImageLoading.isHidden = true
            }
            
            if self.pokemon.movesTypes.count == 4{
                self.movesLoading.stopAnimating()
                self.movesLoading.isHidden = true
                for label in self.labels{
                    label.isHidden = false
                }
            }
            
            self.updateUI()
        }
    }
    
    func updateUI(){
        
        baseAttackLbl.text = "\(pokemon.baseAttack)"
        defenseLbl.text = "\(pokemon.defense)"
        heightLbl.text = "\(pokemon.height)"
        weightLbl.text = "\(pokemon.weight)"
        typeLbl.text = pokemon.type
        descriptionLbl.text = pokemon.description
        
        if pokemon.movesTypes.count == 4{
            for i in 0...labels.count - 1{
                labels[i].text = pokemon.movesNames[i]
                let color: UIColor = hexStringToUIColor(hex: colorsDict[pokemon.movesTypes[i]]!)
                labels[i].backgroundColor = color
                
            }
        }
        
        if pokemon.nextEvolutionID == "none" || pokemon.nextEvolutionID == ""{
            
            nextEvolutionLbl.text = "No evolutions"
            nextEvolutionImage.isHidden = true
            nextEvoImageLoading.stopAnimating()
            nextEvoImageLoading.isHidden = true
            
        }else{
            nextEvolutionImage.isHidden = false
            nextEvolutionImage.image = UIImage(named: pokemon.nextEvolutionID)
            let str = "Next evolution: \(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLevel)"
            nextEvolutionLbl.text = str
        }
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func tabPressed(_ sender: Any) {
        
        if tabController.selectedSegmentIndex == 1{
            bioTabView.isHidden = true
            movesTabView.isHidden = false
        }else{
            bioTabView.isHidden = false
            movesTabView.isHidden = true
        }
    }

    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
}
