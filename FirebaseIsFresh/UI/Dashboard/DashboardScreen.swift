//
//  DashboardScreen.swift
//  FirebaseIsFresh
//
//  Created by Bruno Benčević on 16.11.2023..
//

import SwiftUI

struct DashboardScreen: View {
    
    @ObservedObject var rootViewModel = RootViewModel.instance
    
    @State private var confirmationData: ConfirmationModalData?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            navigationBar
            
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 28) {
                    recentEvents
                    
                    featureList
                }
                .padding(.top, 28)
            }
        }
        .ignoresSafeArea()
        .confirmationModal($confirmationData)
    }
}

private extension DashboardScreen {
 
    var navigationBar: some View {
        HStack(spacing: 0) {
            Text("Dashboard")
                .fontWeight(.bold)
                .font(.largeTitle)
                .padding(.leading, 20)
            
            Spacer()
            
            Image(systemName: "person.circle")
                .resizable()
                .scaledToFit()
                .frame(size: 32)
                .frame(size: 40)
                .padding(.trailing, 20)
                .contentShape(Rectangle())
                .onTapGesture {
                    confirmationData = .sample()
                }
        }
        .padding(.top, 10)
        .frame(height: 70)
        .padding(.top, UIScreen.topSafePadding)
        .background(.white)
        .addShadow()
    }
    
    var recentEvents: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Events")
                .fontWeight(.medium)
                .font(.title3)
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(1...5, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.blue.gradient)
                            .frame(width: UIScreen.width / 1.75, height: UIScreen.width / 2.5)
                    }
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.blue.gradient)
                        .frame(width: UIScreen.width / 1.75, height: UIScreen.width / 2.5)
                        .overlay {
                            Text("See more")
                                .fontWeight(.bold)
                                .font(.callout)
                                .foregroundStyle(.white)
                        }
                }
                .padding(.horizontal, 20)
                .scrollTargetLayout()
            }
            .scrollIndicators(.never)
            .scrollTargetBehavior(.viewAligned(limitBehavior: .automatic))
        }
    }
    
    var featureList: some View {
        VStack(spacing: 12) {
            Text("Features")
                .fontWeight(.medium)
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 0) {
                featureCell(image: "bell.fill", title: "Push Notifications", color: .yellow) {
                    rootViewModel.goTo(.pushNotifications)
                }
                
                Color.black
                    .opacity(0.1)
                    .frame(height: 1)
                
                featureCell(image: "note.text", title: "In App Messages", color: .red) {
                    
                }
                
                Color.black
                    .opacity(0.1)
                    .frame(height: 1)
                
                featureCell(image: "option", title: "Remote Config", color: .blue) {
                    
                }
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .addShadow()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 20)
    }
    
    func featureCell(image: String, title: String, color: Color = .black, onTapped: @escaping EmptyCallback) -> some View {
        Button(action: {
            onTapped()
        }, label: {
            HStack(spacing: 24) {
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(size: 20)
                    .padding(.leading, 8)
                    .foregroundStyle(color)
                
                Text(title)
                    .font(.callout)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(size: 12)
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
            }
            .padding(16)
            .contentShape(Rectangle())
        })
        .buttonStyle(.plain)
    }
}

#Preview {
    DashboardScreen()
}
