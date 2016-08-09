//
//  Network.swift
//  TestYYKit
//
//  Created by lieon on 16/8/8.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class Network: NSObject {

    
    func load<A>(resource: Resource<A>, completion: A? -> ())  {
        NSURLSession.sharedSession().dataTaskWithURL(resource.url!) { (data, _, _) in
            let result = data.flatMap(resource.parse)
            completion(result)
            
        }.resume()
    }
}
