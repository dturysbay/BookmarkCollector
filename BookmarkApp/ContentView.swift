//
//  ContentView.swift
//  BookmarkApp
//
//  Created by Dinmukhambet Turysbay on 04.04.2023.
//

import SwiftUI

struct ContentView: View {
     @AppStorage(StorageStates.isOnboardingSeen.rawValue) var isOnboarding: Bool = true

    var body: some View{
        NavigationView {
            VStack{
                if isOnboarding{
                    WelcomeView()
                } else {
                    MainView()
                        .background(Color(red: 0.949, green: 0.949, blue: 0.933))
                }
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
