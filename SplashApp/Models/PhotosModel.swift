//
//  PhotosModel.swift
//  SplashApp
//
//  Created by Baya Walid on 03/10/2022.
//

struct PhotosModel: Codable {
    var total: Int? = 0
    var total_pages: Int? = 0
    var results: [Photo]? = []
}
    
struct Photo: Codable {
    var urls: Urls?
    var id: String?
    var created_at: String?
    var updated_at: String?
    var promoted_at: String?
    var description: String?
    var alt_description: String?
}

struct Urls: Codable {
    var raw: String?
    var full: String?
    var small: String?
}
