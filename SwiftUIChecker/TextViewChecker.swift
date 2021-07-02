//
//  TextViewChecker.swift
//  SwiftUIChecker
//
//  Created by Seiya Shimokawa on 5/26/20.
//  Copyright © 2020 wasitu. All rights reserved.
//

import SwiftUI

struct TextViewChecker: View {
    @State private var text: String = "Hello World!"
    @State private var style: Font.TextStyle = .body
    
    var body: some View {
        VStack {
            Spacer(minLength: 32)
            Text(text)
                .font(.system(style))
            Spacer(minLength: 32)
            List {
                VStack(alignment: .leading) {
                    Text("Title")
                    HStack {
                        TextField("Input text.", text: $text)
                            .font(.title)
                            .foregroundColor(.blue)
                        Button(action: {
                            self.text = ""
                        }, label: {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(Color(UIColor.opaqueSeparator))
                        })
                    }
                }
                .buttonStyle(PlainButtonStyle())
                HStack {
                    Text("Font")
                    Spacer()
                    Text(style.name)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct TextViewChecker_Previews: PreviewProvider {
    static var previews: some View {
        TextViewChecker()
    }
}

extension Font.TextStyle {
    var name: String { "\(self)" }
}
