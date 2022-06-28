//
//  Model.swift
//  BMI
//
//  Created by Javlonbek iOS Dev on 22/06/22.
//

import Foundation

struct Model: Codable, Identifiable, Hashable {
    let id: Int
    var name, student, group: String?
}


