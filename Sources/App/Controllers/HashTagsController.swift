//
//  File.swift
//  
//
//  Created by Heonjin Ha on 2023/05/30.
//

import Vapor

final class HashTagsController {

    /// **해시태그 목록**
    /// - Parameters:
    ///   - METHOD: GET /hashtags
    ///   - 입력: X
    ///   - 출력: 해시태그 목록
    func getHashtags(_ req: Request) throws -> String {
        let data = """
            {
              "result": "SUCCESS",
              "list": [
                {
                  "name": "Backend",
                  "count": 999
                },
                {
                  "name": "iOS",
                  "count": 611,
                  "subscribing": true
                },
                {
                  "name": "Android",
                  "count": 576,
                  "subscribing": true
                },
                {
                  "name": "Flutter",
                  "count": 321,
                  "subscribing": true
                },
              ]
            }
            """
        return data
    }

}

