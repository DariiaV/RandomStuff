//
//  ToDoListViewViewModel.swift
//  ToDoList
//
//  Created by Дария Григорьева on 23.07.2023.
//

import Foundation
///ViewModel for list of items view
///Primary tab
class ToDoListViewViewModel: ObservableObject {
    @Published var showingNewItemView = false
    
    init() {}
}
