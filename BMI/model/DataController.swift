//
//  DataController.swift
//  BMI
//
//  Created by Javlonbek iOS Dev on 22/06/22.
//

import Foundation
import CoreData

class DataControl: ObservableObject {
    let container = NSPersistentContainer(name: "Data")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
            else {
                print("\n\n\nsuccess\n\n\n")
            }
        }
    }
}
