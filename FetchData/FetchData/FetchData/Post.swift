//
//  Post.swift
//  FetchData
//
//  Created by admin on 31/01/25.
//

import Foundation

struct Post:Codable,Identifiable{
    let id:Int
    let title:String
    let body:String
}
