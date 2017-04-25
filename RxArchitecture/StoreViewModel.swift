//
//  StoreViewModel.swift
//  RxArchitecture
//
//  Created by Siavash on 25/4/17.
//  Copyright © 2017 Fika. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm
import RxCocoa

class StoreViewModel {
  private let bag = DisposeBag()
  private let storeService: StoreService
  
  // MARK: - Input
  
  // MARK: - Output
  private(set) var stores: Observable<(AnyRealmCollection<StoreItem>,RealmChangeset?)>!
  
  // MARK: - Init
  init(apiType: StoreAPIProtocol.Type = StoreAPI.self) {
    
    storeService = StoreService(apiType: apiType)
    
    bindOutput()
    
    storeService.stores
      .subscribe(Realm.rx.add(update: true))
      .addDisposableTo(bag)
  }
  
  private func bindOutput() {
    guard let realm = try? Realm() else {
      return
    }
    stores = Observable.changeset(from: realm.objects(StoreItem.self))
    
  }
}
