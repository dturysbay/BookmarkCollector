//
//  MainView.swift
//  BookmarkApp
//
//  Created by Dinmukhambet Turysbay on 20.04.2023.
//

import SwiftUI

struct MainView: View {
    @State var addBookmarkSheetShown: Bool = false
    @State var bookmarkTitles: [String]
    @State var bookmarkLinks: [String]
    @State private var showSafari: Bool = false
    
    func deleteItems(at offsets: IndexSet) {
        bookmarkTitles.remove(atOffsets: offsets)
        bookmarkLinks.remove(atOffsets: offsets)
        Bookmarks.arrayOfLinks = bookmarkLinks
        Bookmarks.arrayOfTitles = bookmarkTitles
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    init(){
        bookmarkTitles = Bookmarks.arrayOfTitles
        bookmarkLinks = Bookmarks.arrayOfLinks
    }
    
    var body: some View {
        VStack {
            Spacer()
            if(bookmarkTitles.isEmpty && bookmarkLinks.isEmpty){
                Text("Save your first\n bookmark")
                    .font(.system(size: 36,weight: .bold))
                    .multilineTextAlignment(.center)

            }else{
                    List {
                        ForEach(Array(bookmarkTitles.enumerated()),id:\.offset) { index,bookmark in
                            HStack{
                                Text(bookmark)
                                Spacer()
                                Image("link_icon")
                                    .onTapGesture {
                                        if(verifyUrl(urlString: bookmarkLinks[index])){
                                            showSafari.toggle()
                                        }
                                    }
                                    .fullScreenCover(isPresented: $showSafari, content: {
                                            SFSafariViewWrapper(url: URL(string: bookmarkLinks[index])!)
                                    })
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(.plain)
                .navigationTitle("List")
            }
            Spacer()
            Button {
                addBookmarkSheetShown.toggle()
            } label: {
                CustomBlackButtonBackground(button_text: "Add bookmark")
            }
            .padding(.horizontal,16)
            .padding(.bottom,50)
        }
        .background(Color(red: 0.949, green: 0.949, blue: 0.933))
        .navigationTitle("Bookmark App")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $addBookmarkSheetShown) {
            AddBookmarkSheetView(
                addBookmarkSheetShown: $addBookmarkSheetShown,
                bookmarkTitles: $bookmarkTitles,
                bookmarkLinks: $bookmarkLinks
            )
                .presentationDetents([.fraction(0.43)])
                .presentationDragIndicator(.hidden)
        }
    }
}

struct AddBookmarkSheetView: View{
    @State var getBookmarkTitle: String = ""
    @State var getBookmarkLink: String = ""
    @Binding var addBookmarkSheetShown: Bool
    @Binding var bookmarkTitles: [String]
    @Binding var bookmarkLinks: [String]
    
    var body: some View{
        VStack{
            HStack {
                Spacer()
                Image("x")
                    .onTapGesture {
                        addBookmarkSheetShown.toggle()
                    }
            }
            .padding(.vertical,22)

            HStack {
                Text("Title")
                    .font(.system(size: 17))
                Spacer()
            }
            .padding(.bottom,12)

            CustomTextField(field: $getBookmarkTitle, title: "Bookmark title")

            HStack {
                Text("Link")
                    .font(.system(size: 17))
                Spacer()
            }
            .padding(.top,16)
            .padding(.bottom,12)

            CustomTextField(field: $getBookmarkLink, title: "Bookmark link (URL) include https://www.")
                .padding(.bottom,24)

            Button(action:{
                if(!getBookmarkTitle.isEmpty && !getBookmarkLink.isEmpty){
                    
                    bookmarkTitles.append(getBookmarkTitle.lowercased())
                    bookmarkLinks.append(getBookmarkLink.lowercased())
                    Bookmarks.arrayOfTitles.append(getBookmarkTitle)
                    Bookmarks.arrayOfLinks.append(getBookmarkLink)
                
                    addBookmarkSheetShown.toggle()
                }
            }) {
                CustomBlackButtonBackground(button_text: "Save")
            }
            .padding(.bottom,50)
        }
        .padding(.horizontal,16)
        .padding(.top,22)
        .interactiveDismissDisabled(addBookmarkSheetShown)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
