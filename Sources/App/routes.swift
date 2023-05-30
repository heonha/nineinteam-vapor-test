import Vapor

func restartServer(app: Application) throws {
    // 서버 중지
    app.shutdown()

    // 서버 재시작 명령 실행
    let vaporPath = "/path/to/vapor"  // Vapor 실행 파일 경로
    let arguments = ["run"]  // Vapor 명령 인수
    let process = Process()
    process.executableURL = URL(fileURLWithPath: vaporPath)
    process.arguments = arguments

    do {
        try process.run()
    } catch {
        // 서버 재시작 실패
        print("Failed to restart server: \(error)")
    }
}


func routes(_ app: Application) throws {
    
    app.get { req async in
        "It works!"
    }

    let gitHubWebhookController = GitHubWebhookController()
    app.post("github-webhook", use: gitHubWebhookController.handle)

    // MARK: - Github WebHook
    app.post("github-webhook") { req -> EventLoopFuture<Response> in
        // 웹훅 이벤트 처리 로직을 구현합니다.
        // req.body에서 웹훅 데이터를 추출하고, 필요한 작업을 수행합니다.

        // Secret 키 검증 로직
        guard let secretKey = Environment.get("SECRET_TOKEN") else {
            throw Abort(.internalServerError, reason: "No SECRET_TOKEN in environment")
        }
        guard let signature = req.headers.first(name: "X-Hub-Signature-256"),
              let payload = req.body.string else {
            throw Abort(.unauthorized, reason: "Signature or Payload missing")
        }

        do {
            let isVerified = try verifySignature(payload: payload, secretKey: secretKey, signature: signature)
            guard isVerified else {
                throw Abort(.unauthorized, reason: "Signature did not match")
            }
        } catch let error {
            return req.eventLoop.makeFailedFuture(error)
        }

        // 웹훅 이벤트 처리 후 서버 재시작
        do {
            try restartServer(app: app)
        } catch {
            // 서버 재시작 실패
            return req.eventLoop.makeFailedFuture(error)
        }

        // 응답 생성
        let responseJSON: [String: String] = [
            "content_type": "json",
            "insecure_ssl": "0",
            "secret": "",
            "url": "https://example.com/webhook"
        ]
        let response = Response(status: .ok, headers: HTTPHeaders([("Content-Type", "application/json")]))
        try response.content.encode(responseJSON, as: .json)
        return req.eventLoop.makeSucceededFuture(response)
    }

    // 4. Register the middleware
    app.middleware.use(ErrorMiddleware())
    // 5. Throw error in route
    app.get("teams") { req -> String in
        if false { // Replace with your actual condition
            throw AppError(description: "Something went wrong")
        } else {
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
    }

    // 엔드포인트 구현
    app.get("teams", ":teamId") { req -> TeamDetail in
        // 요청에서 teamId 가져오기
        guard let teamIdString = req.parameters.get("teamId"),
              let teamId = Int(teamIdString) else {
            throw Abort(.badRequest, reason: "유효하지 않은 teamId입니다")
        }

        // 데이터베이스나 다른 저장소에서 팀 상세 정보 가져오기
        // 여기서는 더미 데이터를 사용합니다
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

    var teamCreationRequests: [String: Detail] = [:]

    // Implement the POST endpoint
    app.post("team", ":accountId") { req -> Detail in
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

            return result
        } catch {
            throw Abort(.badRequest, reason: "Invalid Request")
        }
    }

    app.get("team") { req -> [String : Detail] in
        // Return the array of team creation requests
        return teamCreationRequests
    }





}


// 1. Custom Error Type
struct AppError: Error {
    var description: String
}

// 2. Custom Error Response
struct ErrorResponse: Content {
    var result: String
    var description: String
}

// 3. Custom Error Middleware
struct ErrorMiddleware: Middleware {
    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        next.respond(to: request).flatMapAlways { result in
            switch result {
            case .success(let response):
                return request.eventLoop.future(response)
            case .failure(let error):
                let status: HTTPResponseStatus
                let errorMessage: String

                if let appError = error as? AppError {
                    status = .badRequest
                    errorMessage = appError.description
                } else {
                    status = .internalServerError
                    errorMessage = "Internal server error"
                }

                let errorResponse = ErrorResponse(result: "ERROR", description: errorMessage)
                let errorBody = try? JSONEncoder().encode(errorResponse)

                return request.eventLoop.future(
                    Response(status: status, body: .init(data: errorBody ?? Data()))
                )
            }
        }
    }
}

// 1. Define your data types
struct TeamCreationRequest: Content {
    var subjectType: String
    var subject: String
    var types: [String]
    var roles: [Role]
    var content: String
    var teamTemplates: [Template]
    var openChatUrl: String
}

struct Detail: Content {
    let teamId: Int
    let openChatUrl: String
    let content: String
    let subject: String
    let teamTemplates: [Template]
    let types: [String]
    let subjectType: String
    let roles: [Role]
}
