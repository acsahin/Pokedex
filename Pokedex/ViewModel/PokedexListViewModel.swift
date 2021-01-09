//
//  PokedexListViewModel.swift
//  Pokedex
//
//  Created by ACS on 8.01.2021.
//

import SwiftUI

class PokedexListViewModel: ObservableObject {
    @Published var pokemonList = [Pokemon]()
    let limit = "30"
    var offset = "0"
    let listUrl = "https://pokeapi.co/api/v2"
    
    init() {
        fetchPage()
    }
    
    func fetchPage() {
        print("fetch starts")
        var tempList = [Pokemon]()
        for order in (Int(offset)!+1)...Int(limit)! {
            let stringUrl = listUrl + "/pokemon/\(order)"
            print(stringUrl)
            let url = URL(string: stringUrl)
                URLSession.shared.dataTask(with: url!) { (data, response, error) in
                    guard let data = data else { print("data"); return }
                    guard let pok = try? JSONDecoder().decode(Pokemon.self, from: data) else { print("pok"); return }
                    tempList.append(pok)
                    if order==Int(self.limit) {
                        DispatchQueue.main.async {
                            self.pokemonList = tempList
                            print(order)
                        }
                    }
                }.resume()
        }
        print("final")
        print(self.pokemonList.count)
    }
}
