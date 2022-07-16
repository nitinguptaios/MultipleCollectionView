//
//  MovieCollectionViewController.swift
//  Multiple Collections
//
//  Created by IPH Technologies on 21/04/22.
//
//  Copyright © 2022 IPH Technologies All rights reserved.

import UIKit

protocol CategoriesCellDelegate: AnyObject {
    func cellTap(cellUrl: String)
}

// MARK: First Category Cell
class CateogriesCell: UICollectionViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var storyCollectionView: UICollectionView!
    @IBOutlet weak var pageControler: UIPageControl!
    var cellDelegate : CategoriesCellDelegate?
    
    fileprivate var currentPage: Int = 0
    
    // MARK: For Display the page number in page controll of collection view Cell
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: storyCollectionView.contentOffset, size: storyCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = storyCollectionView.indexPathForItem(at: visiblePoint) {
            self.pageControler.currentPage = visibleIndexPath.row
        }
    }
}

//MARK: UICollectionViewDataSource & UICollectionViewDelegate.
extension CateogriesCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: Number of rows in movie list
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    // MARK: Assign data into UI
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let innerCell = storyCollectionView.dequeueReusableCell(withReuseIdentifier: "InnerCell", for: indexPath) as! InnerCell
        innerCell.layer.cornerRadius = CGFloat(categoriesCellCornerRadius)
        let img = movieArray[indexPath.row].image
        innerCell.movieBannerImage.image = UIImage(named: img)
        innerCell.movieNameLabel.text = movieArray[indexPath.row].name
        return innerCell
    }
    
    // MARK: Change Rows Height and width
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: categoriesWidth, height: categoriesHeight)
        }
        else {
            return CGSize(width: categoriesWidth, height: categoriesHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let innerCell = storyCollectionView.dequeueReusableCell(withReuseIdentifier: "InnerCell", for: indexPath) as! InnerCell
        self.cellDelegate?.cellTap(cellUrl: "")
        
    }
}

