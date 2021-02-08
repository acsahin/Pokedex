//
//  PokedexListViewModel.swift
//  Pokedex
//
//  Created by ACS on 8.01.2021.
//

import SwiftUI

class PokedexListViewModel: ObservableObject {
    @Published var currentPage = [Pokemon]()
    @Published var backButtonVisibility = false
    @Published var nextButtonVisibility = true
    
    var pokemonList = [Pokemon]()
    
    var limit = 30
    var offset = 0
    let listUrl = "https://pokeapi.co/api/v2"
    let maxPokemonNumber = 898
    
    init() {
        DispatchQueue.global().async {
            self.fetchPokemon()
        }
    }
    
    func fetchPokemon() {
        print("fetch starts...")
        var tempList = [Pokemon]()
        let group = DispatchGroup()
        for order in 1...maxPokemonNumber {
                group.enter()
                let stringUrl = self.listUrl + "/pokemon/\(order)"
                print(stringUrl)
                let url = URL(string: stringUrl)
                    URLSession.shared.dataTask(with: url!) { (data, response, error) in
                        guard let data = data else { print("data"); return }
                        guard let pok = try? JSONDecoder().decode(Pokemon.self, from: data) else {
                            print("pok, \(String(describing: response)), \(String(describing: error?.localizedDescription))"); return }
                        print("\(order) is added")
                        tempList.append(pok)
                        if tempList.count % 30 == 0 {
                            DispatchQueue.main.async {
                                self.pokemonList.append(contentsOf: tempList)
                                tempList.removeAll()
                                if self.pokemonList.count == 30 {
                                    self.makePage()
                                }
                            }
                        }
                        group.leave()
                    }.resume()

                group.wait()
        }
        group.notify(queue: .main) {
            print("notify selected")
            if tempList.count % 30 == 0 {
                self.pokemonList.append(contentsOf: tempList)
                tempList.removeAll()
                if self.pokemonList.count == 30 {
                    self.makePage()
                }
            }
        }
    }
    
    func nextPage() {
        if limit != maxPokemonNumber {
            if limit == 870 {
                limit = maxPokemonNumber
                nextButtonVisibility = false
            } else {
                limit = limit + 30
            }
            offset = offset + 30
            backButtonVisibility = true
            makePage()
        }
    }
    
    func backPage() {
        if offset != 0 {
            offset = offset - 30
            if limit == maxPokemonNumber {
                limit = 870
            } else {
                limit = limit - 30
            }
            nextButtonVisibility = true
            makePage()
        }
        if offset == 0 {
            backButtonVisibility = false
        }
    }
    
    func makePage() {
        self.currentPage.removeAll()
        for item in offset...(limit-1) {
            self.currentPage.append(self.pokemonList[item])
        }
        print("make pageeee \(self.currentPage.count)")        
    }
}
