//
//  Recipe.swift
//  FetchTakeHome
//
//  Created by Oren Leavitt on 3/30/25.
//

import Foundation

/// Represents a single recipe in the list of recipes returned in the API response
struct Recipe: Decodable, Sendable {
    let uuid: UUID

    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let youTubeUrl: String?

    enum CodingKeys: String, CodingKey {
        case uuid
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case youTubeUrl = "youtube_url"
    }

#if DEBUG
    static let sample = Recipe(
        uuid: UUID(),
        cuisine: "TexMex",
        name: "Chimichanga",
        photoUrlLarge: nil,
        photoUrlSmall: nil,
        sourceUrl: nil,
        youTubeUrl: nil)
#endif
}

/// Hashable id for List view
extension Recipe: Hashable {
    var id: UUID {
        uuid
    }
}
