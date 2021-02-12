//
//  PokedexListView.swift
//  Pokedex
//
//  Created by ACS on 8.01.2021.
//

import SwiftUI

struct PokedexListView: View {
    private let gridItems = [GridItem(.flexible(), spacing: -10), GridItem(.flexible(), spacing: -10)]
    @ObservedObject var viewModel = PokedexListViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { scrollView in
                NavigationView {
                    ScrollView {
                        if viewModel.isDownloading {
                            ProgressView("Downloading...").padding(.top, geometry.size.height/3)
                        }else {
                            LazyVGrid (columns: gridItems, alignment: .center, spacing: 16, content:{
                                ForEach(viewModel.currentPage) { poke in
                                    NavigationLink(destination: DetailView(pokemon: poke)) {
                                        PokemonListCell(pokemon: poke)
                                    }
                                }
                            }).padding(.top,12)
                            HStack {
                                if viewModel.backButtonVisibility {
                                    Button(action: {
                                        scrollView.scrollTo(viewModel.currentPage[0].id, anchor: .top)
                                        viewModel.backPage()
                                    }) {
                                        Image(systemName: "chevron.left")
                                        Text("Back")
                                    }.padding(9)
                                    .foregroundColor(.white)
                                    .background(Color(UIColor.systemGray))
                                    .cornerRadius(10)
                                }
                                Spacer()
                                if viewModel.nextButtonVisibility {
                                    Button(action: {
                                        scrollView.scrollTo(viewModel.currentPage[0].id, anchor: .top)
                                        viewModel.nextPage()
                                    }) {
                                        Text("Next")
                                        Image(systemName: "chevron.right")
                                    }.padding(9)
                                    .foregroundColor(.white)
                                    .background(Color(UIColor.systemGray))
                                    .cornerRadius(10)
                                }
                            }.padding([.leading, .trailing], 58).padding(.top, 9)
                        }
                    }
                    .navigationBarTitleDisplayMode(.large)
                    .navigationBarItems(leading:
                                            HStack {
                                                Image("pokeball")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 30, height: 30)
                                                Text("Pokédex")
                                                    .font(.title).bold()
                                            }.onTapGesture {
                                                withAnimation {
                                                    scrollView.scrollTo(viewModel.currentPage[0].id, anchor: .top)
                                                }
                                            }
                                            .frame(width: geometry.size.width, alignment: .center)
                    )
                }
            }
        }
    }
}
