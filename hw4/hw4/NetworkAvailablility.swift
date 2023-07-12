//
//  NetworkAvailablility.swift
//  HW4
//
//  Created by Ян Козыренко on 10.07.2023.
//

import Network

class NetworkAvailability {
    static let instance = NetworkAvailability()
    private let pathMonitor = NWPathMonitor()
    private var available = true
    func isAvailable() -> Bool {
        return available
    }
    private init() {
        pathMonitor.pathUpdateHandler = { [weak self] path in
            self?.available = path.status == .satisfied
        }
        let queue = DispatchQueue(label: "ReachabilityQueue")
        pathMonitor.start(queue: queue)
    }
    
}
