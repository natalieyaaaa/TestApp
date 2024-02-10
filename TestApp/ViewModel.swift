//
//  ViewModel.swift
//  TestApp
//
//  Created by Наташа Яковчук on 10.02.2024.
//

import Foundation

final class ViewModel: ObservableObject {
    
    @Published var isActive = true
    @Published var openImage = false
    
}
  // in my opinion, in such a simple app ViewModel is very unnecessary, but as it is mentioned in pdf file, I did it
