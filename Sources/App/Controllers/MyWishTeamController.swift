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
              result: "SUCCESS",
              teams: [
                { teamId: 0, subject: "제목1", hashtags: ["aaa", "bbb"], lastModified: "2023-05-29 11:09:19" },
                { teamId: 1, subject: "제목2", hashtags: ["aaa", "ccc"], lastModified: "2023-05-30 21:09:19" }
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

