//
//  WeatherView.swift
//  anyweather
//
//  Created by Loi Tran on 12/15/21.
//

import SwiftUI
import DYPopoverView
import AlertToast

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @State private var navBarPopoverOriginFrame: CGRect = .zero
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(viewModel: viewModel)
                WeatherBodyView(viewModel: viewModel)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .principal, content: {
                    Text("Weather Forecast")
                        .font(Font.headline.weight(.bold))
                })})
            .navigationBarItems(leading: changeTextSizeBtn)
        }
        .overlay(Color.black.opacity(viewModel.showingPopover ? 0.1 : 0).onTapGesture {
            viewModel.showingPopover = false
        })
        .popoverView(content: {
            TextSizeSlider(viewModel: viewModel)
        },
                     background: {Color.white},
                     isPresented: $viewModel.showingPopover,
                     frame: .constant(CGRect(x:0, y:0, width: 200, height: 60)),
                     anchorFrame: navBarPopoverOriginFrame,
                     popoverType: .popout,
                     position: .bottomRight,
                     viewId: "")
    }
    
    private var changeTextSizeBtn: some View {
        Button("Aa") {
            viewModel.showingPopover.toggle()
        }
        .anchorFrame(rect: $navBarPopoverOriginFrame)
    }
}

struct TextSizeSlider: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "minus")
            Slider(value: $viewModel.textSize, in: 10...20, step: 1)
                .accentColor(Color.green)
            Image(systemName: "plus")
        }
        .padding()
        .foregroundColor(Color.blue)
    }
}

struct WeatherBodyView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        GeometryReader { geometry in
            List(viewModel.forecastRecords, id: \.date) { forecastInfo in
                WeatherCell(forecastInfo: forecastInfo, textSize: $viewModel.textSize)
            }
            .onAppear {
                UITableView.appearance().separatorColor = .clear
            }
        }
        .toast(isPresenting: $viewModel.showToast){
            AlertToast(type: .regular, title: viewModel.note)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel())
    }
}
