//
//  File.swift
//  
//
//  Created by Nouf on 25/02/2024.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateTourGuide: Migration {
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database.schema("tour_guides")
            .id()
           // .field("age", .int, .identifier(auto: true))
            .field("guide_name", .string)

           // .field("name", .string, .identifier(auto: true))
           // .field("name", .string, .
             //  define "rate" column
            .create()
    }
    
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database.schema("tour_guides").delete()
    }
}
