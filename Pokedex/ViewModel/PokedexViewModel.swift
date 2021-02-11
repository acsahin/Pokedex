//
//  PokedexListViewModel.swift
//  Pokedex
//
//  Created by ACS on 8.01.2021.
//

import SwiftUI

class PokedexListViewModel: ObservableObject {
    @Published var currentPage = [Pokemon]()
    @Published var backButtonVisibility: Bool = false
    @Published var nextButtonVisibility: Bool = false
    @Published var isDownloading: Bool = true
    
    var pokemonList = [Pokemon]()
    
    var limit = 30
    var offset = 0
    let listUrl = "https://pokeapi.co/api/v2"
    
    //898 total number
    let maxPokemonNumber = 32
    
    init() {
        //Download pokemons async
        DispatchQueue.global().async {
            self.downloadPokemon()
        }
    }
    
    func downloadPokemon() {
        var tempList = [Pokemon]()
        let group = DispatchGroup()
        for order in 1...maxPokemonNumber {
            group.enter()
            let stringUrl = self.listUrl + "/pokemon/\(order)"
            print(stringUrl)
            let url = URL(string: stringUrl)
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                guard let data = data else { return }
                guard let pok = try? JSONDecoder().decode(Pokemon.self, from: data) else { return }
                tempList.append(pok)
                
                DispatchQueue.main.async {
                    if tempList.count % 30 == 0 {
                        // To change published variables
                        // Go back to main thread
                        self.pokemonList.append(contentsOf: tempList)
                        tempList.removeAll()
                        
                        //Share first page
                        if self.pokemonList.count == 30 {
                            self.editCurrentPage()
                            self.isDownloading = false
                        }
                        
                        //If the next page is ready
                        //Make next button visible
                        if self.pokemonList.count - self.limit >= 30 {
                            self.nextButtonVisibility = true
                        }
                    }else if tempList.count + self.pokemonList.count == self.maxPokemonNumber {
                        self.pokemonList.append(contentsOf: tempList)
                        tempList.removeAll()
                    }
                }
                group.leave()
            }.resume()
            group.wait()
        }
        group.notify(queue: .main) {
            // Give a message
            //BUGFIX
            if self.limit == (self.maxPokemonNumber - (self.maxPokemonNumber % 30)) {
                self.nextButtonVisibility = true
            }
        }
    }
    
    //MARK: - Next Page
    func nextPage() {
        if limit != maxPokemonNumber {
            //At last page, next button is invisible
            if limit == (maxPokemonNumber - (maxPokemonNumber % 30)) {
                limit = maxPokemonNumber
                nextButtonVisibility = false
                editCurrentPage()
            } else {
                limit = limit + 30
            }
            offset = offset + 30
            backButtonVisibility = true
            editCurrentPage()
        }
    }
    
    //MARK: - Back Page
    func backPage() {
        if offset != 0 {
            offset = offset - 30
            if limit == maxPokemonNumber {
                limit = maxPokemonNumber - (maxPokemonNumber % 30)
            } else {
                limit = limit - 30
            }
            nextButtonVisibility = true
            editCurrentPage()
        }
        
        //At first page, back button is invisible
        if offset == 0 {
            backButtonVisibility = false
        }
    }
    
    //MARK: - Edit Page
    func editCurrentPage() {
        self.currentPage.removeAll()
        for item in offset...(limit-1) {
            self.currentPage.append(self.pokemonList[item])
        }
        
        //If next page is NOT ready, make next button invisible
        if self.pokemonList.count - limit < 30 && self.pokemonList.count != self.maxPokemonNumber {
            nextButtonVisibility = false
        }
    }
}
