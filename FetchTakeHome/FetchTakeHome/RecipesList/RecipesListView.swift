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
            .padding(.horizontal)
            .background(Color("list-background"))
            .navigationTitle("recipes")
            .task {
                await viewModel.fetchRecipes()
            }
            .toolbar {
                Menu {
                    Picker("data-source", selection: $viewModel.fetchRecipesEndpoint) {
                        Text("recipes").tag(Endpoint.recipes)
                        Text("malformed").tag(Endpoint.malformed)
                        Text("empty").tag(Endpoint.empty)
                    }
                } label: {
                    Label("data-source", systemImage: "arrow.down.document.fill")
                }
            }
            .onChange(of: viewModel.fetchRecipesEndpoint) {
                Task {
                    await viewModel.fetchRecipes()
                }
            }
        }
    }

    private var recipesView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.recipes, id: \.self) { recipe in
                    RecipiesListRow(recipe: recipe)
                        .scrollTransition { content, phase in
                            // Give recipe cards a fading "roll on/off" effect as they scroll on/off screen
                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.25)
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                                .rotation3DEffect(.radians(phase.value), axis: (-1, 0, 0))
                        }
                }
            }
        }
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
