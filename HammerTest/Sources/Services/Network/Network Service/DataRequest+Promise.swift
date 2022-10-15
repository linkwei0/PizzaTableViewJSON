//
//  DataRequest+Promise.swift
//  HammerTest
//

import Foundation
import Alamofire
import PromiseKit

extension DataRequest {
    func responseDataPromise() -> Promise<AFDataResponse<Data>> {
        return Promise { seal in
            responseData { response in
                seal.fulfill(response)
            }
        }
    }
}
