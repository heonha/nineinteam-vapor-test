//
//  File.swift
//  
//
//  Created by Heonjin Ha on 2023/05/17.
//

import Vapor

// 1. Define your data types
struct TeamDetail: Content {
    var result: String
    var subject: String
    var leaderId: Int
    var hashtags: [String]
    var roles: [Role]
    var content: String
    var applyTemplate: [Template]
    var lastModified: String
    var liked: Bool
}

struct Role: Content {
    var name: String
    var number: Int
}

struct Template: Content {
    var type: String
    var question: String
    var options: [String]?
}
