import Vapor

func routes(_ app: Application) throws {

    app.middleware.use(ErrorMiddleware())

    app.get { req async in
        "Server is working!"
    }

    let teamsController = TeamsController()
    app.get("teams", use: teamsController.getTeams)
    app.get("teams", ":teamId", use: teamsController.getTeamDetail)
    app.post("team", ":accountId", use: teamsController.createTeam)
    app.get("team", use: teamsController.getTeamCreationRequests)

}
