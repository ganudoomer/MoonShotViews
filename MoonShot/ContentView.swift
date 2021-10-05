//
//  ContentView.swift
//  MoonShot
//
//  Created by Sree on 03/10/21.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State var isMission = true
    var body: some View {
        NavigationView {
            if(isMission){
            List(missions){ mission in
                NavigationLink(destination:MissonView(mission: mission,astronauts: astronauts)){
                    Image(mission.image).resizable().scaledToFit().frame(width: 44, height: 44)
                    VStack(alignment:.leading){
                        Text(mission.displayName).font(.headline)
                        Text(mission.formattedLaunchDate)
                    }
                }.navigationBarTitle("Moonshot").navigationBarItems(trailing:Button(action: {
                    withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)){
                        isMission.toggle()
                    }
                }) {
                    Text( "Astronauts")
                }
                )
            }
            }else{

                List(astronauts) { astronaut in
                  
                    NavigationLink(destination:AstronautView(astronaut:astronaut)){
                    Image(astronaut.id).resizable().frame(width: 44, height: 44).clipShape(Capsule()).overlay(Capsule().stroke(Color.primary,lineWidth: 1))
                    VStack(alignment:.leading){
                        Text(astronaut.name).font(.headline)
                    }
                    }
                        
                }.navigationBarTitle("Moonshot").navigationBarItems(trailing:Button(action: {
                    isMission.toggle()
                }) {
                    Text( "Missions")
                }
                )
               
                
            }
        } 
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
