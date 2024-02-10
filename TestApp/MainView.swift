//
//  ContentView.swift
//  TestApp
//
//  Created by Наташа Яковчук on 10.02.2024.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var vm = ViewModel()
    
    @State var orientation = UIDevice.current.orientation
    let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
        .makeConnectable()
        .autoconnect()
    
    var body: some View {
        
        let screen = UIScreen.main.bounds.size
        
        ZStack {
            VStack {
                Image("panda")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: screen.height * 0.3, alignment: .leading)
                    .clipped()
                    .animation(.default, value: orientation)
                
                HStack(spacing: 20) {
                    
                    Button {
                        withAnimation {
                            vm.isActive.toggle()
                        }
                    } label: {
                        Text(vm.isActive ? "Lock": "Unlock")
                            .customTextArea()
                    }
                    
                    Button {
                        withAnimation {
                            vm.openImage = true
                        }
                    } label: {
                        Text("Open from top")
                            .customTextArea()
                    }.disabled(!vm.isActive)
                        .opacity(vm.isActive ? 1: 0.5)
                }
                
                Spacer()
                
                Button {
                    print("Without any action in task")
                } label: {
                    Text("Open full")
                        .customTextArea()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray)
            .zIndex(1)
            
            if vm.openImage {
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Button {
                            withAnimation {
                                vm.openImage = false
                            }
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(.gray)
                                    .frame(height: 32)
                                
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                
                            }.padding(20)
                        }
                    }
                    
                    Spacer()
                    
                }.background (Image("panda")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: screen.width, height: screen.height + 30, alignment: .leading)
                    .clipped())
                .transition(.backslide)
                .zIndex(2)
                
            }
            
        }.onReceive(orientationChanged) { _ in
            self.orientation = UIDevice.current.orientation
        }
    }
}

fileprivate extension AnyTransition {
    
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .top),
            removal: .move(edge: .top))}
}

fileprivate extension View {
    
    func customTextArea(radius: Bool = true) -> some View {
        return self
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .padding(.horizontal)
            .background(.blue)
            .cornerRadius(18)
            .overlay {
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.indigo, lineWidth: 3)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

