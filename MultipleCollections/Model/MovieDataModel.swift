//
//  FirstDataModel.swift
//  Multiple Collections
//
//  Created by IPH Technologies on 21/04/22.
//
//  Copyright © 2022 IPH Technologies All rights reserved.

import Foundation

struct MovieData {
    let image: String
    let name: String
    let category: String
    
    func getStaticData() -> [MovieData] {
        let movieDataArray = [MovieData]()
        return movieDataArray
    }
}

var movieArray = [MovieData]()

