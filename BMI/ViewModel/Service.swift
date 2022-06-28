//
//  Service.swift
//  BMI
//
//  Created by Javlonbek iOS Dev on 23/06/22.
//

import Foundation

class Service: NSObject {
    var id = 0
    static let shared = Service()
    
    func loadData(completion: @escaping (Result<[Model], Error>) -> ()) {
        guard let url = URL(string: "https://mimsoft.uz/api/v1/themes") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print("Failed to fetch posts: ", err)
                return
            }
            
            guard let data = data else {
                return
            }
            
            do{
                let posts = try JSONDecoder().decode([Model].self, from: data)
                completion(.success(posts))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func createData(name: String?, student: String?, group: String, completion: @escaping (Error?) -> ()) {
        guard let url = URL(string: "https://mimsoft.uz/api/v1/theme") else {
            print("Invalid URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let params = ["name": name, "student": student, "group": group]
        do {
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            
            URLSession.shared.dataTask(with: urlRequest) { data, resp, err in
                guard data != nil else {
                    return
                }
                completion(nil)
            }.resume()
        } catch {
            completion(error)
        }
    }
    
    func put(id: Int, name: String?, student: String?, group: String, completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: "https://mimsoft.uz/api/v1/theme") else {
            print("Invalid URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        let params = ["id": id, "name": name as Any, "student": student, "group": group] as [String : Any]
        do {
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            
            URLSession.shared.dataTask(with: urlRequest) { data, resp, err in
                guard data != nil else {
                    return
                }
                completion(nil)
            }.resume()
        } catch {
            completion(error)
        }
    }
    
    func findValue(items: [Model], userEmail: String) -> Bool {
        for item in items {
            if item.student ?? "" == userEmail {
                self.id = item.id
                return true
            }
        }
        return false
    }
}
