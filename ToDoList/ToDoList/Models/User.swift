//
//  User.swift
//  ToDoList
//
//  Created by Дария Григорьева on 23.07.2023.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
