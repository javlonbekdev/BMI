//
//  AddTheme.swift
//  BMI
//
//  Created by Javlonbek iOS Dev on 25/06/22.
//

import SwiftUI

struct AddTheme: View {
    @Environment(\.presentationMode) var present
    @EnvironmentObject var user: User
    @State var theme = ""
    
    var body: some View {
        VStack{
            Spacer()
            
            Text("Mavzuni kiriting")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            
            TextEditor(text: $theme)
                .font(.title2)
                .frame(height: 150)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 25).stroke(.gray.opacity(0.2), lineWidth: 1))
                .padding()
                .disableAutocorrection(true)
            
            Spacer()
        }
        .navigationBarTitle("Talaba qo'shish", displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
            Service.shared.createData(name: theme, student: nil, group: "0") { err in
                if let err = err {
                    print("Failed to put data: ", err)
                }
                
                print("Finished put data")
                
            }
            present.wrappedValue.dismiss()
            
            Service.shared.loadData { res in
                switch res {
                case .failure(let err):
                    print("Failure to  fetch get:", err)
                case .success(let posts):
                    user.model = posts
                }
            }
        }, label: {
            Text("Done")
        }))
    }
}
