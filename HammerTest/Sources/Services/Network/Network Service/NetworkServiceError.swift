//
//  NetworkServiceError.swift
//  HammerTest
//

import Foundation

enum NetworkServiceError: LocalizedError {
    case failedToDecodeData
    case noData
    case requestFailed
    
    var errorDescription: String? {
        switch self {
        case .failedToDecodeData, .noData:
            return "Failed to decode data"
        case .requestFailed:
            return "Request failed"
        }
    }
}
