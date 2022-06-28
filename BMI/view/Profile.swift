//
//  Pr.swift
//  BMI
//
//  Created by Javlonbek iOS Dev on 22/06/22.
//

import SwiftUI



struct Profile: View {
    @FetchRequest(sortDescriptors: []) var curators: FetchedResults<Curator>
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var user: User
    
    var body: some View {
        NavigationView{
            if curators.isEmpty {
                NavigationLink {
                    Sign()
                } label: {
                    Text("Kirish")
                        .font(.title)
                        .frame(width: 150, height: 50, alignment: .center)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .navigationTitle("Foydalanuvchi")
                .navigationBarTitleDisplayMode(.inline)
            }
            else if curators[0].group ?? "" == "admin" {
                Admin()
            } else {
                if Service().findValue(items: user.model, userEmail: curators[0].group ?? "") {
                    Student()
                }
            }
        }
    }
}

