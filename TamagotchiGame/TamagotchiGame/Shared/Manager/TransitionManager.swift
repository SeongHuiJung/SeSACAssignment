//
//  TransitionManager.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/25/25.
//

import UIKit

class TransitionManager {
    static let shared = TransitionManager()
    private init() {}
    
    func getMainTabViewController(reSelect: Bool, tamagotchiType: TamagotchiType) -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .white
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .black
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .lightGray
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        var page1: UINavigationController?
        
        if UserDefaultsManager.tamagotchiTypeIndex == 0 {
            let nav = UINavigationController(rootViewController: OnboardingViewController())
            page1 = nav
        }
        else {
            let viewController = TamagotchiViewController()
            var type = TamagotchiType.none
            if reSelect {
                type = tamagotchiType
            }
            else {
                switch UserDefaultsManager.tamagotchiTypeIndex {
                case 1 : type = .tingling(level: UserDefaultsManager.tamagotchiLevel)
                case 2 : type = .smile(level: UserDefaultsManager.tamagotchiLevel)
                case 3 : type = .twinkle(level: UserDefaultsManager.tamagotchiLevel)
                default: break
                }
            }

            viewController.tamagotchiType.accept(type)
            let nav = UINavigationController(rootViewController: viewController)
            page1 = nav
        }
        
        let page2 = UINavigationController(rootViewController: RequestLottoViewController())
        let page3 = UINavigationController(rootViewController: SearchMovieRankViewController())

        page1!.view.backgroundColor = .white
        page2.view.backgroundColor = .white
        page3.view.backgroundColor = .white
        
        tabBarController.setViewControllers([page1!, page2, page3], animated: true)
        
        if let items = tabBarController.tabBar.items {
            items[0].selectedImage = UIImage(systemName: "star.fill")
            items[0].image = UIImage(systemName: "star")
            
            items[1].selectedImage = UIImage(systemName: "heart.fill")
            items[1].image = UIImage(systemName: "heart")
            
            items[2].selectedImage = UIImage(systemName: "person.fill")
            items[2].image = UIImage(systemName: "person")
        }
        
        tabBarAppearance.backgroundColor = .white
        
        return tabBarController
    }
}
