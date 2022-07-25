//
//  MainTabBarController.swift
//  SchoolBook
//
//  Created by Davorin Madaric on 23/07/2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let techersVC = SchoolMembersViewController.create(viewModel: TeachersViewModel())
        let techersNC = UINavigationController(rootViewController: techersVC)
        techersNC.title = "Teachers"
        techersNC.tabBarItem.image = UIImage(named: "teachersTab")
        
        let studentsVC = SchoolMembersViewController.create(viewModel: StudentsViewModel())
        let studentsNC = UINavigationController(rootViewController: studentsVC)
        studentsNC.title = "Students"
        studentsNC.tabBarItem.image = UIImage(named: "studentsTab")

        viewControllers = [techersNC, studentsNC]
    }
}
