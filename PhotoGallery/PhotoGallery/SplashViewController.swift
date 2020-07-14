//
//  SplashViewController.swift
//  PhotoGallery
//
//  Created by Sumo Group on 14/07/20.
//  Copyright © 2020 Sumo Group. All rights reserved.
//

import UIKit
import Photos

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkPhotoAccess()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    func checkPhotoAccess() {
        var authStatus = false
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    authStatus = true
                } else {
                    let alert = UIAlertController(title: "Photos Access Denied", message: "App needs access to photos library.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        } else if photos == .authorized {
            authStatus = true
        }
        if authStatus{
            goToVC()
        }
    }
    func goToVC() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(viewController, animated: true)
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
