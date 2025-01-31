//
//  ContentView.swift
//  FetchData
//
//  Created by admin on 31/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var apiService = APIService()  // Instance of APIService

    var body: some View {
        NavigationView {
            List(apiService.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Rectangle().frame(height: 20).background(Color(.blue))                }
                
            }
            .navigationTitle("Posts")
            .onAppear {
                apiService.fetchPosts()  // Fetch data when the view appears
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
