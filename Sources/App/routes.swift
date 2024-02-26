import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    try app.register(collection: TourGuideController())
    try app.register(collection: TourController())
    try app.register(collection: DestinationController())
}
