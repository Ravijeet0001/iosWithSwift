//
//  APIService.swift
//  FetchData
//
//  Created by admin on 31/01/25.
//

import Foundation

class APIService: ObservableObject {
    @Published var posts: [Post] = []  // Store fetched data

    func fetchPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decodedPosts = try JSONDecoder().decode([Post].self, from: data)
                DispatchQueue.main.async {
                    self.posts = decodedPosts
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
