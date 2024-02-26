import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    //connection with Database
    app.databases.use(.postgres(hostname: "localhost",username: "postgres",password: "",database: "tourism"), as: .psql)
    
    
    
    
app.migrations.add(CreateTourGuide())
app.migrations.add(CreateTours())
app.migrations.add(CreateDestination())
    
//    try await app.autoMigrate()
//    app.migrations.add(neighborhoodCreationMigration())
//    try await app.autoMigrate()
    // register routes
    try routes(app)
}
