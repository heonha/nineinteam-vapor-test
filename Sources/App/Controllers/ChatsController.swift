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
              "result": "SUCCESS",
              "chatRooms": [
                {
                  "roomId": 0,
                  "relatedTeamId": 123,
                  "relatedTeamSubject": "AI 기반 음성인식 프로젝트",
                  "recentMessage": "프로젝트 팀원을 찾고 있습니다. 관심 있으신 분은 연락주세요!"
                },
                {
                  "roomId": 1,
                  "relatedTeamId": 456,
                  "relatedTeamSubject": "스마트 홈 자동화 프로젝트",
                  "recentMessage": "프로젝트 팀에서는 백엔드 개발자와 IoT 전문가를 모집 중입니다."
                },
                {
                  "roomId": 2,
                  "relatedTeamId": 789,
                  "relatedTeamSubject": "영화 추천 알고리즘 개발 프로젝트",
                  "recentMessage": "프로젝트 팀원을 모집하고 있습니다. 데이터 분석 및 머신러닝 경험이 있는 분들 환영합니다!"
                },
                {
                  "roomId": 3,
                  "relatedTeamId": 987,
                  "relatedTeamSubject": "블록체인 기반 보험 서비스 프로젝트",
                  "recentMessage": "프로젝트 팀에서는 스마트 계약 개발자와 보험 업계 경험이 있는 분을 찾고 있습니다."
                }
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
              "result": "SUCCESS",
              "chats": [
                {
                  "roomId": 0,
                  "userId": "user123",
                  "message": "안녕하세요! AI 기반 음성인식 프로젝트 팀에 관심이 있어서 참여하고 싶습니다.",
                  "createdAt": "2023-05-30 09:20:45"
                },
                {
                  "roomId": 0,
                  "userId": "admin456",
                  "message": "안녕하세요! 환영합니다. 저희 프로젝트 팀에 참여하실 수 있습니다. 자기 소개와 관련된 기술 경험을 알려주세요.",
                  "createdAt": "2023-05-30 09:21:45"
                },
                {
                  "roomId": 0,
                  "userId": "user123",
                  "message": "안녕하세요! 저는 음성인식 기술에 대한 연구 경험이 있고 Python과 TensorFlow를 사용한 경험이 있습니다.",
                  "createdAt": "2023-05-30 09:22:15"
                }
              ]
            }
            """
        case 1:
            return """
            {
              "result": "SUCCESS",
              "chats": [
                {
                  "roomId": 1,
                  "userId": "user789",
                  "message": "안녕하세요! 스마트 홈 자동화 프로젝트에 흥미가 있어서 참여하고 싶습니다.",
                  "createdAt": "2023-05-30 10:00:30"
                },
                {
                  "roomId": 1,
                  "userId": "admin456",
                  "message": "반갑습니다! 스마트 홈 자동화 프로젝트 팀에 참여하실 수 있습니다. 어떤 분야에서 기여하실 수 있나요?",
                  "createdAt": "2023-05-30 10:01:15"
                }
              ]
            }
            """
        case 2:
            return """
            {
              "result": "SUCCESS",
              "chats": [
                {
                  "roomId": 2,
                  "userId": "user987",
                  "message": "안녕하세요! 영화 추천 알고리즘 개발 프로젝트에 관심이 있어서 참여하고 싶습니다.",
                  "createdAt": "2023-05-30 11:30:50"
                },
                {
                  "roomId": 2,
                  "userId": "admin123",
                  "message": "반갑습니다! 영화 추천 알고리즘 개발 프로젝트 팀에서는 어떤 기술 스택을 사용하고 있나요?",
                  "createdAt": "2023-05-30 11:31:25"
                }
              ]
            }
            """
        case 3:
            return """
            {
              "result": "SUCCESS",
              "chats": [
                {
                  "roomId": 3,
                  "userId": "user456",
                  "message": "안녕하세요! 블록체인 기반 보험 서비스 프로젝트에 참여하고 싶습니다.",
                  "createdAt": "2023-05-30 14:10:20"
                },
                {
                  "roomId": 3,
                  "userId": "admin789",
                  "message": "반갑습니다! 블록체인 기반 보험 서비스 프로젝트 팀에서는 스마트 계약을 개발하는 데 어떤 기술을 활용하고 있나요?",
                  "createdAt": "2023-05-30 14:11:05"
                }
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


