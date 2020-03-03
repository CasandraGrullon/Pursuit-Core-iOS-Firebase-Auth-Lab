//
//  UIViewController+Navigation.swift
//  FirebaseAuth-Lab
//
//  Created by casandra grullon on 3/3/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    private static func resetWindow(rootVC: UIViewController) {
        
        guard let scene = UIApplication.shared.connectedScenes.first,
            let sceneDelegate = scene.delegate as? SceneDelegate,
            let window = sceneDelegate.window else {
                fatalError("could not reset window root vc")
        }
        window.rootViewController = rootVC
    }
    public static func showViewController(storyboardName: String, viewControllerID: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        let newVC = storyboard.instantiateViewController(identifier: viewControllerID)
        resetWindow(rootVC: newVC)
    }
}
