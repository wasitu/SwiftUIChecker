//
//  NavigationViewChecker.swift
//  SwiftUIChecker
//
//  Created by Seiya Shimokawa on 4/7/20.
//  Copyright © 2020 wasitu. All rights reserved.
//

import SwiftUI

struct NavigationViewChecker: View {
    @State private var barTitle: String = "NavigationViewChecker"
    @State private var barHidden: Bool = false
    @State private var barBackButtonHidden: Bool = false
    
    @State private var leadingBarItemSelection = 0
    @State private var leadingBarItemContents: [AnyView] = []
    @State private var leadingBarItemTitle: String = "Item"
    @State private var leadingBarItemImageName: String = "cube.fill"
    
    @State private var trailingBarItemSelection = 0
    @State private var trailingBarItemContents: [AnyView] = []
    @State private var trailingBarItemTitle: String = "Item"
    @State private var trailingBarItemImageName: String = "cube.fill"

    @State private var presentingSFSymbolsView: Bool = false
    
    enum NavigationViewStyle {
        case `default`
        case stack
        case doubleColum
    }
    @State private var style: NavigationViewStyle = .default
    
    var body: some View {
        let bindedBarHidden = Binding<Bool>(
            get: { self.barHidden },
            set: {
                self.barHidden = $0
                self.leadingBarItemContents = []
                self.trailingBarItemContents = []
        })
        
        return List {
            Group {
                VStack(alignment: .leading) {
                    Text("Title")
                    HStack {
                        TextField("Input navigation bar title.", text: $barTitle)
                            .font(.title)
                            .foregroundColor(.blue)
                        Button(action: {
                            self.barTitle = ""
                        }, label: {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(Color(UIColor.opaqueSeparator))
                        })
                    }
                }
                .buttonStyle(PlainButtonStyle())
                Toggle(isOn: bindedBarHidden) {
                    Text("Hidden")
                }
                Toggle(isOn: $barBackButtonHidden) {
                    Text("Back Button Hidden")
                }
                VStack(alignment: .leading) {
                    Text("Bar Items (Leading)")
                    Spacer().frame(height: 16)
                    Text("Type")
                        .foregroundColor(.gray)
                    Picker("", selection: $leadingBarItemSelection) {
                        Text("Text").tag(0)
                        Text("SFSymbol").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Spacer().frame(height: 16)
                    barItemSettingsView(
                        selection: $leadingBarItemSelection,
                        title: $leadingBarItemTitle,
                        imageName: $leadingBarItemImageName,
                        presenting: $presentingSFSymbolsView)
                    Spacer().frame(height: 16)
                    HStack {
                        Spacer()
                        Button(action: {
                            self.leadingBarItemContents.append(AnyView(
                                Button(action: {
                                    
                                }, label: {
                                    self.barItemContent(
                                        selection: self.$leadingBarItemSelection,
                                        title: self.$leadingBarItemTitle,
                                        imageName: self.$leadingBarItemImageName)
                                })
                            ))
                        }, label: {
                            Text("add")
                                .frame(minWidth: 64)
                                .styled(.button)
                        })
                    }
                    Spacer().frame(height: 8)
                    HStack {
                        Spacer()
                        Text("To reset bar items, hide navigation bar.")
                            .foregroundColor(.gray)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                VStack(alignment: .leading) {
                    Text("Bar Items (Trailing)")
                    Spacer().frame(height: 16)
                    Text("Type")
                        .foregroundColor(.gray)
                    Picker("", selection: $trailingBarItemSelection) {
                        Text("Text").tag(0)
                        Text("SFSymbol").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Spacer().frame(height: 16)
                    barItemSettingsView(
                        selection: $trailingBarItemSelection,
                        title: $trailingBarItemTitle,
                        imageName: $trailingBarItemImageName,
                        presenting: $presentingSFSymbolsView)
                    Spacer().frame(height: 16)
                    HStack {
                        Spacer()
                        Button(action: {
                            self.trailingBarItemContents.append(AnyView(
                                Button(action: {

                                }, label: {
                                    self.barItemContent(
                                        selection: self.$trailingBarItemSelection,
                                        title: self.$trailingBarItemTitle,
                                        imageName: self.$trailingBarItemImageName)
                                })
                            ))
                        }, label: {
                            Text("add")
                                .frame(minWidth: 64)
                                .styled(.button)
                        })
                    }
                    Spacer().frame(height: 8)
                    HStack {
                        Spacer()
                        Text("To reset bar items, hide navigation bar.")
                            .foregroundColor(.gray)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .listRowInsets(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
        }
//        .navigationViewStyle(style == .default ? DefaultNavigationViewStyle() : StackNavigationViewStyle())
        .navigationBarTitle(barTitle)
        .navigationBarHidden(barHidden)
        .navigationBarBackButtonHidden(barBackButtonHidden)
        .navigationBarItems(leading:
            HStack {
                ForEach(0..<leadingBarItemContents.count, id: \.self) { index in
                    self.leadingBarItemContents[index]
                }
            }, trailing:
            HStack {
                ForEach(0..<trailingBarItemContents.count, id: \.self) { index in
                    self.trailingBarItemContents[index]
                }
            }
        )
    }
    
    func barItemSettingsView(selection: Binding<Int>, title: Binding<String>, imageName: Binding<String>, presenting: Binding<Bool>) -> AnyView {
        switch selection.wrappedValue {
        case 1: return AnyView(Group {
            HStack {
                Text("SFSymbol")
                    .foregroundColor(.gray)
                Button(action: {
                    presenting.wrappedValue = true
                }, label: {
                    Image(systemName: imageName.wrappedValue)
                        .foregroundColor(.blue)
                })
                    .sheet(isPresented: presenting) {
                        SFSymbolsView(presented: presenting) { (symbol) in
                            imageName.wrappedValue = symbol.rawValue
                            presenting.wrappedValue = false
                        }
                }
            }
        })
        default: return AnyView(Group {
            HStack(alignment: .firstTextBaseline) {
                Text("Title")
                    .foregroundColor(.gray)
                TextField("", text: title)
                    .foregroundColor(.blue)
                Button(action: {
                    title.wrappedValue = ""
                }, label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                })
            }
        })
        }
    }
    
    func barItemContent(selection: Binding<Int>, title: Binding<String>, imageName: Binding<String>) -> AnyView {
        switch selection.wrappedValue {
        case 1: return AnyView(Image(systemName: imageName.wrappedValue))
        default: return AnyView(Text(title.wrappedValue))
        }
    }
    
//    func buildBarStyle() -> SwiftUI.NavigationViewStylea {
//        return DefaultNavigationViewStyle()
//    }
}

struct NavigationViewChecker_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NavigationViewChecker()
        }
    }
}
