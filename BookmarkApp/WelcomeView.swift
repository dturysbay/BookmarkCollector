//
//  WelcomeView.swift
//  BookmarkApp
//
//  Created by Dinmukhambet Turysbay on 18.04.2023.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack{
            Image("bookmarkapp-background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Text("Save all interesting links in one app")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 40,weight: .bold))
                    .frame(width: 358)
                    .padding(.bottom,24)
                Button(action: {
                    defaults.set(false, forKey: StorageStates.isOnboardingSeen.rawValue)
                }){
                    CustomBlackButtonBackground(button_text: "Let`s start collecting",background_color: .white,foreground_color: .black)
                        .padding(.horizontal,16)
                }
                .padding(.bottom,50)
                
            }
            
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
