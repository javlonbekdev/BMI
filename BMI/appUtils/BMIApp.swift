//
//  BMIApp.swift
//  BMI
//
//  Created by Javlonbek iOS Dev on 20/06/22.
//

import SwiftUI
import CoreData

@main
struct BMIApp: App {
    @StateObject private var dataControl = DataControl()
    @StateObject var user = User()
    var body: some Scene {
        WindowGroup {
            First()
                .environment(\.managedObjectContext, dataControl.container.viewContext)
                .environmentObject(user)
        }
    }
}
