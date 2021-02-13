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
                    .padding(.top, 9)
                Text("#"+String(format: "%03d", pokemon.id))
                    .italic()
                    .font(.footnote)
                    .foregroundColor(Color("PokemonGray"))
                RemoteImageView(url: URL(string: (pokemon.sprites.other?.officialArtwork.frontDefault)!)!)
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .padding([.leading, .trailing], 40)
                HStack {
                    ForEach(0..<pokemon.types.count, id: \.self) { index in
                        Text("\(pokemon.types[index].type.name)")
                            .font(.subheadline)
                            .foregroundColor(typeTextColor(typeName: pokemon.types[index].type.name))
                            .padding([.bottom, .top], 6)
                            .padding([.leading, .trailing], 9)
                            .background(typeColor(typeName: pokemon.types[index].type.name))
                            .cornerRadius(12)
                            .padding(.bottom, 9)
                    }
                }
            }
        }
        .background(Color("PokemonGray2"))
        .cornerRadius(12)
        .shadow(color: Color.gray, radius: 5, x: -1.0, y: 3.0)
    }
    
    func typeColor(typeName: String) -> some View {
        switch typeName {
        case "dark":
            return AnyView(Color.black)
        case "ghost","poison":
            return AnyView(Color.purple)
        case "ice","water":
            return AnyView(Color.blue)
        case "steel","normal":
            return AnyView(Color.gray)
        case "rock","fighting":
            return AnyView(Color(UIColor.brown))
        case "psychic","fairy":
            return AnyView(Color.pink)
        case "electric":
            return AnyView(Color.yellow)
        case "ground":
            return AnyView(LinearGradient(gradient: Gradient(colors: [.yellow, .gray]), startPoint: .top, endPoint: .bottom))
        case "dragon":
            return AnyView(LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .top, endPoint: .bottom))
        case "grass","bug":
            return AnyView(Color.green)
        case "fire":
            return AnyView(Color.orange)
        case "flying":
            return AnyView(LinearGradient(gradient: Gradient(colors: [.white, .blue]), startPoint: .top, endPoint: .bottom))
        default:
            return AnyView(Color.white)
        }
    }
    
    func typeTextColor(typeName: String) -> Color {
        switch typeName {
        case "dark","ghost","ice","rock","psychic","fighting","dragon","poison","fire","water","bug":
            return .white
        default :
            return .black
        }
    }
    
}
