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
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .top){
                VStack {
                    HStack (alignment: .center, spacing: 15){
                        Text(pokemon.name.capitalized)
                            .font(.largeTitle).bold()
                            .foregroundColor(.black)
                            .padding(.top, 18)
                        Text("#"+String(format: "%03d", pokemon.id))
                            .italic()
                            .font(.subheadline)
                            .foregroundColor(Color(red: 111/255, green: 111/255, blue: 111/255))
                            .padding(.top, 18)
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Height")
                                .font(.body)
                                .foregroundColor(.gray)
                                .padding([.top, .leading], 15)
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
                    }
                }
                .background(Color(red: 210/255, green: 210/255, blue: 210/255))
                .clipShape(roundedPage())
                .padding(.top, 265)
                
                RemoteImageView(url: URL(string: (pokemon.sprites.other?.officialArtwork.frontDefault)!)!)
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.top, 100)
            }
        }.navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.mode.wrappedValue.dismiss()
        }, label: {
            HStack {
                Image(systemName: "chevron.backward")
                    .frame(width: 10, height: 20)
                    .foregroundColor(Color(UIColor.systemBlue))
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
