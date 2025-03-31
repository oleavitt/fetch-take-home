//
//  Endpoint.swift
//  FetchTakeHome
//
//  Created by Oren Leavitt on 3/30/25.
//

import Foundation

enum Endpoint {
    case recipes
    case malformed
    case empty

    var urlString: String {
        switch self {
        case .recipes: return "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        case .malformed: return "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        case .empty: return "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
        }
    }
}
