//
//  SuggestionCell.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 15.10.2022.
//

import SwiftUI

struct SuggestionCell: View {
    
    var titleText: String
    var bodyText: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text(titleText)
                .font(.custom("Charter", size: 18))
                .fontWeight(.bold)
            Rectangle()
                .frame(height: 3)
                .foregroundColor(.gray)
            Text(bodyText)
                .font(.custom("Charter", size: 18))
                .fontWeight(.regular)
                .lineLimit(5)
        }
        .padding([.vertical], 20)
        .padding([.horizontal], 10)
        .background(RoundedRectangle(cornerRadius: 25).foregroundColor(.white))
    }
}

struct SuggestionCell_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionCell(titleText: "Suggestion", bodyText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sapien tortor, pellentesque at faucibus non, accumsan quis tellus.")
    }
}
