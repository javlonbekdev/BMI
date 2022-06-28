//
//  Edit.swift
//  BMI
//
//  Created by Javlonbek iOS Dev on 24/06/22.
//

import SwiftUI

struct Edit: View {
    @FetchRequest(sortDescriptors: []) var curators: FetchedResults<Curator>
    @Environment(\.presentationMode) var present
    @EnvironmentObject var user: User
    @State var edit = false
    @State var theme = ""
    @State var student = ""
    var items: Model
    var who: Bool
    var body: some View {
        ScrollView {
            VStack{
                if edit {
                    
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
                        model.student == nil
                    })) { items in
                        Button {
                            theme = items.name ?? ""
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
                }
                else {
                    
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
                            .frame(maxWidth: UIScreen.main.bounds.width-20)
                            .padding()
                            .background(.blue)
                            .cornerRadius(15)
                    }
                    
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
                            .frame(maxWidth: UIScreen.main.bounds.width-20)
                            .padding()
                            .background(.red)
                            .cornerRadius(15)
                    }
                }
                Spacer()
            }
            .onDisappear(perform: {
                edit = false
            })
            .navigationBarTitle(items.student ?? "", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                if !who {
                    if edit {
                        Service.shared.put(id: items.id, name: "\(items.name ?? "")0", student: student == "" ? items.student ?? "" : student, group: items.group ?? "") { err in
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
                    } else {
                        edit = true
                    }
                }
            }, label: {
                if !who {
                    if edit {
                        Text("done")
                    } else {
                        Text("Edit")
                    }
                }
        }))
        }
    }
}
