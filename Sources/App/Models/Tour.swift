//
//  File.swift
//  
//
//  Created by Nouf on 25/02/2024.
//

import Foundation
import Vapor
import Fluent

final class Tour: Model, Content {
    static let schema: String = "tours"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "tours_name")
    var tourName: String
    
    init() { }
    
    init(id: UUID? = nil, tourName: String) {
        self.id = id
        self.tourName = tourName
    }
}
