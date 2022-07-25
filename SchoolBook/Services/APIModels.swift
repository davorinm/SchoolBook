//
//  APIModels.swift
//  SchoolBook
//
//  Created by Davorin Madaric on 22/07/2022.
//

import Foundation

struct Teacher: Decodable {
    let id: Int
    let name: String
    let school_id: Int
    let subject: String
    let image_url: String
    var details: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case school_id
        case subject = "class"
        case image_url
    }
}

struct TeacherDetails: Decodable {
    let id: Int
    let description: String
}

struct Student: Decodable {
    let id: Int
    let name: String
    let school_id: Int
    let grade: Int
}

struct StudentDetails: Decodable {
    let details: String
}

struct School: Decodable {
    let id: Int
    let name: String
    let image_url: String
}
