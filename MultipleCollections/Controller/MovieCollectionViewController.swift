//
//  MovieCollectionViewController.swift
//  Multiple Collections
//
//  Created by IPH Technologies on 21/04/22.
//Copyright © 2022 IPH Technologies All rights reserved.

import UIKit
import AVKit
import AVFoundation

// MARK: MovieCollectionViewController 
class MovieCollectionViewController: UIViewController,DataCellDelegate, CategoriesCellDelegate {
    
    //MARK: Collection View outlet
    @IBOutlet weak var homeDataCollectionView: UICollectionView!
    
    var rowCount = 0
    var cateogryArray = [String]()
    
    // MARK: Call before View Controller is Appear
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
        cateogryArray.removeDuplicates()
    }
    
    // MARK: Call when View Controller is Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.layoutIfNeeded()
        self.homeDataCollectionView.setContentOffset(.zero, animated: false)
    }
    
    // MARK: Fetch data from Movie Collection API
    func fetchData() {
        
        guard let path = Bundle.main.path(forResource: "Movies", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            
            if  let object = json as? [Any] {
                for anItem in object as! [Dictionary<String, AnyObject>] {
                    let name = anItem["name"] as! String
                    let image = anItem["imageUrl"] as! String
                    let category = anItem["category"] as! String
                    if !(cateogryArray.contains(category)) {
                        rowCount += 1
                    }
                    cateogryArray.append(category)
                    movieArray.append(MovieData.init(image: image, name: name, category: category))
                }
            } else {
                print("JSON is invalid")
            }
            self.homeDataCollectionView.reloadData()
        } catch {
            print(error)
        }
    }
}

//MARK: UICollectionViewDataSource & UICollectionViewDelegate.
extension MovieCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: Number of rows in cateogry list
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rowCount + 1
    }
    
    // MARK: Assign data into UI
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == 0) {
            let cateogriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CateogriesCell", for: indexPath) as! CateogriesCell
            cateogriesCell.titleLabel.text = "Category"
            cateogriesCell.pageControler.numberOfPages = movieArray.count
            cateogriesCell.cellDelegate = self
            return cateogriesCell
        }
        else {
            let dataCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DataCell", for: indexPath) as! DataCell
            dataCell.titleLabel.text = cateogryArray[indexPath.row - 1]
            // cateogryCell.categoryName = cateogryArray[indexPath.row - 1]
            dataCell.categoryArray = movieArray.filter {$0.category == cateogryArray[indexPath.row - 1]}
            dataCell.cellDelegate = self
            return dataCell
        }
    }
    
    // MARK: Change Rows Height and width
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.row == 0) {
            return CGSize(width: collectionView.frame.width, height: 300)
        }
        else {
            return CGSize(width: collectionView.frame.width, height: 183)
        }
    }
    // Delegate to play video on tap movie image cell
    func cellTap(index: Int, cellUrl: String) {
        //Used demo URL
        self.playVideo(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")
    }
    // Delegate to play video on tap movie image cell
    func cellTap(cellUrl: String) {
        //Used demo URL
        self.playVideo(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")
    }
    // To play video with Url on tap movie image
    func playVideo(url:String){
        let videoURL = NSURL(string:url )
        let player = AVPlayer(url: videoURL! as URL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
}
