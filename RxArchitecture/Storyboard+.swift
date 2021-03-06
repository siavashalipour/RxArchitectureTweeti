//
//  Storyboard+.swift
//  RxArchitecture
//
//  Created by Siavash on 25/4/17.
//  Copyright © 2017 Fika. All rights reserved.
//

import Foundation
import Foundation

#if os(iOS)
  import UIKit
  
  extension UIStoryboard {
    func instantiateViewController<T>(ofType type: T.Type) -> T {
      return instantiateViewController(withIdentifier: String(describing: type)) as! T
    }
  }
#elseif os(OSX)
  import Cocoa
  
  extension NSStoryboard {
    func instantiateViewController<T>(ofType type: T.Type) -> T {
      return instantiateController(withIdentifier: String(describing: type)) as! T
    }
  }
#endif
