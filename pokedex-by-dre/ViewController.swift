//
//  ViewController.swift
//  pokedex-by-dre
//
//  Created by D'Andre Ealy on 1/9/16.
//  Copyright © 2016 D'Andre Ealy. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    
    var pokemon = [Pokemon]()
    var searchResults = []
    @IBOutlet weak var searchBar: UISearchBar!
    var inSearchMode = false
    var musicPlayer: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchBar.returnKeyType = UIReturnKeyType.Done
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        
        parseCSV()
        
        initAudio()
    }
    
    func initAudio(){
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path!)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    func parseCSV(){
        
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let name = row["identifier"]!
                let pokeID = Int(row["id"]!)!
                
                let poke = Pokemon(name: name, pokedexId: pokeID)
                
                pokemon.append(poke)
            }
            
        }catch {
            
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            
            var poke: Pokemon!
            
            if inSearchMode {
                poke = searchResults[indexPath.row] as! Pokemon
            }else {
                poke = pokemon[indexPath.row]
                
            }
            
            cell.configureCell(poke)
            
            return cell
        }else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode {
            poke = searchResults[indexPath.row] as! Pokemon
        }else {
            poke = pokemon[indexPath.row]
        }
        
        performSegueWithIdentifier("ShowDetailVC", sender: poke)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetailVC"{
            if let detaileVC = segue.destinationViewController as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detaileVC.pokemon = poke
                }
            }
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return searchResults.count
        }else {
            return pokemon.count
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(105, 105)
    }
    
    @IBAction func musicButton(sender: UIButton!){
        if musicPlayer.playing {
            musicPlayer.stop()
            sender.alpha = 0.02
        }else if !musicPlayer.playing {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
        }else {
            inSearchMode = true
            let lower = searchBar.text?.lowercaseString
            
            searchResults = pokemon.filter({$0.name.rangeOfString(lower!) != nil})
            collection.reloadData()
        }
    }
}
