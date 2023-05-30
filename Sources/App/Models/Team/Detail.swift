//
//  Detail.swift
//  
//
//  Created by Heonjin Ha on 2023/05/30.
//

import Vapor

struct Detail: Content {
    let teamId: Int
    let openChatUrl: String
    let content: String
    let subject: String
    let teamTemplates: [Template]
    let types: [String]
    let subjectType: String
    let roles: [Role]
}
