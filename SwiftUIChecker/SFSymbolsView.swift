//
//  SFSymbolsView.swift
//  SwiftUIChecker
//
//  Created by Seiya Shimokawa on 4/7/20.
//  Copyright © 2020 wasitu. All rights reserved.
//

import SwiftUI

struct SFSymbolsView: View {
    @Binding var presented: Bool
    
    let action: (SFSymbol) -> Void
    let symbols = SFSymbol.allCases
    let rows = 5
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 8)
            
            HStack {
                Spacer()
                Button("Close") {
                    self.presented = false
                }
                Spacer()
                    .frame(width: 24)
            }

            ScrollView {
                Spacer()
                VStack(spacing: 32) {
                    ForEach(Array(stride(from: 0, to: self.symbols.count, by: rows)), id: \.self) { colum in
                        HStack {
                            Spacer()
                                .frame(width: 16)
                            ForEach(0..<self.rows, id: \.self) { row in
                                Group {
                                    if colum + row < self.symbols.count {
                                        Button(action: {
                                            self.action(self.symbols[colum + row])
                                        }, label: {
                                            Image(systemName: self.symbols[colum + row].systemName)
                                                .frame(maxWidth: .infinity)
                                        })
                                    } else {
                                        Spacer()
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                            }
                            Spacer()
                                .frame(width: 16)
                        }
                    }
                    .font(.system(size: 32))
                    Spacer()
                        .frame(width: 16)
                }
            }
        }
        .onAppear {
            UITableView.appearance().separatorStyle = .none
        }
        .onDisappear {
            UITableView.appearance().separatorStyle = .singleLine
        }
    }
}

struct SFSymbolsView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State var showAlert: Bool = false
        @State var selectedSymbol: SFSymbol? = nil
        @State var presented: Bool = true
        
        var body: some View {
            SFSymbolsView(presented: $presented, action: { (symbol) in
                self.selectedSymbol = symbol
                self.showAlert = true
            })
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(self.selectedSymbol?.rawValue ?? ""))
            }
        }
    }
    static var previews: some View {
        PreviewWrapper()
            .previewDevice("iPhone SE")
        //            .previewDevice("iPhone X")
    }
}

