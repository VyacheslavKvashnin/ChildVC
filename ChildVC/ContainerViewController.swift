//
//  ContainerViewController.swift
//  ChildVC
//
//  Created by Вячеслав Квашнин on 01.08.2022.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed

    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    var navVC: UINavigationController?
    lazy var infoVC = InfoViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildsVC()
        
    }
    
    private func addChildsVC() {
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapButtonMenu() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .opened:
            UIView.animate(
                withDuration: 0.2,
                delay: 0.1,
                options: .curveEaseInOut) {
                    self.navVC?.view.frame.origin.x = 0
                } completion: { [weak self] done in
                    if done {
                        self?.menuState = .closed
                        DispatchQueue.main.async {
                            completion?()
                        }
                    }
                }
        case .closed:
            UIView.animate(
                withDuration: 0.2,
                delay: 0.1,
                options: .curveEaseInOut) {
                    self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
                } completion: { [weak self] done in
                    if done {
                        self?.menuState = .opened
                    }
            }

        }
    }
}

extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuViewController.MenuOption) {
        toggleMenu(completion: nil)
        
        switch menuItem {
            
        case .home:
            self.resetToHome()
        case .info:
            self.addInfo()
        case .appRating:
            break
        case .shareApp:
            break
        case .setting:
            break
        }
    }
    
    func addInfo() {
        
        let vc = infoVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
    }
    
    func resetToHome() {
        infoVC.view.removeFromSuperview()
        infoVC.didMove(toParent: nil)
        homeVC.title = "Home"
    }
}
