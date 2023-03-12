//
//  ContentView.swift
//  Path-NavStack
//
//  Created by Shubham Kamdi on 3/11/23.
//

import SwiftUI

var dummy = ["Assassin Creed", "God of War", "Dark Souls", "Diablo 4"]

struct ContentView: View {
    @State var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(0 ..< 4, id: \.self) {
                    index in
                    Text(dummy[index]).onTapGesture {
                        // Push into stack
                        switch dummy[index] {
                        case "Assassin Creed":
                            path.append(AssassinCreedLink(title: "Assassin Creed"))
                        case "God of War":
                            path.append(GodOfWarLink(title: "God of War"))
                        case "Dark Souls":
                            path.append(DarkSoulsLink(title: "Dark Souls"))
                        case "Diablo 4":
                            path.append(Diablo4dLink(title: "Diablo 4"))
                        default:
                            path.removeLast(path.count)
                        }
                    }
                }
            }.navigationTitle("Games")
                // Determining routes based on Data link
                .navigationDestination(for: AssassinCreedLink.self) { link in
                    DetailView(title: link.title, path: $path)
                }.navigationDestination(for: GodOfWarLink.self) { link in
                    DetailView(title: link.title, path: $path)
                }.navigationDestination(for: DarkSoulsLink.self) { link in
                    DetailView(title: link.title, path: $path)
                }.navigationDestination(for: Diablo4dLink.self) { link in
                    DetailView(title: link.title, path: $path)
                }
        }
    }
}

struct DetailView: View {
    let title: String
    @Binding var path: NavigationPath
    var body: some View {
        Image(title)
            .resizable()
            .frame(height: 200)
        
        List {
            ForEach(0 ..< 4, id: \.self) {
                index in
                if dummy[index] != title {
                    Text(dummy[index]).onTapGesture {
                        // Push into stack
                        switch dummy[index] {
                        case "Assassin Creed":
                            path.append(AssassinCreedLink(title: "Assassin Creed"))
                        case "God of War":
                            path.append(GodOfWarLink(title: "God of War"))
                        case "Dark Souls":
                            path.append(DarkSoulsLink(title: "Dark Souls"))
                        case "Diablo 4":
                            path.append(Diablo4dLink(title: "Diablo 4"))
                        default:
                            path.removeLast(path.count)
                        }
                    }
                }
            }
            
            Section {
                // Pop to root
                Text("Games").onTapGesture {
                    path.removeLast(path.count)
                }
            }
        }.navigationTitle(title)
    }
}

struct AssassinCreedLink: Hashable {
    var id = UUID().uuidString
    var title: String
}

struct GodOfWarLink: Hashable {
    var id = UUID().uuidString
    var title: String
}

struct DarkSoulsLink: Hashable {
    var id = UUID().uuidString
    var title: String
}

struct Diablo4dLink: Hashable {
    var id = UUID().uuidString
    var title: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
