//
//  TeamsController.swift
//  
//
//  Created by Heonjin Ha on 2023/05/30.
//
// MARK: - WIKI https://github.com/9in-team/Backend/wiki/API-%EC%84%A4%EA%B3%84-%EC%B4%88%EC%95%88
//

import Vapor

final class TeamsController {
    var teamCreationRequests: [String: Detail] = [:]

    /// * 모집글 목록
    /// - GET /teams
    /// - 입력: X
    /// - 출력: 모집글 목록
    func getTeams(_ req: Request) throws -> String {
        let data = """
            {
              "result": "SUCCESS",
              "teams": [
                { "teamId": 0, "subject": "개발자를 모집합니다", "leader": "김진홍", "hashtags": ["개발", "프로그래밍"], "lastModified": "2023-05-11 01:02:12" },
                { "teamId": 1, "subject": "디자이너를 모집합니다", "leader": "조상현", "hashtags": ["UI", "Figma"], "lastModified": "2023-05-15 05:32:33" },
                { "teamId": 2, "subject": "수영 앱 같이 만드실분 구합니다.", "leader": "하헌진", "hashtags": ["UIKit", "Combine"], "lastModified": "2023-05-17 05:32:33" }
              ]
            }
            """
        return data
    }

    /// * 모집글 상세 정보
    /// - GET /teams/{teamId}
    /// - 입력: teamId
    /// - 출력: 모집글 상세 정보
    func getTeamDetail(_ req: Request) throws -> TeamDetail {
        guard let teamIdString = req.parameters.get("teamId"),
              let teamId = Int(teamIdString) else {
            throw Abort(.badRequest, reason: "유효하지 않은 teamId입니다")
        }

        var teamDetail: TeamDetail

        switch teamId {
        case 0:
            teamDetail = TeamDetail(
                result: "SUCCESS",
                subject: "개발자를 모집합니다",
                leaderId: 1234,
                hashtags: ["개발", "프로그래밍"],
                roles: [
                    Role(name: "개발자", number: 2),
                    Role(name: "QA 엔지니어", number: 1)
                ],
                content: "저희 팀에서 개발자와 QA 엔지니어를 모집합니다. 함께 멋진 서비스를 개발해보세요!",
                applyTemplate: [
                    Template(type: "text", question: "자기 소개를 부탁드립니다.", options: nil),
                    Template(type: "image", question: "이력서를 첨부해주세요.", options: nil),
                    Template(type: "radiobox", question: "프로젝트에 대한 기여를 어떻게 생각하시나요?", options: ["적극적으로 참여하겠습니다", "기여할 수 있는 부분에 집중하겠습니다", "다른 역할을 수행하고 싶습니다"])
                ],
                lastModified: "2023-05-11 01:02:12",
                liked: false
            )
        case 1:
            teamDetail = TeamDetail(
                result: "SUCCESS",
                subject: "디자이너를 모집합니다",
                leaderId: 5678,
                hashtags: ["UI", "Figma"],
                roles: [
                    Role(name: "UI 디자이너", number: 1)
                ],
                content: "우리 팀에서 UI 디자이너를 모집합니다. 다양한 프로젝트에서 창의적인 디자인을 만들어보세요!",
                applyTemplate: [
                    Template(type: "text", question: "이전 작업물을 링크로 공유해주세요.", options: nil),
                    Template(type: "image", question: "포트폴리오를 첨부해주세요.", options: nil),
                    Template(type: "radiobox", question: "팀 프로젝트에 대한 경험이 있으신가요?", options: ["네", "아니오"])
                ],
                lastModified: "2023-05-15 05:32:33",
                liked: true
            )
        case 2:
            teamDetail = TeamDetail(
                result: "SUCCESS",
                subject: "수영 앱 같이 만드실분 구합니다.",
                leaderId: 9999,
                hashtags: ["UIKit", "Combine"],
                roles: [
                    Role(name: "iOS 개발자", number: 3),
                    Role(name: "백엔드 개발자", number: 3)
                ],
                content: "이것은 더미 팀입니다. 테스트 용도로 사용됩니다.",
                applyTemplate: [],
                lastModified: "2023-05-17 05:32:33",
                liked: false
            )
        default:
            throw Abort(.notFound, reason: "팀을 찾을 수 없습니다")
        }

        return teamDetail
    }

    /// * 모집글 작성
    /// - POST /team/{accountId}
    /// - 입력: 제목, 태그, 모집 역할, 설명, 지원 양식
    /// - 출력: 모집글 목록
    /// - 출력: 결과
    func createTeam(_ req: Request) throws -> EventLoopFuture<Detail> {
        // Get the accountId from the request
        guard let accountId = req.parameters.get("accountId") else {
            throw Abort(.badRequest, reason: "Invalid accountId")
        }

        // Decode the team creation request from the request body
        do {
            let request = try req.content.decode(TeamCreationRequest.self)
            let teamId = UUID().hashValue
            let openChatUrl = request.openChatUrl
            let content = request.content
            let subject = request.subject
            let teamTemplates = request.teamTemplates
            let types = request.types
            let subjectType = request.subjectType
            let roles = request.roles

            let result = Detail(teamId: teamId, openChatUrl: openChatUrl, content: content, subject: subject, teamTemplates: teamTemplates, types: types, subjectType: subjectType, roles: roles)

            teamCreationRequests[accountId] = result

            return req.eventLoop.makeSucceededFuture(result)
        } catch {
            throw Abort(.badRequest, reason: "Invalid Request")
        }
    }

    func getTeamCreationRequests(_ req: Request) throws -> [String : Detail] {
        return teamCreationRequests
    }
}
