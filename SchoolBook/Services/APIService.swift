//
//  APIService.swift
//  SchoolBook
//
//  Created by Davorin Madaric on 22/07/2022.
//

import Foundation
import Combine

protocol APIService {
    func fetchTeachersFuture() -> Future<[Teacher], NetworkError>
    func fetchTeacherPublisher(teacherId: Int) -> AnyPublisher<TeacherDetails, NetworkError>
    func fetchSchoolFuture(schoolId: Int) -> Future<School, NetworkError>
    
    func fetchTeachers(completion: @escaping (Result<[Teacher], NetworkError>) -> Void)
    func fetchStudents(completion: @escaping (Result<[Student], NetworkError>) -> Void)
    func fetchSchool(schoolId: Int, completion: @escaping (Result<School, NetworkError>) -> Void)
    func fetchTeacher(teacherId: Int, completion: @escaping (Result<TeacherDetails, NetworkError>) -> Void)
    func fetchStudent(studentId: Int, completion: @escaping (Result<StudentDetails, NetworkError>) -> Void)
}

class APIServiceImpl: APIService {
    
    func fetchTeachersFuture() -> Future<[Teacher], NetworkError> {
        Future { promise in
            self.fetchTeachers { result in
                promise(result)
            }
        }
    }
    
    func fetchTeacherPublisher(teacherId: Int) -> AnyPublisher<TeacherDetails, NetworkError> {
        Future<TeacherDetails, NetworkError> { promise in
            self.fetchTeacher(teacherId: teacherId) { result in
                promise(result)
            }
        }.eraseToAnyPublisher()
    }
    
    
    
    func fetchSchoolFuture(schoolId: Int) -> Future<School, NetworkError> {
        Future { promise in
            self.fetchSchool(schoolId: schoolId) { result in
                promise(result)
            }
        }
    }
    
    func fetchTeachers(completion: @escaping (Result<[Teacher], NetworkError>) -> Void) {
        let urlString = Environment.current.apiBaseURL + "teachers"
        guard let url = URL(string: urlString) else {
            assertionFailure("Check url: \(urlString)")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTaskHandler(with: request) { result in
            completion(self.decodeJson(result: result))
        }.resume()
    }
    
    func fetchStudents(completion: @escaping (Result<[Student], NetworkError>) -> Void) {
        let urlString = Environment.current.apiBaseURL + "students"
        guard let url = URL(string: urlString) else {
            assertionFailure("Check url: \(urlString)")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTaskHandler(with: request) { result in
            completion(self.decodeJson(result: result))
        }.resume()
    }
    
    func fetchSchool(schoolId: Int, completion: @escaping (Result<School, NetworkError>) -> Void) {
        let urlString = Environment.current.apiBaseURL + "schools/" + String(schoolId)
        guard let url = URL(string: urlString) else {
            assertionFailure("Check url: \(urlString)")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTaskHandler(with: request) { result in
            completion(self.decodeJson(result: result))
        }.resume()
    }
    
    func fetchTeacher(teacherId: Int, completion: @escaping (Result<TeacherDetails, NetworkError>) -> Void) {
        let urlString = Environment.current.apiBaseURL + "teachers/" + String(teacherId)
        guard let url = URL(string: urlString) else {
            assertionFailure("Check url: \(urlString)")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTaskHandler(with: request) { result in
            completion(self.decodeJson(result: result))
        }.resume()
    }
    
    func fetchStudent(studentId: Int, completion: @escaping (Result<StudentDetails, NetworkError>) -> Void) {
        let urlString = Environment.current.apiBaseURL + "students/" + String(studentId)
        guard let url = URL(string: urlString) else {
            assertionFailure("Check url: \(urlString)")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTaskHandler(with: request) { result in
            completion(self.decodeJson(result: result))
        }.resume()
    }
    
    // Decoders
    
    private func decodeJson<T: Decodable>(result: Result<Data, NetworkError>) -> Result<T, NetworkError> {
        result.flatMap { data in
            Result { try JSONDecoder().decode(T.self, from: data) }
                .mapError {
                    NetworkError.decodingError($0)
                }
        }
    }
}
