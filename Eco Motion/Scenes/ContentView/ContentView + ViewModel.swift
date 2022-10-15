//
//  ContentView + ViewModel.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 14.10.2022.
//

import Foundation

extension ContentView{
    class ViewModel: ObservableObject{
        @Published var destinationTo: String = ""
        @Published var destinationFrom: String = ""
        @Published var suggestionDatas: [ContentViewModel.SuggestionData.ViewModel] = [.init(title: "Suggestion 1", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sapien tortor, pellentesque at faucibus non, accumsan quis tellus. "), .init(title: "Suggestion 2", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sapien tortor, pellentesque at faucibus non, accumsan quis tellus. ")]
        @Published var displayStats: Bool = false
    }
}
