import Vapor

func routes(_ app: Application) throws {

    app.middleware.use(ErrorMiddleware())

    app.get { req async in
        "Server is working!"
    }

    let teamsController = TeamsController()
    app.get("teams", use: teamsController.getTeams)
    app.get("teams", ":teamId", use: teamsController.getTeamDetail)
    app.get("teams", "hashtag", use: teamsController.getHashtag)
    app.get("teams", "hashtag", use: teamsController.getHashtag)
    app.get("teams", use: teamsController.getTeamCreationRequests)
    app.post("teams", ":accountId", use: teamsController.createTeam)

    let hashtagsController = HashTagsController()
    app.get("hashtags", use: hashtagsController.getHashtags)

    let mySubscriptionController = MySubscriptionController()
    app.get("mySubscription", "notifications", use: mySubscriptionController.getNotifications)
    app.get("mySubscription", "hashtags", use: mySubscriptionController.getNotifications)

    let myWishTeamController = MyWishTeamController()
    app.get("myWishTeam", use: myWishTeamController.getMyWishTeam)

    let chatsController = ChatsController()
    app.get("chats", use: chatsController.getChats)
    app.get("chats", ":chatId", use: chatsController.getChatsDetail)
}
