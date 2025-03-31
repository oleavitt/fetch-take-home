//
//  RecipesListView.swift
//  FetchTakeHome
//
//  Created by Oren Leavitt on 3/22/25.
//

import SwiftUI

struct RecipesListView: View {
    @StateObject var viewModel: RecipesListViewModel

    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .empty:
                    emptyView
                case .loading:
                    loadingView
                case .error:
                    errorView
                case .success:
                    recipesView
                }
            }
            .padding()
            .navigationTitle("recipes")
            .task {
                await viewModel.fetchRecipes()
            }
            .background { Color("list-background") }
        }
    }

    private var recipesView: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.recipes, id: \.self) { recipe in
                    RecipiesListRow(recipe: recipe)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var emptyView: some View {
        VStack {
            Text("empty-recipes")
                .padding(.top)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var loadingView: some View {
        VStack {
            ProgressView("your-recipes-are-loading")
                .padding(.top)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var errorView: some View {
        VStack {
            HStack(alignment: .top) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
                Text(viewModel.errorMessage)
            }
            .padding(.top)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityElement()
        .accessibilityLabel("error: \(viewModel.errorMessage)")
    }
}

#Preview {
    RecipesListView(viewModel: RecipesListViewModel(networkLayer: NetworkLayerMock()))
}
