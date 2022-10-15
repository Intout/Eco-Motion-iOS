//
//  TripPlannerWidget.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 14.10.2022.
//

import SwiftUI

struct TripPlannerWidget: View {
    
    @State var destinationFrom: String
    @State var destinationTo: String
    @State var selection: Int?
    @State private var destination: AnyView?
    @Binding var mapResults: [String]?
    
    var body: some View {
        VStack(spacing: 10){

            TextField("", text: self.$destinationFrom)
                .modifier(TextFieldModifier(startColor: .blue, endColor: .blue, textColor: .blue, placeHolderText: "From"))
            TextField("", text: self.$destinationTo)
                .modifier(TextFieldModifier(startColor: .green, endColor: .green, textColor: .green, placeHolderText: "To"))
            NavigationLink(destination: TripView(toText: self.destinationTo), tag: 1, selection: $selection){
                Button("Routes"){
                    
                    if !self.destinationTo.isEmpty{
                        self.selection = 1
                    }
                    
                    
                    return
                }
                .buttonStyle(LargeButtonStyle())
            }
            .onChange(of: destinationTo){ text in
                
                if destinationTo == ""{
                    mapResults = nil
                } else {
                    
                    MMapKitManager().searchByText(text: destinationTo){ data, error in
                        if let data = data, error == nil{
                            mapResults = data
                        }
                        
                    }
                }
                
            }
        }
        
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        .background(WidgetBackgroundView(backgroundImage: Image("WidgetBackground"), cornerRadius: 0))
    }
    
    
    func constructView() -> some View{
        let view = TripView(toText: self.destinationTo)
    
        return view
    }
    
}

struct TripPlannerWidget_Previews: PreviewProvider {
    static var previews: some View {
        TripPlannerWidget(destinationFrom: "", destinationTo: "", mapResults: .constant(nil))
    }
}

extension View {
    func float<Content: View>(above: Content) -> ModifiedContent<Self, Above<Content>> {
        self.modifier(Above(aboveContent: above))
    }
}

struct Above<AboveContent: View>: ViewModifier {
    let aboveContent: AboveContent
    
    func body(content: Content) -> some View {
        content.overlay(
            GeometryReader { proxy in
                Rectangle().fill(Color.clear).overlay(
                    self.aboveContent.offset(x: 0, y: proxy.size.height),
                    alignment: .top
                )
            },
            alignment: .top
        )
    }
}
