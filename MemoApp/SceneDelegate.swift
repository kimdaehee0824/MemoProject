//
//  SceneDelegate.swift
//  MemoApp
//
//  Created by 김대희 on 2021/06/30.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let context = CoreDataManager .persistentContainer.viewContext
        let store = MemoStore()


        let contentView = MemoListScene()
            .environment(\.managedObjectContext, context)
            .environmentObject(store)
            .environmentObject(DateFormatter.memoDateFormetter)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
     
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
  
    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {
 
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
      
        CoreDataManager.shared.saveContext()
    }


}

