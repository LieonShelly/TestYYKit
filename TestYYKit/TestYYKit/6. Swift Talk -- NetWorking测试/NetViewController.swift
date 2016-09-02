//
//  NetViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/8/8.
//  Copyright © 2016年 lieon. All rights reserved.
//
// swiftlint:disable trailing_whitespace

import UIKit


typealias JSONDictionary = [String: AnyObject]

class NetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let episodesResource = Resource<[JSONDictionary]>(url: NSURL(), parse: { data in
            let json = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
            return json as? [JSONDictionary]
        })
        
     Network().load(episodesResource) { (result) in
        print(result)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
