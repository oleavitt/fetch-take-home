//
//  RecipiesListRow.swift
//  FetchTakeHome
//
//  Created by Oren Leavitt on 3/30/25.
//

import SwiftUI

struct RecipiesListRow: View {
    var recipe: Recipe

    var body: some View {
        HStack {
            CachedImageView(urlString: recipe.photoUrlSmall)
                .frame(width: 48, height: 48)
                .cornerRadius(5)
            VStack {
                Text(recipe.name)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(recipe.cuisine)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.vertical, 8)
        .padding(.leading, 8)
        .frame(maxWidth: .infinity)
        .background { Color("card-background") }
        .cornerRadius(10)
    }

    var placeHolderImage: some View {
        Image(systemName: "photo")
            .font(.title)
            .foregroundStyle(.placeholder)
    }

    @ViewBuilder
    var errorImage: some View {
        if #available(iOS 18, *) {
            // Show the new system two color photo with red (!) overlay
            Image(systemName: "photo.badge.exclamationmark")
                .font(.title)
                .foregroundStyle(.placeholder)
                .symbolRenderingMode(.multicolor)
        } else {
            // Otherwise show the old "photo" image in red
            Image(systemName: "photo")
                .font(.title)
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    ScrollView {
        LazyVStack {
            RecipiesListRow(recipe: Recipe.sample)
            RecipiesListRow(recipe: Recipe.sample)
        }
    }
    .padding()
    .background(Color("list-background"))
}
