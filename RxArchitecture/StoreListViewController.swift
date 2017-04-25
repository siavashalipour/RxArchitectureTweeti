//
//  StoreListViewController.swift
//  RxArchitecture
//
//  Created by Siavash on 25/4/17.
//  Copyright © 2017 Fika. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Then
import RxRealmDataSources

final class StoreListViewController: UIViewController, BindableType {
  
  @IBOutlet weak var tableView: UITableView!
  
  var viewModel: StoreViewModel!
   private let bag = DisposeBag()
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.estimatedRowHeight = 90
    tableView.rowHeight = UITableViewAutomaticDimension
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: nil, action: nil)
  }
  
  func bindViewModel() {
    let dataSource = RxTableViewRealmDataSource<StoreItem>(cellIdentifier:
    "StoreCellView", cellType: StoreCellView.self) { cell, _, tweet in
      cell.update(with: tweet)
    }
    viewModel.stores
      .bind(to: tableView.rx.realmChanges(dataSource))
      .addDisposableTo(bag)
  }
}
