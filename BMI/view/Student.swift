//
//  Student.swift
//  BMI
//
//  Created by Javlonbek iOS Dev on 26/06/22.
//

import SwiftUI

struct Student: View {
    @FetchRequest(sortDescriptors: []) var curators: FetchedResults<Curator>
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var user: User
    var body: some View {
        VStack {
            let arr = user.model.filter { model in
                model.student ?? "" == curators[0].group ?? ""
            }
            List(arr) { item in
                let n = item.name ?? "a"
                if item.name == nil {
                    Section("Mavzu tanlamagansiz") {
                        NavigationLink{
                            AdminEdit(items: item)
                        } label: {
                            HStack{
                                Spacer()
                                Image(systemName: "circle.fill").foregroundColor(.red)
                            }
                        }
                    }
                } else if n.suffix(1) == "0" {
                    Section("Mavzuyingiz tasdiqlangan") {
                        NavigationLink{
                            NoEdit(items: item)
                        } label: {
                            HStack{
                                Text((item.name ?? "").prefix((item.name ?? "").count - 1))
                                Spacer()
                                Image(systemName: "circle.fill").foregroundColor(.green)
                            }
                        }
                    }
                } else if n.suffix(1) == "1" {
                    Section("Kuting!!!") {
                        NavigationLink{
                            NoEdit(items: item)
                        } label: {
                            HStack{
                                Text(item.name ?? "")
                                Spacer()
                                Image(systemName: "circle.fill").foregroundColor(.blue)
                            }
                        }
                    }
                } else {
                    Section("Mavzuyingiz qaytarildi!") {
                        NavigationLink{
                            AdminEdit(items: item)
                        } label: {
                            HStack{
                                Text(item.name ?? "")
                                Spacer()
                                Image(systemName: "circle.fill").foregroundColor(.pink)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle(curators[0].group ?? "", displayMode: .inline)
        .navigationBarItems(leading:
                                Button{
            curators.forEach { a in
                self.moc.delete(a)
            }
            try? self.moc.save()
        } label: {
            Image(systemName: "arrow.up.left.square")
        })
    }
}
