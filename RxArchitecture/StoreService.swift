//
//  StoreService.swift
//  RxArchitecture
//
//  Created by Siavash on 25/4/17.
//  Copyright © 2017 Fika. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxRealm

import RealmSwift
import Reachability
import Unbox

class StoreService {
  
  let stores: Observable<[StoreItem]>
  
  //provide username to fetch user's tweets
  convenience init(apiType: StoreAPIProtocol.Type) {
    self.init(jsonProvider: apiType.getStores())
  }
  
  private init(jsonProvider: Observable<[JSONObject]>) {
    
    stores = jsonProvider
      .map(StoreItem.unboxMany)
      .shareReplayLatestWhileConnected()
  }
}
