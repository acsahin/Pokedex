//
//  PokedexListView.swift
//  Pokedex
//
//  Created by ACS on 8.01.2021.
//

import SwiftUI

struct PokedexListView: View {
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    @ObservedObject var viewModel = PokedexListViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ScrollView {
                    LazyVGrid (columns: gridItems, alignment: .center, spacing: 16, content:{
                        ForEach(viewModel.currentPage) { pokemon in
                            PokemonListCell(pokemon: pokemon)
                        }
                    }).padding(.top,12)
                    HStack {
                        if viewModel.backButtonVisibility {
                            Button(action: {
                                viewModel.backPage()
                            }) {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }.padding(9)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(10)
                        }
                        Spacer()
                        if viewModel.nextButtonVisibility {
                            Button(action: {
                                viewModel.nextPage()
                            }) {
                                Text("Next")
                                Image(systemName: "chevron.right")
                            }.padding(9)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(10)
                        }
                    }.padding([.leading, .trailing], 58).padding(.top, 9)
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading:
                                        HStack {
                                            Image("pokeball")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                            Text("Pokedex")
                                                .font(.title).bold()
                                        }
                                        .frame(width: geometry.size.width, alignment: .center)
                )
            }
        }
    }
}

struct PokedexListView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexListView()
    }
}
