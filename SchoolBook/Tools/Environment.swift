//
//  Environment.swift
//  SchoolBook
//
//  Created by Davorin Madaric on 21/07/2022.
//

import Foundation

struct Environment {
    let apiBaseURL: String
}

extension Environment {
    private static let debug = Self(apiBaseURL: "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/")
    private static let release = Self(apiBaseURL: "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/")
}

extension Environment {
    #if DEBUG
    static let current: Environment = .debug
    #else
    static let current: Environment = .release
    #endif
}
