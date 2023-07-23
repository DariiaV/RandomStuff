//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Дария Григорьева on 23.07.2023.
//

import FirebaseCore
import SwiftUI

@main
struct ToDoListApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
