//
//  File.swift
//  
//
//  Created by Nouf on 25/02/2024.
//


import Foundation
import Vapor
import Fluent

final class Destination: Model, Content {
    static let schema: String = "destinations"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "tour_name")
    var tourName: String
    
    @Field(key: "location")
    var location: String
    
    @Field(key: "tour_info")
    var tourInfo: String
    
    @Parent(key: "tour_id")
    var tour: Tour
    
    @Parent(key: "guide_id")
    var guide: TourGuide
    
    init() { }
    
    init(id: UUID? = nil, tourName: String, location: String, tourInfo: String, tourID: UUID, guideID: UUID) {
        self.id = id
        self.tourName = tourName
        self.location = location
        self.tourInfo = tourInfo
        self.$tour.id = tourID
        self.$guide.id = guideID
    }
}
