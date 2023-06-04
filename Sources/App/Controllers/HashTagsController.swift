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
                  "type": "project",
                  "name": "Backend",
                  "count": 999
                },
                {
                  "type": "project",
                  "name": "iOS",
                  "count": 611,
                  "subscribing": true
                },
                {
                  "type": "project",
                  "name": "Android",
                  "count": 576,
                  "subscribing": true
                },
                {
                  "type": "project",
                  "name": "Flutter",
                  "count": 321,
                  "subscribing": false
                },
                {
                  "type": "study",
                  "name": "알고리즘",
                  "count": 304,
                  "subscribing": false
                },
                {
                  "type": "study",
                  "name": "Figma",
                  "count": 698,
                  "subscribing": true
                }
              ]
            }
            """
        return data
    }

}

