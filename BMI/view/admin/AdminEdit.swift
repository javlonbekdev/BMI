//
//  AdminEdit.swift
//  BMI
//
//  Created by Javlonbek iOS Dev on 25/06/22.
//

import SwiftUI

struct AdminEdit: View {
    @FetchRequest(sortDescriptors: []) var curators: FetchedResults<Curator>
    @Environment(\.presentationMode) var present
    @EnvironmentObject var user: User
    @State var theme = ""
    @State var themeModel = Model(id: 0, name: "", student: nil, group: "")
    var items: Model
    var body: some View {
        ScrollView {
            VStack{
                Text("\(items.group ?? "") - 18 guruh talabasining Bitiruv malakaviy ishi mavzusi")
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
                
                Text("Bazadagi mavzular")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                ForEach(user.model.filter({ model in
                    model.student == nil && model.group?.count ?? 0 < 3
                })) { items in
                    Button {
                        theme = items.name ?? ""
                        themeModel = items
                    } label: {
                        VStack {
                            Text(items.name ?? "")
                                .lineLimit(3)
                                .font(.title2)
                                .padding()
                                .foregroundColor(.black)
                        }
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(15)
                        .padding(.top)
                    }
                    
                    
                }
                Spacer()
            }
            .navigationBarTitle(items.student ?? "", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                if theme == themeModel.name {
                    Service.shared.put(id: themeModel.id, name: themeModel.name ?? "", student: nil, group: "\(themeModel.group ?? "")0") { err in
                        if let err = err {
                            print("Failed to put data: ", err)
                        }
                        
                        print("Finished put data")
                        
                    }
                }
                Service.shared.put(id: items.id, name: "\(theme)0", student: items.student ?? "", group: items.group ?? "") { err in
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
                Text("done")
            }))
        }
    }
}
