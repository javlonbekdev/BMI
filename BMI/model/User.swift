//
//  Model.swift
//  BMI
//
//  Created by Javlonbek iOS Dev on 22/06/22.
//

import Foundation

class User: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var model = [Model]()
    @Published var arr = [Model]()
}
