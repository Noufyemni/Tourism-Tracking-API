//
//  File.swift
//  
//
//  Created by Nouf on 25/02/2024.
//

import Foundation
import Vapor
import Fluent

struct DestinationController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let destinations = routes.grouped("destinations")
        destinations.get(use: index)
        destinations.post(use: post)
        destinations.put(use: update)
        destinations.delete(":id", use: delete)
        destinations.get(":id", use: getDestinationByID)
    }
    
    func index(req: Request) async throws -> [Destination] {
        try await Destination.query(on: req.db).all()
    }
    
    func getDestinationByID(req: Request) async throws -> Destination {
        let destination = try await Destination.find(req.parameters.get("id"), on: req.db)
        guard let destination else {
            throw Abort(.notFound)
        }
        return destination
    }
    
    func post(req: Request) async throws -> Destination {
        let destination = try req.content.decode(Destination.self)
        try await destination.create(on: req.db)
        return destination
    }
    
    func update(req: Request) async throws -> Destination {
        let newDestination = try req.content.decode(Destination.self)
        let destinationToUpdate = try await Destination.find(newDestination.id, on: req.db)
        guard let destinationToUpdate else { throw Abort(.notFound) }
        destinationToUpdate.tourName = newDestination.tourName
        destinationToUpdate.location = newDestination.location
        destinationToUpdate.tourInfo = newDestination.tourInfo
        try await destinationToUpdate.save(on: req.db)
        return destinationToUpdate
    }
    
    func delete(req: Request) async throws -> Destination {
        let destination = try await Destination.find(req.parameters.get("id"), on: req.db)
        guard let destination else { throw Abort(.notFound) }
        try await destination.delete(on: req.db)
        return destination
    }
}
