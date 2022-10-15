//
//  NetworkService.swift
//  HammerTest
//

import Alamofire
import PromiseKit
import Foundation

class NetworkService {
    func request<T: Decodable>(method: HTTPMethod, url: URLConvertible,
                               parameters: Parameters? = nil) -> Promise<T> {
        let request = AF.request(url, method: method, parameters: parameters)
        
        return Promise { seal in
            firstly {
                request.responseDataPromise()
            }.then { response in
                self.handleResponse(response)
            }.done { object in
                seal.fulfill(object)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    private func handleResponse<T: Decodable>(_ response: AFDataResponse<Data>) -> Promise<T> {
        return Promise { seal in
            if case .failure(let error) = response.result {
                seal.reject(error.underlyingError ?? error)
                return
            }
            
            let statusCode: HTTPStatusCode
            if let code = response.response?.statusCode {
                statusCode = HTTPStatusCode(rawValue: code) ?? .internalServerError
            } else {
                statusCode = .internalServerError
            }
            
            switch statusCode {
            case .okStatus, .created, .accepted, .noContent:
                if let data = response.data {
                    decode(data, ofType: T.self).done { object in
                        seal.fulfill(object)
                    }.catch { error in
                        seal.reject(error)
                    }
                } else {
                    seal.reject(NetworkServiceError.noData)
                }
            default:
                seal.reject(NetworkServiceError.requestFailed)
            }
        }
    }
    
    private func decode<T: Decodable>(_ data: Data, ofType type: T.Type) -> Promise<T> {
        return Promise { seal in
            do {
                let object = try JSONDecoder().decode(type.self, from: data)
                seal.fulfill(object)
            } catch {
                print(error)
                seal.reject(NetworkServiceError.failedToDecodeData)
            }
        }
    }
}
