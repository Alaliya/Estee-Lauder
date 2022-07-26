//
//  ContentView.swift
//  image gallery
//
//  Created by Алия Асхаткызы on 22.07.2022.
//

import SwiftUI

struct ContentView: View {
    private var numberOfImages = 12
    private let timer = Timer.publish(every: 3, on:.main, in: .common).autoconnect()
    @State private var currentIndex = 0
    
    func previous() {
        withAnimation {
        currentIndex = currentIndex > 0 ?
            currentIndex - 1 : numberOfImages - 1
    }
    }
    
    func next() {
        withAnimation {
        currentIndex = currentIndex <
            numberOfImages ? currentIndex + 1 : 0
        }
    }
        
    var controls: some View {
        HStack {
            Button {
               previous()
                
            } label: {
                Image(systemName: "chevron.left")
    }
            Spacer()
                .frame(width: 200)
            Button {
                next()
                
            } label: {
                Image(systemName: "chevron.right")
            }
        }.accentColor(.blue)
    }
    
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
            TabView (selection: $currentIndex){
            ForEach(0..<numberOfImages) { num in
                Image("\(num)")
                    .resizable()
                    .scaledToFill()
                    .overlay(Color.black.opacity(0.4))
                    .tag(num)
            }
        }.tabViewStyle(PageTabViewStyle())
                .clipShape(RoundedRectangle(cornerRadius:5))
                .padding()
                .frame(width: proxy.size.width, height: proxy.size.height / 3)
                .onReceive(timer, perform: { _ in
                   next()
                })
                
                controls
        }
    }
}
    }
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

