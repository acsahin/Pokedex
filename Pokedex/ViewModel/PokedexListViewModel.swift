//
//  PokedexListViewModel.swift
//  Pokedex
//
//  Created by ACS on 8.01.2021.
//

import SwiftUI

class PokedexListViewModel: ObservableObject {
    @Published var pokemonList = [Pokemon]()
    
    @Published var backButtonVisibility = false
    @Published var nextButtonVisibility = true
    
    var limit = 30
    var offset = 0
    let listUrl = "https://pokeapi.co/api/v2"
    let maxPokemonNumber = 1118
    
    init() {
        fetchPage()
    }
    
    func fetchPage() {
        print("fetch starts...")
        var tempList = [Pokemon]()
        let group = DispatchGroup()
        for order in (offset+1)...limit {
            group.enter()
            let stringUrl = listUrl + "/pokemon/\(order)"
            print(stringUrl)
            let url = URL(string: stringUrl)
                URLSession.shared.dataTask(with: url!) { (data, response, error) in
                    guard let data = data else { print("data"); return }
                    guard let pok = try? JSONDecoder().decode(Pokemon.self, from: data) else { print("pok"); return }
                    tempList.append(pok)
                    group.leave()
                }.resume()
        }
        
        group.notify(queue: .main) {
            self.pokemonList.removeAll()
            self.pokemonList = tempList.sorted(by: {$0.id < $1.id})
        }
    }
    
    func nextPage() {
        if limit != maxPokemonNumber {
            if limit == 1110 {
                limit = maxPokemonNumber
                nextButtonVisibility = false
            } else {
                limit = limit + 30
            }
            offset = offset + 30
            backButtonVisibility = true
            fetchPage()
        }
    }
    
    func backPage() {
        if offset != 0 {
            offset = offset - 30
            if limit == maxPokemonNumber {
                limit = 1110
            } else {
                limit = limit - 30
            }
            nextButtonVisibility = true
            fetchPage()
        }
        if offset == 0 {
            backButtonVisibility = false
        }
    }
}
