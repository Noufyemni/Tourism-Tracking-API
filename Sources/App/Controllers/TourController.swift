
import Foundation
import Vapor
import Fluent
struct TourController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tours = routes.grouped("tours")
        tours.get(use: index)
        tours.post(use: post)
        tours.put(use: update)
        tours.delete(":id", use: delete)
        tours.get(":id", use: getTourByID)
    }
    
    func index(req: Request) async throws -> [Tour] {
        try await Tour.query(on: req.db).all()
    }
    
    func getTourByID(req: Request) async throws -> Tour {
        let tour = try await Tour.find(req.parameters.get("id"), on: req.db)
        guard let tour else {
            throw Abort(.notFound)
        }
        return tour
    }
    
    func post(req: Request) async throws -> Tour {
        let tour = try req.content.decode(Tour.self)
        try await tour.create(on: req.db)
        return tour
    }
    
    func update(req: Request) async throws -> Tour {
        let newTour = try req.content.decode(Tour.self)
        let tourToUpdate = try await Tour.find(newTour.id, on: req.db)
        guard let tourToUpdate else { throw Abort(.notFound) }
        tourToUpdate.tourName = newTour.tourName
        try await tourToUpdate.save(on: req.db)
        return tourToUpdate
    }
    
    func delete(req: Request) async throws -> Tour {
        let tour = try await Tour.find(req.parameters.get("id"), on: req.db)
        guard let tour else { throw Abort(.notFound) }
        try await tour.delete(on: req.db)
        return tour
    }
}
