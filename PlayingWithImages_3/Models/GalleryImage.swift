//
//  GalleryImage.swift
//  PlayingWithImages_3
//
//  Created by Borna Beakovic on 30/08/2019.
//  Copyright © 2019 MobiLab. All rights reserved.
//

import Foundation

struct GalleryImage: Codable {
    
    let link: String
    let isAlbum: Bool
    let description: String //add this again and try
    
    private enum CodingKeys : String, CodingKey {
        case isAlbum = "is_album"
        case link = "link"
        case description = "description" //add this again and try
    }
}
