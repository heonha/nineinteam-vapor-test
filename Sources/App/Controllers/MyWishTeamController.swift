//
//  File.swift
//  
//
//  Created by Heonjin Ha on 2023/05/30.
//

import Vapor

final class MyWishTeamController {

    /// **내 찜 리스트 조회**
    /// - Parameters:
    ///   - METHOD: GET /myWishTeam
    ///   - 입력: X
    ///   - 출력: 내 찜 모집글 목록
    func getMyWishTeam(_ req: Request) throws -> String {
        let data = """
            {
              "result": "SUCCESS",
              "teams": [
                {
                  "teamId": 0,
                  "leader": "김진홍",
                  "subject": "개발자를 모집합니다",
                  "hashtags": ["개발", "프로그래밍"],
                  "lastModified": "2023-05-11 01:02:12"
                },
                {
                  "teamId": 1,
                  "leader": "조상현",
                  "subject": "디자이너를 모집합니다",
                  "hashtags": ["UI", "Figma"],
                  "lastModified": "2023-03-15 05:32:33"
                }
              ]
            }
            """
        return data
    }

    // TODO: POST 해시태그 구독
    /// **해시태그 구독**
    /// - Parameters:
    ///   - METHOD: POST /mySubscription/hashtags
    ///   - 입력: 구독할 해시태그
    ///     - { tagToSubscribe: 1 } // 해시태그 고유번호
    ///   - 출력: 내  구독 알림 목록
    ///     - { result: "SUCCESS" }
    ///     - { result: "ERROR", description: "" }

}

