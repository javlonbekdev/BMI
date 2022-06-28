//
//  Profile.swift
//  BMI
//
//  Created by Javlonbek iOS Dev on 22/06/22.
//

import SwiftUI

struct Sign: View {
    @FetchRequest(sortDescriptors: []) var curators: FetchedResults<Curator>
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var user: User
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "person")
                    .foregroundColor(.white)
                TextField("loginingizni kiriting", text: $user.email)
                    .disableAutocorrection(true)
                    .font(.system(size: 15))
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(.gray.opacity(0.3), lineWidth: 1))
            
            HStack{
                Image(systemName: "lock")
                    .foregroundColor(.white)
                SecureField("parolingizni kiriting", text: $user.password)
                    .font(.system(size: 15))
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(.gray.opacity(0.3), lineWidth: 1))
            Spacer()
            HStack{
                Button {
                    if (user.email == "admin" && user.password == "admin") || Service().findValue(items: user.model, userEmail: user.email) {
                        let curator = Curator(context: moc)
                        curator.group = String(user.email)
                        try? self.moc.save()
                        dismiss()
                    }
                } label: {
                    Text("Tasdiqlash")
                        .font(.title2)
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .cornerRadius(15)
                }.buttonStyle(PlainButtonStyle())
            }
            Spacer()
            
        }
        .padding()
        .navigationBarTitle("Kirish")
    }
}
