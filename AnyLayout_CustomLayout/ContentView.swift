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
    @State private var layoutType = LayoutType.zStack

    var body: some View {
        let layout = AnyLayout(layoutType.layout)

        NavigationStack {
            layout {
                ForEach(MyColors.allColors, id: \.color) { myColor in
                    myColor.color
                        .frame(width: myColor.width, height: myColor.height)
                }
            }
            .animation(.default, value: layoutType)
            .padding()
            .navigationTitle("AnyLayout")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if layoutType.index < LayoutType.allCases.count - 1 {
                            layoutType = LayoutType.allCases[layoutType.index + 1]
                        } else {
                            layoutType = LayoutType.allCases[0]
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

enum LayoutType: Int, CaseIterable {
    case zStack, hStack, vStack

    var index: Int {
        LayoutType.allCases.firstIndex(where: { $0 == self })!
    }

    var layout: any Layout {
        switch self {
        case .zStack:
            return ZStackLayout()
        case .hStack:
            return HStackLayout(alignment: .top, spacing: 0)
        case .vStack:
            return VStackLayout(alignment: .trailing)
        }
    }
}

#Preview {
    ContentView()
}
