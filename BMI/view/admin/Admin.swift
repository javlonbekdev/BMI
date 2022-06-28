//
//  Admin.swift
//  BMI
//
//  Created by Javlonbek iOS Dev on 26/06/22.
//

import SwiftUI

struct Admin: View {
    @FetchRequest(sortDescriptors: []) var curators: FetchedResults<Curator>
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var user: User
    @State private var searchText = ""
    var body: some View {
        let arr = user.model
            .filter({ model in
                searchText == "" ? true
                : (model.student ?? "").uppercased().contains(searchText.uppercased())})
        List{
            Section("Tasdiqlanganlar") {
                ForEach(arr.filter({ items in
                    items.name?.suffix(1) == "0"
                })) {items in
                    NavigationLink {
                        NoEdit(items: items)
                    } label: {
                        HStack {
                            Text(items.student ?? "")
                            Spacer()
                            Text("\(items.group ?? "")-18")
                            Image(systemName: "circle.fill").foregroundColor(.green)
                        }
                    }
                }
            }
            Section("Kutayotganlar") {
                ForEach(arr.filter({ items in
                    items.name?.suffix(1) == "1"
                })) {items in
                    NavigationLink {
                        Confirm(items: items)
                    } label: {
                        HStack {
                            Text(items.student ?? "")
                            Spacer()
                            Text("\(items.group ?? "")-18")
                            Image(systemName: "circle.fill").foregroundColor(.blue)
                        }
                    }
                }
            }
            Section("Qaytarilganlar") {
                ForEach(arr.filter({ items in
                    items.name?.suffix(1) == "2"
                })) {items in
                    NavigationLink {
                        NoEdit(items: items)
                    } label: {
                        HStack {
                            Text(items.student ?? "")
                            Spacer()
                            Text("\(items.group ?? "")-18")
                            Image(systemName: "circle.fill").foregroundColor(.purple)
                        }
                    }
                }
            }
            Section("Mavzu tanlamaganlar") {
                ForEach(arr.filter({ items in
                    items.name == nil
                })) {items in
                    NavigationLink {
                        AdminEdit(items: items)
                    } label: {
                        HStack {
                            Text(items.student ?? "")
                            Spacer()
                            Text("\(items.group ?? "")-18")
                            Image(systemName: "circle.fill").foregroundColor(.red)
                        }
                    }
                }
            }
        }
        .refreshable{
            DispatchQueue.main.async {
                Service.shared.loadData { res in
                    switch res {
                    case .failure(let err):
                        print("Failure to  fetch posts:", err)
                    case .success(let posts):
                        user.model = posts
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .disableAutocorrection(true)
        .navigationBarItems(leading:
                                Button{
            curators.forEach { a in
                self.moc.delete(a)
            }
            try? self.moc.save()
        } label: {
            Image(systemName: "arrow.up.left.square")
        },
                            trailing:
                                NavigationLink{
            VStack{
                Spacer()
                NavigationLink{
                    AddStudent()
                } label: {
                    Text("Talaba qo'shish")
                        .frame(width: 300, height: 50)
                        .background(.gray.opacity(0.2))
                        .foregroundColor(.black)
                        .cornerRadius(15)
                }
                
                Spacer()
                
                NavigationLink{
                    AddTheme()
                } label: {
                    Text("Mavzu qo'shish")
                        .frame(width: 300, height: 50)
                        .background(.gray.opacity(0.2))
                        .foregroundColor(.black)
                        .cornerRadius(15)
                }
                
                Spacer()
            }
            
        } label: {
            Image(systemName: "plus")
        }
        )
        .navigationTitle("Boshqaruvchi")
        .navigationBarTitleDisplayMode(.inline)
    }
}
