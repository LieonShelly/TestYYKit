//
//  FRPGalleryFlowLayout.swift
//  TestYYKit
//
//  Created by lieon on 16/9/9.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class FRPGalleryFlowLayout: UICollectionViewFlowLayout {

    override func prepareLayout() {
         guard let width = collectionView?.bounds.size.width, let height = collectionView?.bounds.size.height else { return  }
        itemSize = CGSize(width: (width - minimumInteritemSpacing * 3) / 2.0, height: (height - 10  * 3 - 64) / 2.0)
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
        sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
