//
//  ConfirmationModal.swift
//  FirebaseIsFresh
//
//  Created by Bruno Benčević on 19.11.2023..
//

import SwiftUI

struct ConfirmationModal: View {
    
    @Binding var data: ConfirmationModalData?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.opacity(0.25)
                .opacity(data == nil ? 0 : 1)
                .allowsHitTesting(data != nil)
                .onTapGesture {
                    data = nil
                }
            
            if let data {
                VStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 0) {
                        if let title = data.title {
                            Text(verbatim: title)
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.top, 24)
                                .padding(.horizontal, 16)
                                .frame(maxWidth: .infinity)
                        }
                        
                        Text(verbatim: data.message)
                            .font(.callout)
                            .frame(maxWidth: .infinity)
                            .padding(.top, data.title == nil ? 24 : 16)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 24)
                        
                        Color.black.opacity(0.05)
                            .frame(height: 2)
                        
                        Text(verbatim: data.confirmTitle)
                            .foregroundStyle(data.isConfirmDestructive ? .red :  .blue)
                            .font(.title3)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                data.confirmAction()
                                self.data = nil
                            }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    Text(data.cancelTitle)
                        .foregroundStyle(.blue)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            data.cancelAction?()
                            self.data = nil
                        }
                        .background(.thickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .padding(.bottom, max(16, UIScreen.bottomSafePadding))
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .ignoresSafeArea()
        .animation(.spring(.bouncy(duration: 0.4)), value: data)
    }
}

#Preview {
    ConfirmationModal(data: .constant(.sample(title: "Please confirm")))
}
