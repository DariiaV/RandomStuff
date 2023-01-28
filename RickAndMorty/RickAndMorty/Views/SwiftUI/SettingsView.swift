//
//  SettingsView.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 27.01.2023.
//

import SwiftUI

struct SettingsView: View {
    let viewModel: SettingsViewViewModel
    
    init(viewModel: SettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.cellViewModels) { viewModel in
            HStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .padding()
                }
                Text(viewModel.title)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: .init(cellViewModels: SettingsOption.allCases.compactMap({
            return SettingCellViewModel(type: $0)
        })))
    }
}
