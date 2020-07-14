//
//  AppModel.swift
//  PhotoGallery
//
//  Created by Sumo Group on 14/07/20.
//  Copyright © 2020 Sumo Group. All rights reserved.
//

import Foundation

class AppModel {
    public static let sharedInstance = AppModel()
    var cloudDataModel: jsonDomObject?
    func modelInit() {
        let url = "https://api.imgur.com/"
        cloudDataModel = jsonDomObject(reqUrl: url)
        cloudDataModel!.getDataFromCloud(reqUrl: url) { (result, error) in
            if (result != nil) {
                print(result)
            }
        }
    }
}
