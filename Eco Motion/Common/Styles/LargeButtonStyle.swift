//
//  LargeButtonStyle.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 14.10.2022.
//

import SwiftUI

struct LargeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 100, maxWidth: .infinity)
            .foregroundColor(.buttonTitleColor)
            .font(.custom("Charter", size: 25))
            .fontWeight(.semibold)
            .padding(10)
            .padding(.horizontal, 20)
            .background(.thickMaterial.opacity(1), in: RoundedRectangle(cornerRadius: 25, style: .continuous))
    }
}
