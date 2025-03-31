//
//  Recipes.swift
//  FetchTakeHome
//
//  Created by Oren Leavitt on 3/30/25.
//

import Foundation

/// The top level JSON object returned by the API call
struct Recipes: Decodable {
    let recipes: [Recipe]
}
