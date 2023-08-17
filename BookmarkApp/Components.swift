//
//  Components.swift
//  BookmarkApp
//
//  Created by Dinmukhambet Turysbay on 20.04.2023.
//

import SwiftUI

struct CustomBlackButtonBackground: View {
    let button_text: String
    let background_color: Color
    let foreground_color: Color
    init(button_text: String, background_color: Color = .black,foreground_color: Color = .white) {
        self.button_text = button_text
        self.background_color = background_color
        self.foreground_color = foreground_color
    }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16,style: .continuous)
                .fill(background_color)
                .frame(height: 58)
            
            Text(button_text)
                .foregroundColor(foreground_color)
                .font(.system(size: 16))
        }
    }
}

struct CustomTextField: View {
    @Binding var field: String
    let title: String
    
    var body: some View{
        TextField(title, text: $field)
            .padding(.horizontal,11)
            .padding(.leading)
            .background(RoundedRectangle(cornerRadius: 12,style: .continuous)
            .fill(Color(red: 0.949, green: 0.949, blue: 0.933))
            .frame(height: 46))
            .padding(.bottom,16)
    }
}
