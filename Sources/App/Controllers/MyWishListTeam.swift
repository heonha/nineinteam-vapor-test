//
//  File.swift
//  
//
//  Created by Heonjin Ha on 2023/05/30.
//

import Vapor

final class MyWishListTeam {

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
        let data = """
            {
              result: "SUCCESS",
              chatRooms: [
                { roomId: 0, relatedTeamId: 123, relatedTeamSubject: "제목", recentMessage: "가장 최근 메시지" },
                { roomId: 1, relatedTeamId: 123, relatedTeamSubject: "제목", recentMessage: "가장 최근 메시지" },
              ]
            }
            { result: "ERROR", description: "" }
            """
        return data
    }



}

