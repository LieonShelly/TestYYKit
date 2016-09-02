//
//  SKPhotoBrowserViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/8/23.
//  Copyright © 2016年 lieon. All rights reserved.
//
// swiftlint:disable trailing_whitespace

import UIKit
import SKPhotoBrowser

class SKPhotoBrowserViewController: UIViewController {

    lazy var dataArray: [UIImage] = {
        var array = [UIImage]()
        for i in 0 ... 9 {
            let image = UIImage(named: "\(i + 1)")
            if let image = image {
                array.append(image)
            }
        }
        return array
    }()

    lazy var images: [SKPhoto] = {
        var array = [SKPhoto]()
        for i in 0 ... 9 {
            let image = UIImage(named: "\(i + 1)")
            if let image = image {
                let  skphoto = SKPhoto.photoWithImage(image)
                skphoto.caption = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
                array.append(skphoto)
            }
        }
        return array
    }()
    
    private lazy var collectionView: UICollectionView = {
        let co = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        co.registerClass(ImageCell.self, forCellWithReuseIdentifier: "cell")
        co.delegate = self
        co.dataSource = self
        return co
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

  func  setupUI() {
        view.addSubview(collectionView)
       collectionView.snp_makeConstraints { (make) in
        make.center.equalTo(view.snp_center)
        make.size.equalTo(view.snp_size)
    }
    }
    
}

extension SKPhotoBrowserViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
       cell.imageView.image = dataArray[indexPath.item]
        return cell
     }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = collectionView.cellForItemAtIndexPath(indexPath) as? ImageCell else {
            return 
        }
        let originImage = cell.imageView.image
        if let originImage = originImage {
            let browser = SKPhotoBrowser(originImage: originImage, photos: images, animatedFromView: cell)
            browser.initializePageIndex(indexPath.row)
            presentViewController(browser, animated: true, completion: {})
        }
    
    }
}

private class ImageCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.snp_makeConstraints { (make) in
            make.center.equalTo(contentView.snp_center)
            make.size.equalTo(contentView.snp_size)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
