//
//  StoreItem.swift
//  RxArchitecture
//
//  Created by Siavash on 25/4/17.
//  Copyright © 2017 Fika. All rights reserved.
//

import Foundation
import Unbox
import RealmSwift

typealias JSONObject = [String: Any]

class StoreItem: Object, Unboxable {
  
  // MARK: - properties
  dynamic var id: Int = 0
  dynamic var name: String = ""
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  convenience required init(unboxer: Unboxer) throws {
    self.init()
    id = try unboxer.unbox(key: "id")
    name = try unboxer.unbox(key: "name")
  }
  
  static func unboxMany(stores: [JSONObject]) -> [StoreItem] {
    return (try? unbox(dictionaries: stores, allowInvalidElements: true) as [StoreItem]) ?? []
  }
}
