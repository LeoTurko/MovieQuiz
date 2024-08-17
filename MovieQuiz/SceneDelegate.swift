//
//  SceneDelegate.swift
//  MovieQuiz
//
//  Created by Леонид Турко on 21.05.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let scene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: scene)
    window?.rootViewController = MovieQuizViewController()
    window?.makeKeyAndVisible()
  }
}

