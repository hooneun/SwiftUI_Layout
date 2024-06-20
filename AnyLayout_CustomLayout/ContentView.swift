//
//  ContentView.swift
//  AnyLayout_CustomLayout
//
//  Created by Hoon on 6/20/24.
//

import SwiftUI

struct MyColors {
    var color: Color
    var width: CGFloat
    var height: CGFloat

    static var allColors: [MyColors] {
        [
            .init(color: .red, width: 60, height: 75),
            .init(color: .teal, width: 100, height: 100),
            .init(color: .purple, width: 40, height: 80),
            .init(color: .indigo, width: 120, height: 100),
        ]
    }
}

struct ContentView: View {
    @State private var changeLayout = false

    var body: some View {
        let layout = changeLayout ? AnyLayout(HStackLayout()) : AnyLayout(ZStackLayout())

        NavigationStack {
            layout {
                ForEach(MyColors.allColors, id: \.color) { myColor in
                    myColor.color
                        .frame(width: myColor.width, height: myColor.height)
                }
            }
            .padding()
            .navigationTitle("AnyLayout")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            changeLayout.toggle()
                        }
                    } label: {
                        Image(systemName: "circle.grid.3x3.fill")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
