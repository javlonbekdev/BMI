//
//  AdminEdit.swift
//  BMI
//
//  Created by Javlonbek iOS Dev on 25/06/22.
//

import SwiftUI

struct Confirm: View {
    @FetchRequest(sortDescriptors: []) var curators: FetchedResults<Curator>
    @Environment(\.presentationMode) var present
    @EnvironmentObject var user: User
    @State var theme = ""
    @State var student = ""
    var items: Model
    var body: some View {
        VStack{
            Spacer()
            Text("\(items.group ?? "") - 18 guruh talabasining Bitiruv malakaviy ishi mavzusi")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            
            Text((items.name ?? "").prefix((items.name?.count ?? 1)-1))
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            Button{
                Service.shared.put(id: items.id, name: "\(items.name?.prefix(items.name!.count-1) ?? "")0", student: student == "" ? items.student ?? "" : student, group: items.group ?? "") { err in
                    if let err = err {
                        print("Failed to put data: ", err)
                    }
                    print("Finished put data")
                }
                present.wrappedValue.dismiss()
            } label: {
                Text("Tasdiqlash")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width/2)
                    .padding()
                    .background(.blue)
                    .cornerRadius(15)
            }.padding(.bottom)
            
            Button{
                Service.shared.put(id: items.id, name: "\(items.name?.prefix(items.name!.count-1) ?? "")2", student: student == "" ? items.student ?? "" : student, group: items.group ?? "") { err in
                    if let err = err {
                        print("Failed to put data: ", err)
                    }
                    print("Finished put data")
                }
                present.wrappedValue.dismiss()
            } label: {
                Text("Rad etish")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width/2)
                    .padding()
                    .background(.red)
                    .cornerRadius(15)
            }
            Spacer()
        }
        .navigationBarTitle(items.student ?? "", displayMode: .inline)
    }
}
