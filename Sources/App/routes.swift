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

    app.middleware.use(ErrorMiddleware())

    app.get { req async in
        "Server is working!"
    }

    let gitHubWebhookController = GitHubWebhookController()
    app.post("github-webhook", use: gitHubWebhookController.handle)


    let teamsController = TeamsController()
    app.get("teams", use: teamsController.getTeams)
    app.get("teams", ":teamId", use: teamsController.getTeamDetail)
    app.post("team", ":accountId", use: teamsController.createTeam)
    app.get("team", use: teamsController.getTeamCreationRequests)

}
