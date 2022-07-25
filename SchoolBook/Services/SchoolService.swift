//
//  SchoolService.swift
//  SchoolBook
//
//  Created by Davorin Madaric on 17/07/2022.
//

import Foundation
import Combine

protocol SchoolService {
    var teachers: CurrentValueSubject<[Teacher], Error> { get }
    var students: CurrentValueSubject<[SchoolMember], Error> { get }

    func loadTeachers()
    func loadStudents()
}

class SchoolServiceImpl: SchoolService {
    let teachers = CurrentValueSubject<[Teacher], Error>([])
    let students = CurrentValueSubject<[SchoolMember], Error>([])
    
    private var subscribers = Set<AnyCancellable>()
    private var cachedTeachers: [Teacher] = []
    private var cachedSchools: [School] = []
    
    func loadTeachers() {
        fetchTeachers()
            .flatMap(fetchTeachersDetails)
            .flatMap(fetchSchools)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: processTeachers)
            .store(in: &subscribers)
    }
    
    func loadStudents() {
        let apiService: APIService! = AwesomeDIContainer.shared.get()
        apiService.fetchStudents { result in
            print(result)
        }
        
    }
    
    // MARK: - Helpers
    
    private func fetchTeachers() -> Future<[Teacher], NetworkError> {
        let apiService: APIService! = AwesomeDIContainer.shared.get()
        return apiService.fetchTeachersFuture()
    }
    
    private func fetchTeachersDetails(teachers: [Teacher]) -> AnyPublisher<[Teacher], NetworkError> {
        Publishers.Sequence(sequence: teachers.map { self.fetchTeacherDetail(teacher: $0) })
            .flatMap(maxPublishers: .max(1)) { $0 }
            .collect()
            .eraseToAnyPublisher()
    }
    
    private func fetchTeacherDetail(teacher: Teacher) -> AnyPublisher<Teacher, Never> {
        let apiService: APIService! = AwesomeDIContainer.shared.get()
        return apiService.fetchTeacherPublisher(teacherId: teacher.id)
            .compactMap {
                var teacher2 = teacher
                teacher2.details = $0.description
                return teacher2
            }
            .replaceError(with: teacher)
            .eraseToAnyPublisher()
    }
    
    private func fetchSchools(data: [Teacher]) -> Future<[Teacher], NetworkError> {
        Future { promise in
        
        
            promise(.success(data))
        }
    }
    
    private func processTeachers(teachers: [Teacher]) {
        self.teachers.send(teachers)
    }
}
