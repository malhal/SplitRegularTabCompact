//
//  ContentView.swift
//  Shared
//
//  Created by Malcolm Hall on 25/06/2020.
//

import SwiftUI

enum NavigationItem {
    case hello
    case goodbye
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @State private var selection: NavigationItem = .goodbye
   // @State private var selection2: NavigationItem? = .goodbye
    
    @ViewBuilder
    var body: some View {
        if horizontalSizeClass == .compact {
            AppTabNavigation(selection: $selection)
        } else {
            AppSidebarNavigation(selection: $selection)
            //AppSidebarNavigation()
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AppSidebarNavigation: View {
    
    //@State var selection: Set<NavigationItem> = [.hello]
    @Binding var selection: NavigationItem
    
    var body: some View {
        NavigationView {
            
           // List(selection: $selection) {
            List() {
                NavigationLink(destination: Detail(selection1: NavigationItem.hello, selection2: $selection)){//}, tag: NavigationItem.hello, selection: $selection) {
                //NavigationLink(destination: Hello()) {
                    Label("Hello", systemImage: "list.bullet")
                }
                .accessibility(label: Text("Hello"))
                //.tag(NavigationItem.hello)
                .listRowBackground(selection == .hello ? Color(UIColor.lightGray) : Color.clear)
                
                //NavigationLink(destination: Goodbye()) {
                NavigationLink(destination: Detail(selection1: NavigationItem.goodbye, selection2: $selection)){ // }, tag: NavigationItem.goodbye, selection: $selection) {
                    Label("Goodbye", systemImage: "heart")
                }
                .accessibility(label: Text("Goodbye"))
                .listRowBackground(selection == .goodbye ? Color(UIColor.lightGray) : Color.clear)
                //.tag(NavigationItem.goodbye)
            
                
            }
            .listStyle(SidebarListStyle())
            Detail(selection1: selection, selection2: $selection)
            
        }
    }
}


struct AppTabNavigation: View {
//    @State private var selection: Tab = .hello
    @Binding var selection: NavigationItem
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                Hello()
            }
            .tabItem {
                Label("Menu", systemImage: "list.bullet")
                    .accessibility(label: Text("Menu"))
            }
            .tag(NavigationItem.hello)
            
            NavigationView {
                Goodbye()
            }
            .tabItem {
                Label("Goodbye", systemImage: "list.bullet")
                    .accessibility(label: Text("Goodbye"))
            }
            .tag(NavigationItem.goodbye)
        }
    }
}

//extension AppTabNavigation {
//    enum Tab {
//        case hello
//        case goodbye
//       // case rewards
//       // case recipes
//    }
//}

struct Detail : View {
    let selection1: NavigationItem
    @Binding var selection2: NavigationItem
    
    @ViewBuilder
    var body: some View {
        if selection1 == .hello {
            Hello()
            .onAppear(){
                selection2 = .hello
            }
        }
        else {
            Goodbye()
                .onAppear(){
                selection2 = .goodbye
            }
        }

    }
}

struct Hello: View {
    
    
    var body: some View {
        //SmoothieList(smoothies: Smoothie.all)
        Text("Hello, world!").padding()
            .navigationTitle("Hello")

    }
    
}

struct Goodbye: View {
    
    var body: some View {
        //SmoothieList(smoothies: Smoothie.all)
        Text("Goodbye, world!").padding()
            .navigationTitle("Goodbye")
    }
    
}
