//
//  ApplicationController.swift
//  RobustaTask
//
//  Created by Assem on 14/10/2022.
//

import Foundation

import UIKit

public class ApplicationController {
    
    public var window: UIWindow
    let navBar = UINavigationController()

    public init(window: UIWindow) {
        self.window = window
    }

    public func loadInitialView() {
        navBar.viewControllers = [ViewControllerProvider.repositoriesViewController]
        window.rootViewController = navBar
        window.makeKeyAndVisible()
    }
}
