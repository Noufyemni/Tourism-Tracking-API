//
//  File.swift
//  
//
//  Created by Nouf on 25/02/2024.
//


import Foundation
import Fluent
import FluentPostgresDriver

struct CreateDestination: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("destinations")
            .id()
            .field("tour_name", .string, .required)
            .field("location", .string, .required)
            .field("tour_info", .string, .required)
            .field("tour_id", .uuid, .references("tours", "id"))
            .field("guide_id", .uuid, .references("tour_guides", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("destinations").delete()
    }
}
