//
//  Scene+ViewController.swift
//  RxArchitecture
//
//  Created by Siavash on 25/4/17.
//  Copyright © 2017 Fika. All rights reserved.
//

import UIKit
import Then

extension Scene {
  func viewController() -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    switch self {
    case .storeList(let viewModel):
      //let nc = storyboard.instantiateViewController(withIdentifier: "StoreListNav") as! UINavigationController
      var vc = storyboard.instantiateViewController(ofType: StoreListViewController.self)
      vc.bindViewModel(to: viewModel)
      return vc
    }
  }
}

