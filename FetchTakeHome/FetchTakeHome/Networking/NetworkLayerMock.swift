//
//  NetworkLayerMock.swift
//  FetchTakeHome
//
//  Created by Oren Leavitt on 3/30/25.
//

import Foundation

#if DEBUG
/// Generates some local mock sample data for previewing and unit tests
actor NetworkLayerMock: NetworkLayer {
    /// Attempt to request data from given endpoint and decode JSON response as given type T
    /// - Parameters:
    ///   - request: The endpoint `URLRequest` object
    ///   - type: The object type to decode as
    /// - Returns: The decoded object if successful. Errors will be thrown if network request or decode fail.
    func fetchJsonData<T: DecodableSendable>(request: URLRequest, type: T.Type) async throws -> T {
        // Let's determine from url's last path component which sample data to load..
        guard let lastPathComponent = request.url?.lastPathComponent else {
            throw URLError(.badURL)
        }

        let jsonString: String
        switch lastPathComponent {
        case "recipes.json": jsonString = recipesJson
        case "recipes-malformed.json": jsonString = malformedJson
        case "recipes-empty.json": jsonString = emptyJson
        default: throw URLError(.badURL)
        }

        // Uncomment to execise the loading indicator
        // try await Task.sleep(for: .seconds(3))

        let data = jsonString.data(using: .utf8) ?? Data()

        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}

// swiftlint:disable line_length
// Disable line_length in this file for the long lines in the sample JSON data
let recipesJson = """
{
    "recipes": [
        {
            "cuisine": "Malaysian",
            "name": "Apam Balik",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
            "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
            "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
            "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
        },
        {
            "cuisine": "British",
            "name": "Apple & Blackberry Crumble",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
            "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
            "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
            "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
        },
        {
            "cuisine": "British",
            "name": "Apple Frangipan Tart",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg",
            "uuid": "74f6d4eb-da50-4901-94d1-deae2d8af1d1",
            "youtube_url": "https://www.youtube.com/watch?v=rp8Slv4INLk"
        }
    ]
}
"""

let malformedJson = """
{
    "recipes": [
        {
            "cuisine": "Malaysian",
            "name": "Apam Balik",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
            "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
            "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
            "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
        },
        {
            "cuisine": "British",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
            "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
            "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
            "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
        },
        {
            "cuisine": "British",
            "name": "Apple Frangipan Tart",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg",
            "uuid": "74f6d4eb-da50-4901-94d1-deae2d8af1d1",
            "youtube_url": "https://www.youtube.com/watch?v=rp8Slv4INLk"
        }
    ]
}
"""

let emptyJson = """
{
    "recipes": []
}
"""

// swiftlint:enable line_length
#endif
