//
//  APIService.swift
//  SchoolBook
//
//  Created by Davorin Madaric on 22/07/2022.
//

import UIKit

class SchoolMemberViewCell: UITableViewCell {
    @IBOutlet weak var personImageView: ImageLoaderView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var connectButton: UIButton!
    
    private var action: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        connectButton.setTitle("Connect", for: .normal)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        personImageView.image = nil
        nameLabel.text = nil
        positionLabel.text = nil
        schoolLabel.text = nil
    }
    
    func setData(schoolMember: SchoolMember) {
        personImageView.imageFrom(imageUrl: schoolMember.imageUrl)
        nameLabel.text = schoolMember.name
        positionLabel.text = schoolMember.position
        schoolLabel.text = schoolMember.school
        
        action = schoolMember.action
    }
    
    // MARK: - Actions
    
    @IBAction func connectAction(_ sender: Any) {
        action?()
    }
}
