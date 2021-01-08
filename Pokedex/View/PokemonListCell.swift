//
//  PokemonListCell.swift
//  Pokedex
//
//  Created by ACS on 8.01.2021.
//

import SwiftUI

struct PokemonListCell: View {
    var body: some View {
        ZStack {
            VStack {
                Text("Name")
                    .font(.headline).bold()
                    .foregroundColor(.black)
                    .padding(.top, 6)
                    .frame(width: 180)
                Text("#003")
                    .font(.footnote)
                    .foregroundColor(Color(red: 111/255, green: 111/255, blue: 111/255))
                Image("bulbasaur")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .padding([.top, .bottom],4)
                Text("water")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding([.bottom, .top], 6)
                    .padding([.leading, .trailing], 9)
                    .background(Color.red)
                    .cornerRadius(12)
                    .padding(.bottom, 6)
            }
        }
        .background(Color(red: 210/255, green: 210/255, blue: 210/255))
        .cornerRadius(12)
        .shadow(color: Color.gray, radius: 5, x: -1.0, y: 3.0)
    }
}

struct PokemonListCell_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListCell()
    }
}
