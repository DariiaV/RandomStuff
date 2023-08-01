//
//  RegisterUser.swift
//  LifeTime
//
//  Created by Дария Григорьева on 01.08.2023.
//

import Foundation

struct RegisterUser: Codable {
    let username: String
    let email: String
    let password: String
}


struct User {
    let username: String
    let email: String
    let userUID: String
}
