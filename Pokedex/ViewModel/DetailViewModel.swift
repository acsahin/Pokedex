//
//  DetailViewModel.swift
//  Pokedex
//
//  Created by ACS on 12.02.2021.
//

import SwiftUI

class DetailViewModel {
    func makeTitle(name: String)-> String {
        switch name {
        case "hp":
            return "HP"
        case "attack":
            return "DMG"
        case "defense":
            return "DEF"
        case "special-attack":
            return "DMG\n⭐️"
        case "special-defense":
            return "DEF\n⭐️"
        case "speed":
            return "🏃🏼"
        default:
            return "BOS"
        }
    }
}
