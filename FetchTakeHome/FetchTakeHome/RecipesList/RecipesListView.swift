//
//  RecipesListView.swift
//  FetchTakeHome
//
//  Created by Oren Leavitt on 3/22/25.
//

import SwiftUI

struct RecipesListView: View {
    @StateObject var viewModel = RecipesListViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    RecipesListView()
}
