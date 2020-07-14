//
//  AboutViewController.swift
//  PhotoGallery
//
//  Created by Sumo Group on 14/07/20.
//  Copyright © 2020 Sumo Group. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var buildVersion: UILabel!
    @IBOutlet weak var buildTime: UILabel!
    var buildDate: Date {
        if let infoPath = Bundle.main.path(forResource: "Info", ofType: "plist"),
            let infoAttr = try? FileManager.default.attributesOfItem(atPath: infoPath),
            let infoDate = infoAttr[.modificationDate] as? Date {
            return infoDate
        }
        return Date()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let now = df.string(from: buildDate)
        buildTime.text = "Build Time: "+now
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        buildVersion.text = "Version: " + appVersion!
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
