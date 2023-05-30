//
//  ErrorResponse.swift
//  
//
//  Created by Heonjin Ha on 2023/05/30.
//

import Vapor

struct ErrorResponse: Content {
    var result: String
    var description: String
}
