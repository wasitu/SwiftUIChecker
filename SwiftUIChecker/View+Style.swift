//
//  View+Style.swift
//  SwiftUIChecker
//
//  Created by Seiya Shimokawa on 4/9/20.
//  Copyright © 2020 wasitu. All rights reserved.
//

import SwiftUI

enum ViewStyle {
    case button
}

extension View {
    func styled(_ style: ViewStyle) -> some View {
        switch style {
        case .button:
            return self
                .padding(12)
                .foregroundColor(.white)
                .background(
                    GeometryReader { geometry in
                        LinearGradient(gradient: Gradient(colors: [Color("DarkBlue"), Color("LightBlue")]), startPoint: .leading, endPoint: .trailing)
                            .cornerRadius(geometry.size.height/4)
                })
        }
    }
}

struct StyledViewChecker_Previews: PreviewProvider {
    static var previews: some View {
        Text("HELLO")
            .styled(.button)
    }
}
