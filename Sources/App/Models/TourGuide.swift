//
//  File.swift
//  
//
//  Created by Nouf on 25/02/2024.
//


import Foundation
import Fluent
import Vapor

final class TourGuide: Model, Content {
    
    static let schema = "tour_guides"
    
    @ID(key: .id) // primary key
    var id: UUID?
    
    @Field(key: "guide_name")
    var name: String
    
   // Change the type to match your requirements
    
    init() {}
    
    init(id: UUID? = nil, name: String, contact_info: String) { // Add the "rate" parameter to the initializer
        self.id = id
        self.name = name
      // Initialize the "rate" property
    }
    
}
