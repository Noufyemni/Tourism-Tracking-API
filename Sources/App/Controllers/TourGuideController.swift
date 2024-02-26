import Foundation
import Vapor
import Fluent

struct TourGuideController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tourGuides = routes.grouped("tour_guides")
        tourGuides.get(use: index)
        tourGuides.post(use: post)
        tourGuides.put(use: update)
        tourGuides.delete(":id", use: delete)
        tourGuides.get(":id", use: getTourGuideByID)
    }
    
    func index(req: Request) async throws -> [TourGuide] {
        try await TourGuide.query(on: req.db).all()
    }
    
    func getTourGuideByID(req: Request) async throws -> TourGuide {
        let tourGuide = try await TourGuide.find(req.parameters.get("id"), on: req.db)
        guard let tourGuide else {
            throw Abort(.notFound)
        }
        return tourGuide
    }
    
    func post(req: Request) async throws -> TourGuide {
        let tourGuide = try req.content.decode(TourGuide.self)
        try await tourGuide.create(on: req.db)
        return tourGuide
    }
    
    func update(req: Request) async throws -> TourGuide {
        let newTourGuide = try req.content.decode(TourGuide.self)
        let tourGuideToUpdate = try await TourGuide.find(newTourGuide.id, on: req.db)
        guard let tourGuideToUpdate else { throw Abort(.notFound) }
        tourGuideToUpdate.name = newTourGuide.name // Use the correct property name here
        try await tourGuideToUpdate.save(on: req.db)
        return tourGuideToUpdate
    }
    
    func delete(req: Request) async throws -> TourGuide {
        let tourGuide = try await TourGuide.find(req.parameters.get("id"), on: req.db)
        guard let tourGuide else { throw Abort(.notFound) }
        try await tourGuide.delete(on: req.db)
        return tourGuide
    }
}


