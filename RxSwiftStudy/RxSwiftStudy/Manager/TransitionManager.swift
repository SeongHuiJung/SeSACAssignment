//
//  TransitionManager.swift
//  RxSwiftStudy
//
//  Created by 정성희 on 8/19/25.
//

import UIKit

class TransitionManager {
    static let shared = TransitionManager()
    private init() {}
    
    func getMainTabViewController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .white
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .black
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .lightGray
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        let page1 = UINavigationController(rootViewController: HomeworkViewController())
        let page2 = UINavigationController(rootViewController: SimpleTableViewExampleViewController())
        let page3 = UINavigationController(rootViewController: NumbersViewController())
        let page4 = UINavigationController(rootViewController: SimpleValidationViewController())
        
        page1.view.backgroundColor = .white
        page2.view.backgroundColor = .white
        page3.view.backgroundColor = .white
        page3.view.backgroundColor = .white
        
        tabBarController.setViewControllers([page1, page2, page3, page4], animated: true)
        
        if let items = tabBarController.tabBar.items {
            items[0].selectedImage = UIImage(systemName: "star.fill")
            items[0].image = UIImage(systemName: "star")
            
            items[1].selectedImage = UIImage(systemName: "heart.fill")
            items[1].image = UIImage(systemName: "heart")
            
            items[2].selectedImage = UIImage(systemName: "person.fill")
            items[2].image = UIImage(systemName: "person")
            
            items[3].selectedImage = UIImage(systemName: "rectangle.portrait.and.arrow.right.fill")
            items[3].image = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        }
        
        tabBarAppearance.backgroundColor = .white
        
        return tabBarController
    }
}
