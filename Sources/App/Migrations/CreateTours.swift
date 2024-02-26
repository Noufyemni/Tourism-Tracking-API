//
//  File.swift
//  
//
//  Created by Nouf on 25/02/2024.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateTours: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("tours")
            .id()
            .field("tours_name", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("tours").delete()
    }
}
//struct CreateTourGuide: Migration {
//    func prepare(on database: Database) -> EventLoopFuture<Void> {
//        database.schema("tour_guides")
//            .id()
//            .field("guide_name", .string, .required)
//            .create()
//    }
//
//    func revert(on database: Database) -> EventLoopFuture<Void> {
//        database.schema("tour_guides").delete()
//    }
//}
