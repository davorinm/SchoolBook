//
//  StudentsViewModel.swift
//  SchoolBook
//
//  Created by Davorin Madaric on 17/07/2022.
//

import Foundation

class StudentsViewModel: SchoolMembersViewModel {
    var itemsUpdated: (() -> Void)?
    var itemSelected: ((SchoolMemberDetailsViewModel) -> Void)?
    
    private var items: [SchoolMember] = []
    
    init() {
        
    }
    
    func load() {
        
    }
    
    func reload() {
        
    }
    
    
    // MARK: Items
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func itemAtIndex(index: Int) -> SchoolMember? {
        guard items.count < index else {
            return nil
        }
        
        return items[index]
    }
    
    func itemSelected(index: Int) {
        
    }
}
