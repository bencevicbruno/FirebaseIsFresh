//
//  NavigationBar.swift
//  FirebaseIsFresh
//
//  Created by Bruno Benčević on 16.11.2023..
//

import SwiftUI

struct NavigationBarItem {
    let label: Label
    let isDestructive: Bool
    let action: EmptyCallback
    
    init(label: Label, isDestructive: Bool = false, action: @escaping EmptyCallback) {
        self.label = label
        self.isDestructive = isDestructive
        self.action = action
    }
    
    static func text(_ text: String, _ action: @escaping EmptyCallback) -> NavigationBarItem {
        return .init(label: .text(text), action: action)
    }
    
    static func back(_ action: @escaping EmptyCallback) -> NavigationBarItem {
        return .init(label: .text("Back"), action: action)
    }
    
    enum Label {
        case text(String)
        case image(ImageResource)
        case systemImage(String)
    }
}

struct NavigationBar: View {
    
    let title: String
    let includeSafeArea: Bool
    let leadingItem: NavigationBarItem?
    let trailingItem: NavigationBarItem?
    
    init(_ title: String, includeSafeArea: Bool = true, leadingItem: NavigationBarItem? = nil, trailingItem: NavigationBarItem? = nil) {
        self.title = title
        self.includeSafeArea = includeSafeArea
        self.leadingItem = leadingItem
        self.trailingItem = trailingItem
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Group {
                if let leadingItem {
                    Button(action: {
                        leadingItem.action()
                    }, label: {
                        itemLabel(leadingItem)
                            .frame(width: 60, alignment: .leading)
                            .padding(.leading, 20)
                            .contentShape(Rectangle())
                    })
                } else {
                    Spacer()
                        .frame(width: 80)
                }
            }
            
            Spacer()
            
            Text(verbatim: title)
                .fontWeight(.semibold)
                .font(.title3)
            
            Spacer()
            
            Group {
                if let trailingItem {
                    Button(action: {
                        trailingItem.action()
                    }, label: {
                        itemLabel(trailingItem)
                            .frame(width: 60, alignment: .trailing)
                            .padding(.trailing, 20)
                            .contentShape(Rectangle())
                    })
                } else {
                    Spacer()
                        .frame(width: 80)
                }
            }
        }
        .frame(height: 50)
        .padding(.top, includeSafeArea ? UIScreen.topSafePadding : 0)
        .background(.white)
        .addShadow()
    }
    
    func itemLabel(_ item: NavigationBarItem) -> some View {
        HStack {
            switch item.label {
            case .text(let string):
                Text(verbatim: string)
                    .foregroundStyle(item.isDestructive ? .red : .blue)
            case .image(let imageResource):
                Image(imageResource)
                    .resizable()
                    .scaledToFit()
                    .frame(size: 20)
                    .frame(size: 40)
            case .systemImage(let string):
                Image(systemName: string)
                    .resizable()
                    .scaledToFit()
                    .frame(size: 20)
                    .frame(size: 40)
                    .foregroundStyle(item.isDestructive ? .red : .blue)
            }
        }
    }
    
    static func size(includeSafeArea: Bool) -> CGFloat {
        return 50 + (includeSafeArea ? UIScreen.topSafePadding : 0)
    }
}

#Preview {
    NavigationBar("Example", leadingItem: .init(label: .text("Back"), action: {}), trailingItem: .init(label: .systemImage("heart"), action: {}))
        .fullscreenFrame(alignment: .top)
}
