//
//  TeachersViewModel.swift
//  SchoolBook
//
//  Created by Davorin Madaric on 17/07/2022.
//

import Foundation
import Combine

class TeachersViewModel: SchoolMembersViewModel {
    var itemsUpdated: (() -> Void)?
    var itemSelected: ((SchoolMemberDetailsViewModel) -> Void)?
    
    private var items: [SchoolMember] = []
    private var subscribers = Set<AnyCancellable>()
    
    init() {
        let schoolService: SchoolService! = AwesomeDIContainer.shared.get()
        schoolService.teachers.sink { completion in
            switch completion {
            case .finished:
                print("finished")
            case .failure(let error):
                print(error)
            }
        } receiveValue: { value in
            print(value)
            self.items = value.map { teacher in
                SchoolMember(id: teacher.id,
                             name: teacher.name,
                             imageUrl: teacher.image_url,
                             school: "ninin",
                             position: teacher.subject,
                             details: teacher.details,
                             action: { self.schoolMemberSelected(id: teacher.id) })
            }
            self.itemsUpdated?()
        }.store(in: &subscribers)
    }
    
    deinit {
        subscribers.forEach { $0.cancel() }
    }
    
    // MARK: - Loaders
    
    func load() {
        let schoolService: SchoolService = AwesomeDIContainer.shared.get()!
        schoolService.loadTeachers()
    }
    
    func reload() {
        let schoolService: SchoolService = AwesomeDIContainer.shared.get()!
        schoolService.loadTeachers()
    }
    
    // MARK: Items
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func itemAtIndex(index: Int) -> SchoolMember? {
        guard index < items.count else {
            return nil
        }
        
        return items[index]
    }
    
    // MARK: - Actions
    
    private func schoolMemberSelected(id: Int) {
        let viewModel: SchoolMemberDetailsViewModel = TeacherDetailsViewModel(id: id)
        itemSelected?(viewModel)
    }
    
    private func itemSelected(index: Int) {
        
    }
}
