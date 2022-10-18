//
//  Person.swift
//  IP06_BusinessCard
//
//  Created by Rai, Rhea on 10/18/22.
//

import Foundation
class Person {
    var firstName: String
    var LastName: String
    var role: String
    var phone: String
    var email: String
    
    var imageName: String
    
    init(firstName: String, LastName: String, role: String, phone: String, email: String, imageName: String) {
        self.firstName = firstName
        self.LastName = LastName
        self.role = role
        self.phone = phone
        self.email = email
        self.imageName = imageName
    }
}
