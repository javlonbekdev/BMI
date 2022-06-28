//
//  Simple.swift
//  BMI
//
//  Created by Javlonbek iOS Dev on 21/06/22.
//

import SwiftUI

struct First: View {
    @EnvironmentObject var user: User
    @State private var searchText = ""
    var body: some View {
        TabView{
            NavigationView{
                List {
                    ForEach(user.model.filter({ model in
                        model.name?.suffix(1) == "0" && searchText == "" ? true : (model.student ?? "").uppercased().contains(searchText.uppercased())
                    })){ items in
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
                .navigationBarTitle("Tasdiqlanganlar ro'yxati", displayMode: .inline)
            }
            .tabItem {
                Label("Menu", systemImage: "house")
            }
            Profile()
            
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }.task {
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
}
