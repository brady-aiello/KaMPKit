//
//  SceneDelegate.swift
//  KaMPKitiOS
//
//  Created by Brady Aiello on 7/10/21.
//  Copyright © 2021 Touchlab. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIHostingController(rootView: Text("Hello"))
        window?.makeKeyAndVisible()
    }
}
