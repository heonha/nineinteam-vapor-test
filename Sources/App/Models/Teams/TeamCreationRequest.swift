//
//  TeamCreationRequest.swift
//  
//
//  Created by Heonjin Ha on 2023/05/17.
//

import Vapor

struct TeamCreationRequest: Content {
    var subjectType: String
    var subject: String
    var types: [String]
    var roles: [Role]
    var content: String
    var teamTemplates: [Template]
    var openChatUrl: String
}
