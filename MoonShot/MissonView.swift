//
//  MissonView.swift
//  MoonShot
//
//  Created by Sree on 03/10/21.
//


//  First where ?

import SwiftUI

struct MissonView: View {
    struct CrewMemeber {
        let role: String
        let astronaut:  Astronaut
    }
    
    let mission: Mission
    let astronauts : [CrewMemeber]
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical){
                VStack{
                    Image(self.mission.image).resizable().scaledToFit().frame(maxWidth:geometry.size.width * 0.7)
                        .padding(.top)
                    Text("Launch Date:-\(mission.formattedLaunchDate)")
                    Text(self.mission.description)
                        .padding().layoutPriority(1)
                    
                    ForEach(self.astronauts, id:\.role){ crewMember in
                        NavigationLink(destination:AstronautView(astronaut: crewMember.astronaut)){
                        HStack{
                            Image(crewMember.astronaut.id).resizable().frame(width: 83, height: 60).clipShape(Capsule()).overlay(Capsule().stroke(Color.primary,lineWidth: 1))
                            VStack(alignment:.leading){
                                Text(crewMember.astronaut.name).font(.headline)
                                Text(crewMember.role).foregroundColor(.secondary)
                            }
                            Spacer()
                        }.padding(.horizontal)
                        }.buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }.navigationBarTitle(Text(mission.displayName),displayMode: .inline)
    }
    
    init(mission: Mission,astronauts: [Astronaut]) {
        self.mission = mission
        var matches = [CrewMemeber]()
        for member in mission.crew{
            if let match = astronauts.first(where: {$0.id == member.name}){
                matches.append(CrewMemeber(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        self.astronauts = matches
    }
    
}

struct MissonView_Previews: PreviewProvider {
    static let missions :  [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissonView(mission: missions[1],astronauts: astronauts)
    }
}
