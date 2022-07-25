//
//  SchoolMembersViewModel.swift
//  SchoolBook
//
//  Created by Davorin Madaric on 23/07/2022.
//

import Foundation

struct SchoolMember {
    let id: Int
    let name: String
    let imageUrl: String
    let school: String
    let position: String
    let details: String?
    let action: (() -> Void)?
}

protocol SchoolMembersViewModel {
    var itemsUpdated: (() -> Void)? { get set }
    var itemSelected: ((SchoolMemberDetailsViewModel) -> Void)? { get set }
    
    func load()
    func reload()
    func numberOfItems() -> Int
    func itemAtIndex(index: Int) -> SchoolMember?
}
