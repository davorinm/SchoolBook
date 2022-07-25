//
//  SchoolMemberDetailsViewController.swift
//  SchoolBook
//
//  Created by Davorin Madaric on 22/07/2022.
//

import UIKit

class SchoolMemberDetailsViewController: UIViewController {
    private var viewModel: SchoolMemberDetailsViewModel!
}

extension SchoolMemberDetailsViewController {
    class func create(viewModel: SchoolMemberDetailsViewModel) -> SchoolMemberDetailsViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SchoolMemberDetailsViewController") as! SchoolMemberDetailsViewController
        vc.viewModel = viewModel
        return vc
    }
}
