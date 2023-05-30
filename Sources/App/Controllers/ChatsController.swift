//
//  File.swift
//  
//
//  Created by Heonjin Ha on 2023/05/30.
//

import Vapor

final class ChatsController {

    /// **대화중인 대화방 목록**
    /// - Parameters:
    ///   - METHOD: GET /chats
    ///   - 입력: X
    ///   - 출력: 대화중인 대화방 목록
    ///
    func getChats(_ req: Request) throws -> String {

        let data = """
            {
              result: "SUCCESS",
              chatRooms: [
                { roomId: 0, relatedTeamId: 123, relatedTeamSubject: "제목", recentMessage: "가장 최근 메시지" },
                { roomId: 1, relatedTeamId: 123, relatedTeamSubject: "제목", recentMessage: "가장 최근 메시지" },
              ]
            }
            """
        return data
    }

    /// **대화 내용 조회**
    /// - Parameters:
    ///   - METHOD: GET /chats/{chatId}
    ///   - 입력: X
    ///   - 출력: 대화 내용
    func getChatsDetail(_ req: Request) throws -> String {

        // Get the accountId from the request
        guard let chatIdString = req.parameters.get("chatId"),
              let chatId = Int(chatIdString) else {
            throw Abort(.badRequest, reason: "유효하지 않은 chatId입니다")
        }

        switch chatId {
        case 0:
            return """
            {
              result: "SUCCESS",
              chats: [
                { chatId: 0, userId: "id1", message: "메시지", createdAt: "2023-05-30 09:20:45" },
                { chatId: 0, userId: "id2", message: "메시지", createdAt: "2023-05-30 09:21:45" },
              ]
            }
            """
        case 1:
            return """
            {
              result: "SUCCESS",
              chats: [
                { chatId: 1, userId: "id1", message: "메시지", createdAt: "yyyy-MM-dd HH:mm:ss" },
                { chatId: 1, userId: "id2", message: "메시지", createdAt: "yyyy-MM-dd HH:mm:ss" },
              ]
            }
            """
        default:
            return """
                    { result: "ERROR", description: "" }
                    """
        }


    }



}

struct ChatDetail: Content {
    let result: String
    let chats: [Chats]
}

struct Chats: Content {
    let chatId: Int
    let userId: String
    let message: String
    let createAt: String
}


