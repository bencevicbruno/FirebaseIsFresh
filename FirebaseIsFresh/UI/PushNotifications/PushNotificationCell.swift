//
//  PushNotificationCell.swift
//  FirebaseIsFresh
//
//  Created by Bruno Benčević on 19.11.2023..
//

import SwiftUI

struct PushNotificationModel: Equatable, Identifiable {
    let id = UUID()
    let title: String
    let description: String?
    let dateLastModified: Date
    
    static func sample(small: Bool) -> PushNotificationModel {
        return .init(title: "Sample Push Notification",
                     description: small ? nil : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                     dateLastModified: .now)
    }
}

struct PushNotificationCell: View {
    
    let model: PushNotificationModel
    @Binding var isInEditMode: Bool
    @Binding var isSelected: Bool
    
    let onSwipedToSend: EmptyCallback
    let onSwipedToDelete: EmptyCallback
    
    @State private var horizontalOffset: CGFloat = 0
    @State private var actionHapticTrigger = true
    @State private var warningHapticTrigger = true
    @State private var selectedHapticTrigger = true
    @State private var deselectedHapticTrigger = true
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            if isInEditMode {
                radioButton
                    .frame(maxHeight: .infinity)
                    .transition(.move(edge: .leading))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(verbatim: model.title)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Text(verbatim: Self.dateFormatter.string(from: model.dateLastModified))
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                if let description = model.description {
                    Text(verbatim: description)
                        .font(.callout)
                        .foregroundStyle(.black.opacity(0.75))
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
            }
            .padding(.leading, 8)
            
            chevronButton
                .frame(maxHeight: .infinity)
                .padding(.leading, 12)
                .padding(.horizontal, 16)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .frame(height: model.description == nil ? 60 : 120, alignment: .topLeading)
        .background(isInEditMode && isSelected ? .gray.opacity(0.25) : .white)
        .background(.white)
        .offset(x: clamp(horizontalOffset, min: -Self.dragThreshold, max: Self.dragThreshold))
        .gesture(DragGesture(coordinateSpace: .global)
            .onChanged { value in
                self.horizontalOffset = value.translation.width
            }
            .onEnded { value in
                self.horizontalOffset = 0
                
                if value.translation.width >= Self.dragThreshold {
                    self.actionHapticTrigger.toggle()
                    onSwipedToSend()
                } else if value.translation.width <= -Self.dragThreshold {
                    self.warningHapticTrigger.toggle()
                    onSwipedToDelete()
                }
            })
        .sensoryFeedback(.start, trigger: actionHapticTrigger)
        .sensoryFeedback(.warning, trigger: warningHapticTrigger)
        .sensoryFeedback(.increase, trigger: selectedHapticTrigger)
        .sensoryFeedback(.decrease, trigger: deselectedHapticTrigger)
        .background(HStack(spacing: 0) {
            ZStack(alignment: .leading) {
                Color.blue
                
                VStack(spacing: 4) {
                    Image(systemName: "arrow.forward")
                        .resizable()
                        .scaledToFit()
                        .frame(size: 20)
                    
                    Text("Send")
                }
                .foregroundStyle(.white)
                .fontWeight(.semibold)
                .padding(.leading, 20)
            }
            
            ZStack(alignment: .trailing) {
                Color.red
                
                VStack(spacing: 4) {
                    Image(systemName: "trash.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(size: 20)
                    
                    Text("Delete")
                }
                .foregroundStyle(.white)
                .fontWeight(.semibold)
                .padding(.trailing, 20)
            }
        })
        .animation(.spring, value: horizontalOffset)
        .contentShape(Rectangle())
        .onTapGesture {
            guard isInEditMode else { return }
            isSelected.toggle()
        }
        .onLongPressGesture {
            if !isInEditMode {
                isInEditMode = true
            }
        }
        .animation(.linear(duration: 0.1), value: isInEditMode)
        .onChange(of: isSelected, initial: false) {
            if isSelected {
                selectedHapticTrigger.toggle()
            } else {
                deselectedHapticTrigger.toggle()
            }
        }
    }
}

private extension PushNotificationCell {
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        
        return formatter
    }()
    
    static let dragThreshold: CGFloat = UIScreen.width / 4
    
    var radioButton: some View {
        ZStack {
            Circle()
                .fill(.blue)
            
            Circle()
                .fill(.white)
                .frame(size: 20)
            
            if isSelected {
                Circle()
                    .fill(.blue)
                    .frame(size: 16)
            }
        }
        .frame(size: 24)
        .frame(size: 40)
    }
    
    var chevronButton: some View {
        Image(systemName: "chevron.right")
            .resizable()
            .scaledToFit()
            .frame(size: 12)
            .fontWeight(.bold)
            .foregroundStyle(.gray)
    }
}

#Preview {
    VStack(spacing: 0) {
        PushNotificationCell(
            model: .sample(small: false),
            isInEditMode: .constant(true),
            isSelected: .constant(true),
            onSwipedToSend: {},
            onSwipedToDelete: {})
        
        Divider()
        
        PushNotificationCell(
            model: .sample(small: true),
            isInEditMode: .constant(true),
            isSelected: .constant(false),
            onSwipedToSend: {},
            onSwipedToDelete: {})
    }
}
