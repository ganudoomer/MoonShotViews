//
//  AstronautView.swift
//  MoonShot
//
//  Created by Sree on 03/10/21.
//

import SwiftUI

struct AstronautView: View {
    let  astronaut: Astronaut
    let  astronauts: [Astronaut]
    var missions: [Mission]
     var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical ){
                VStack{
                    Image(self.astronaut.id).resizable().scaledToFit().frame(width: geometry.size.width)
                    Spacer()
                    Spacer()
                    HStack{
                    ForEach(self.missions,id:\.id){mission in
                        NavigationLink(destination:MissonView(mission: mission,astronauts: astronauts)){
                        HStack{
                            Image(mission.image).resizable().frame(width: 73, height: 73).clipShape(Capsule()).overlay(Capsule().stroke(Color.primary,lineWidth: 1))
                            VStack(alignment:.leading){
                                Text(mission.displayName).font(.headline)
                                
                            }
                            Spacer()
                            
                        }.padding(.horizontal)
                        }
                    }
                    }
                    Text(self.astronaut.description).padding().layoutPriority(1)
                   
                }
            }
        }.navigationBarTitle(Text(astronaut.name),displayMode: .inline)
    }
        
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        var matches = [Mission]()
        let missions: [Mission] = Bundle.main.decode("missions.json")
        let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
        self.astronauts = astronauts
        for mission in missions{
            for crew in mission.crew {
                if(crew.name == astronaut.id){
                    matches.append(mission)
                }
            }
        }
        self.missions = matches
    }




}

struct AstronautView_Previews: PreviewProvider {
    static var astronauts: [Astronaut] =  Bundle.main.decode("astronauts.json")
 
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
