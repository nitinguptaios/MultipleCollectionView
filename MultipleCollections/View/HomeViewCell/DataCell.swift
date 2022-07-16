//
//  MovieCollectionViewController.swift
//  Multiple Collections
//
//  Created by IPH Technologies on 21/04/22.
//
//  Copyright © 2022 IPH Technologies All rights reserved.


import UIKit


protocol DataCellDelegate: AnyObject {
    func cellTap(index: Int, cellUrl: String)
}

// MARK: Category Cell
class DataCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var storyCollectionView: UICollectionView!
    
    var cellDelegate : DataCellDelegate?
    var categoryArray = [MovieData]()
    
    // MARK: Number of rows in movie list
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    // MARK: Assign data into UI
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let innerCell = storyCollectionView.dequeueReusableCell(withReuseIdentifier: "InnerCell", for: indexPath) as! InnerCell
        innerCell.layer.cornerRadius = CGFloat(dataCellCornerRadius)
        let img = categoryArray[indexPath.row].image
        innerCell.movieBannerImage.image = UIImage(named: img)
        innerCell.movieNameLabel.text = categoryArray[indexPath.row].name
        return innerCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //can get index & url
        self.cellDelegate?.cellTap(index: indexPath.row, cellUrl: "")
    }
    
    // MARK: Change Rows Height and width
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: dataCellWidth, height: dataCellHeight)
        }
        else {
            return CGSize(width: dataCellWidth, height: dataCellHeight)
        }
    }
}
