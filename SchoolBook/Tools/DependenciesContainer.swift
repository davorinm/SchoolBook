//
//  DependenciesContainer.swift
//  SchoolBook
//
//  Created by Davorin Madaric on 18/07/2022.
//

import Foundation

protocol AwesomeDICProtocol {
    func set<Service>(factory: @escaping () -> Service)
    func get<Service>() -> Service?
}

final class AwesomeDIContainer: AwesomeDICProtocol {
    static let shared = AwesomeDIContainer()

    private init() {}

    private var services: [String: Any] = [:]

    func set<Service>(factory: @escaping () -> Service) {
        services["\(Service.self)"] = factory()
    }
    
    func get<Service>() -> Service? {
        return services["\(Service.self)"] as? Service
    }
}
