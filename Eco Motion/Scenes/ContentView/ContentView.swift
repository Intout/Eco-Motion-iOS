//
//  ContentView.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 14.10.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView{
                ScrollViewReader{ value in
                    ScrollView{
                        GeometryReader{ geo in
                            Color.clear
                                .frame(width: 0, height: 0)
                                .onChange(of: geo.frame(in: .global).midY){ yValue in
                                    print(yValue)
                                    print(-geometry.size.height)
                                    self.viewModel.displayStats = yValue < -geometry.size.height / 2.5
                                }
                                
                        }
                    }
                    .frame(width: 0, height: 0)
                    .hidden()
                    .id("main")
                    
                    VStack(spacing: 20){
                        VStack(alignment: .leading, spacing: 0) {
                            Text("PLAN A TRIP")
                                .font(.custom("Charter", size: 40))
                                .fontWeight(.heavy)
                                .foregroundColor(.buttonTitleColor)
                                .padding([.horizontal], 20)
                            TripPlannerWidget(destinationFrom: "", destinationTo: self.viewModel.destinationTo)
                        }
                        NavigationWidget()
                            .padding([.horizontal], 20)
                            .frame(height: geometry.size.height / 5.5)
                        
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack(spacing: 20){
                                ForEach(self.viewModel.suggestionDatas, id: \.title){ cell in
                                    SuggestionCell(titleText: cell.title, bodyText: cell.body)
                                        .frame(minWidth: 100, maxWidth: 175, maxHeight: .infinity)
                                }
                            }
                            .padding([.vertical])
                            .padding([.horizontal], 20)
                        }
                        .frame(height: geometry.size.height / 3.6)
                        .background(WidgetBackgroundView(cornerRadius: 0))
                        Rectangle()
                            .foregroundColor(.statBackgroundColor)
                            .frame(height: geometry.size.height)
                            .id("stats")
                    }
                    .onChange(of: self.viewModel.displayStats){ _ in
                        if self.viewModel.displayStats{
                            withAnimation(.interpolatingSpring(stiffness: 1, damping: 150)){
                                value.scrollTo("stats")
                            }
                        } else {
                            withAnimation(.interpolatingSpring(stiffness: 1, damping: 150)){
                                value.scrollTo("main")
                            }
                        }
                        
                    }
                    
                }
                
            }
            
            
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color(red: 0.972, green: 1, blue: 0.958))
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/// Contains the gap between the smallest value for the y-coordinate of
/// the frame layer and the content layer.
private struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}
