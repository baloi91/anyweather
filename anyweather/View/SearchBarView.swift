//
//  SearchBarView.swift
//  anyweather
//
//  Created by Loi Tran on 12/15/21.
//

import SwiftUI

struct SearchBar: View {
    @ObservedObject var viewModel: WeatherViewModel
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            TextField("Input a city name...", text: $viewModel.searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(4)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 16)
                        
                        if isEditing && !viewModel.searchText.isEmpty {
                            Button(action: {
                                isEditing = false
                                viewModel.clearResult()
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 16)
                            }
                        }
                    }
                )
                .accessibilityLabel(AccessibilityStrings.inputCityField)
            Button(action: {
                self.isEditing = false
                viewModel.clearResult()
            }) {
                Text("Cancel")
            }
            .padding(.trailing, 10)
            .transition(.move(edge: .trailing))
            .animation(.default)
        }
    }
}
