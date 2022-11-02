//
//  App.swift
//  Driving
//
//  Created by Андрей Чернышев on 02.11.2022.
//

enum App: Codable, Hashable {
    case cdl, dmv, moto
}

// MARK: Public
extension App {
    init?(code: String) {
        switch code {
        case "cdl":
            self = .cdl
        case "dmv":
            self = .dmv
        case "moto":
            self = .moto
        default:
            return nil
        }
    }
    
    var code: String {
        switch self {
        case .cdl:
            return "cdl"
        case .dmv:
            return "dmv"
        case .moto:
            return "moto"
        }
    }
}
