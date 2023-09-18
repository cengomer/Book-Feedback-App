//
//  DataController.swift
//  Bookworm
//
//  Created by omer elmas on 11.06.2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    
    init() {
        container.loadPersistentStores {description , error in
            if let error = error {
                print("Core Data failed to load : \(error.localizedDescription)")
            }
        }
    }
}
