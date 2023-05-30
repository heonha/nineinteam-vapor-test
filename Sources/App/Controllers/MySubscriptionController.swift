//
//  MySubscriptionController.swift
//  
//
//  Created by Heonjin Ha on 2023/05/30.
//

import Vapor

final class MySubscriptionController {

    /// **내 구독 알림 수신 목록**
    /// - Parameters:
    ///   - METHOD: GET /mySubscription/notifications
    ///   - 입력: X
    ///   - 출력: 내  구독 알림 목록
    func getNotifications(_ req: Request) throws -> String {
        let data = """
            {
              result: "SUCCESS",
              notifications: [
                { teamId: 0, subject: "제목", subscribingTags: ["a"], lastModified: "2023-05-30 11:11:22" },
                { teamId: 1, subject: "제목", subscribingTags: ["b"], lastModified: "2023-05-30 11:11:23" }
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

