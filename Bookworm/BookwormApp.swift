//
//  BookwormApp.swift
//  Bookworm
//
//  Created by omer elmas on 10.06.2023.
//

import SwiftUI

@main
struct BookwormApp: App {

    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
           
        }
    }
}
