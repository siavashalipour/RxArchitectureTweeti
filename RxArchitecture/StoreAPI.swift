//
//  StoreAPI.swift
//  RxArchitecture
//
//  Created by Siavash on 25/4/17.
//  Copyright © 2017 Fika. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol StoreAPIProtocol {
  static func getStores() -> Observable<[JSONObject]>
}

struct StoreAPI: StoreAPIProtocol {
  // MARK: - API Addresses
  fileprivate enum Address: String {
    case getStores = ""
//    case listFeed = "lists/statuses.json"
//    case listMembers = "lists/members.json"
    
    private var baseURL: String { return "http://www.mocky.io/v2/58fe990f110000bc01f5fdba" }
    var url: URL {
      return URL(string: baseURL.appending(rawValue))!
    }
  }
  
  // MARK: - API errors
  enum Errors: Error {
    case requestFailed
    case badResponse
    case httpError(Int)
  }
  static func getStores() -> Observable<[JSONObject]> {
    return request(address: StoreAPI.Address.getStores)
  }
  // MARK: - generic request to send an SLRequest
  static private func request<T: Any>(address: Address, parameters: [String: String] = [:]) -> Observable<T> {
    return Observable.create { observer in
      let url = address.url
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      
      let session = URLSession.shared
      session.dataTask(with: request, completionHandler: { (data, response, error) in
        if let error = error {
          observer.onError(error)
        }
        if let response = response, (response as! HTTPURLResponse).statusCode >= 400 && (response as! HTTPURLResponse).statusCode < 600 {
          observer.onError(Errors.httpError((response as! HTTPURLResponse).statusCode))
        }
        if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? T, let result = json {
          observer.onNext(result)
        }
        observer.onCompleted()
      }).resume()
      
      return Disposables.create()
    }
  }
}
