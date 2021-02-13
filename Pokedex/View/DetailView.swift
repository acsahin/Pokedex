//
//  DetailView.swift
//  Pokedex
//
//  Created by ACS on 10.02.2021.
//

import SwURL
import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    let pokemon: Pokemon
    
    var viewModel = DetailViewModel()
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .top){
                VStack {
                    HStack (alignment: .top){
                        VStack (alignment: .leading){
                            Text("Height")
                                .font(.body)
                                .foregroundColor(.gray)
                                .padding(.leading, 15)
                            Text(String(Double(pokemon.height)/10)+" m")
                                .font(.body)
                                .bold()
                                .foregroundColor(.black)
                                .padding(.leading, 21)
                            Text("Weight")
                                .font(.body)
                                .foregroundColor(.gray)
                                .padding([.top, .leading], 15)
                            Text(String(Double(pokemon.weight)/10)+" kg")
                                .font(.body)
                                .bold()
                                .foregroundColor(.black)
                                .padding(.leading, 21)
                        }
                        Spacer()
                        VStack (alignment: .leading){
                            Text("General Power")
                                .font(.body)
                                .foregroundColor(.gray)
                            HStack {
                                Image(systemName: "cross.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.green)
                                Text(String(pokemon.base_experience))
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(Color.black)
                            }
                        }.padding(.trailing, 75)
                    }.padding(.top, 30)
                    VStack(alignment: .leading, spacing: 25) {
                        Text("Stats")
                            .font(.system(size: 22))
                            .bold()
                            .foregroundColor(.gray)
                        HStack(alignment: .top, spacing: 15) {
                            ForEach(pokemon.stats, id: \.self.stat.name) {stat in
                                VStack {
                                    Text(String(stat.base_stat))
                                        .foregroundColor(.black)
                                    ZStack (alignment: .bottom){
                                        Rectangle()
                                            .fill(Color.white)
                                            .frame(height: 200)
                                            .cornerRadius(10)
                                        Rectangle()
                                            .fill(Color.blue)
                                            .frame(height: CGFloat(stat.base_stat))
                                            .cornerRadius(10)
                                    }
                                    Text(viewModel.makeTitle(name: stat.stat.name))
                                        .bold()
                                        .lineLimit(nil)
                                        .frame(width: 40)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }.padding(.top, 30)
                    .padding([.leading, .trailing], 15)
                    .padding(.bottom, 160)
                }
                .background(Color("PokemonGray2"))
                .clipShape(roundedPage())
                .padding(.top, 200)
                VStack {
                    HStack (alignment: .center, spacing: 15){
                        Text(pokemon.name.capitalized)
                            .font(.largeTitle)
                            .foregroundColor(Color(UIColor.label)) //////
                        Text("#"+String(format: "%03d", pokemon.id))
                            .italic()
                            .font(.subheadline)
                            .foregroundColor(Color("PokemonGray"))
                    }
                    RemoteImageView(url: URL(string: (pokemon.sprites.other?.officialArtwork.frontDefault)!)!)
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }.padding(.top, -25)
            }
        }.navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.mode.wrappedValue.dismiss()
        }, label: {
            HStack {
                Image(systemName: "chevron.backward")
                    .frame(width: 10, height: 20)
                    .foregroundColor(Color(UIColor.label))
                Image("pokeball")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
        }))
    }
}

struct roundedPage: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 40, height: 40))
        return Path(path.cgPath)
    }
}
