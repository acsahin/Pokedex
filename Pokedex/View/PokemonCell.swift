//
//  PokemonListCell.swift
//  Pokedex
//
//  Created by ACS on 8.01.2021.
//

import SwURL
import SwiftUI

struct PokemonListCell: View {
    let pokemon: Pokemon
    
    init(pokemon: Pokemon) {
        SwURL.setImageCache(type: .persistent)
        self.pokemon = pokemon
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text(pokemon.name.capitalized)
                    .font(.headline).bold()
                    .foregroundColor(.black)
                    .padding(.top, 6)
                    .frame(width: 180)
                Text("#"+String(format: "%03d", pokemon.id))
                    .italic()
                    .font(.footnote)
                    .foregroundColor(Color(red: 111/255, green: 111/255, blue: 111/255))
                RemoteImageView(url: URL(string: (pokemon.sprites.other?.officialArtwork.frontDefault)!)!)
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                HStack {
                    ForEach(0..<pokemon.types.count, id: \.self) { index in
                        Text("\(pokemon.types[index].type.name)")
                            .font(.subheadline)
                            .foregroundColor(typeTextColor(typeName: pokemon.types[index].type.name))
                            .padding([.bottom, .top], 6)
                            .padding([.leading, .trailing], 9)
                            .background(typeColor(typeName: pokemon.types[index].type.name))
                            .cornerRadius(12)
                            .padding(.bottom, 6)
                    }
                }
            }
        }
        .background(Color(red: 210/255, green: 210/255, blue: 210/255))
        .cornerRadius(12)
        .shadow(color: Color.gray, radius: 5, x: -1.0, y: 3.0)
        .onTapGesture {
            print("\(pokemon.sprites.other?.officialArtwork.frontDefault ?? "acs")")
        }
    }
    
    func typeColor(typeName: String) -> some View {
        switch typeName {
        case "dark":
            return AnyView(Color.black)
        case "ghost":
            return AnyView(Color.purple)
        case "ice":
            return AnyView(Color.blue)
        case "steel":
            return AnyView(Color.gray)
        case "rock":
            return AnyView(Color(UIColor.brown))
        case "psychic":
            return AnyView(Color.pink)
        case "fighting":
            return AnyView(Color(UIColor.brown))
        case "fairy":
            return AnyView(Color.pink)
        case "electric":
            return AnyView(Color.yellow)
        case "ground":
            return AnyView(LinearGradient(gradient: Gradient(colors: [.yellow, .gray]), startPoint: .top, endPoint: .bottom))
        case "normal":
            return AnyView(Color.gray)
        case "dragon":
            return AnyView(LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .top, endPoint: .bottom))
        case "grass":
            return AnyView(Color.green)
        case "poison":
            return AnyView(Color.purple)
        case "fire":
            return AnyView(Color.orange)
        case "water":
            return AnyView(Color.blue)
        case "bug":
            return AnyView(Color.green)
        case "flying":
            return AnyView(LinearGradient(gradient: Gradient(colors: [.white, .blue]), startPoint: .top, endPoint: .bottom))
        default:
            return AnyView(Color.white)
        }
    }
    
    func typeTextColor(typeName: String) -> Color {
        switch typeName {
        case "dark":
            return Color.white
        case "ghost":
            return Color.white
        case "ice":
            return Color.white
        case "steel":
            return Color.black
        case "rock":
            return Color.white
        case "psychic":
            return Color.white
        case "fighting":
            return Color.white
        case "fairy":
            return Color.black
        case "electric":
            return Color.black
        case "ground":
            return Color.black
        case "normal":
            return Color.black
        case "dragon":
            return Color.white
        case "grass":
            return Color.black
        case "poison":
            return Color.white
        case "fire":
            return Color.white
        case "water":
            return Color.white
        case "bug":
            return Color.white
        case "flying":
            return Color.black
        default:
            return Color.black
        }
    }
    
}
