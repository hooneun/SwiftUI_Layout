//
//  ContentView.swift
//  AnyLayout_CustomLayout
//
//  Created by Hoon on 6/20/24.
//

import SwiftUI

public struct ChipsType: Equatable {
    let title: String
    let priority: Int

    public init(
        title: String,
        priority: Int = 0
    ) {
        self.title = title
        self.priority = priority
    }

    public static func == (lhs: ChipsType, rhs: ChipsType) -> Bool {
        lhs.title == rhs.title
    }
}

public struct ChipsView: View {
    var title: String

    public var body: some View {
        Text(title)
            .font(.caption)
            .foregroundColor(.black)
            .padding(.horizontal, 10)
            .padding(.vertical, 3)
            .background(.white)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.green, lineWidth: 1)
            )
            .frame(height: 24)
    }
}

struct ContentView2: View {
    var items: [ChipsType] = [
        .init(title: "첫번째"),
        .init(title: "두번째", priority: 1),
        .init(title: "세번째", priority: 2),
        .init(title: "네번째", priority: 3),
        .init(title: "서른마흔다섯번째", priority: 4),
        .init(title: "여섯번째", priority: 5),
        .init(title: "일곱번째", priority: 6),
        .init(title: "여덟번째", priority: 7),
        .init(title: "아홉번째", priority: 8),
    ]

    var body: some View {
        VStack {
            ChipsContainerView(items: items)
        }
        .padding()
    }
}

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
    case zStack, hStack, vStack, altStack

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
        case .altStack:
            return AlternateStackLayout()
        }
    }
}

#Preview {
    ContentView2()
}
