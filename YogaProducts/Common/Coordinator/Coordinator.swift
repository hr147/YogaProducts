//
//  Coordinator.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 02/10/2020.
//

import Foundation

protocol Coordinator: class {
    /// it will start the flow.
    func start()
    
    var child: Coordinator? { get set }
    var parent: Coordinator? { get set }
}

extension Coordinator {
    func startChild(_ coordinator: Coordinator) {
        child = coordinator
        child?.parent = self
        coordinator.start()
    }
    
    func didFinishChild() {
        child = nil
        parent?.child = nil
    }
}
