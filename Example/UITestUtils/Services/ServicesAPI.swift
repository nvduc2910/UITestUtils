//
//  ServicesAPI.swift
//  demo_uitest
//
//  Created by Duckie N on 3/17/20.
//  Copyright © 2020 Nguyen Van Duc. All rights reserved.
//

import Foundation
import UIKit

protocol ServicesAPIType {
    
    func getBooks(completionHandler: @escaping ([Book]) -> ())
    func deleteBooks(completionHandler: @escaping (Int) -> ())
    func login(username: String, password: String, completionHandler: @escaping (String) -> ())
}

open class ServicesAPI: ServicesAPIType {
    
    public static let shared = ServicesAPI()
    
    init() { }
    
    private var baseURL: String?
    
    public func configureBaseURL(_ baseURL: String) {
        self.baseURL = baseURL
    }
    
    func login(username: String, password: String, completionHandler: @escaping (String) -> ()) {
        
        guard let baseURL = baseURL else {
            completionHandler("")
            return
        }
        
        guard let url = URL(string: "\(baseURL)/login") else {
            completionHandler("")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                if let result = json as? NSDictionary {
                    if let accessToken = result["acess_token"] as? String{
                        completionHandler(accessToken)
                    } else {
                        completionHandler("")
                    }
                }
            } catch let err {
                print("Err", err)
            }}.resume()
    }
    
    func getBooks(completionHandler: @escaping ([Book]) -> ()) {
        
        guard let baseURL = baseURL else {
            completionHandler([])
            return
        }
        
        guard let url = URL(string: "\(baseURL)/books") else {
            completionHandler([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                if let result = json as? [NSDictionary] {
                    var books: [Book] = []
                    for item in result {
                        
                        if let id = item["id"] as? Int, let name = item["name"] as? String {
                            let bookItem = Book(id: id, name: name)
                            books.append(bookItem)
                        }
                    }
                    completionHandler(books)
                    
                }
            } catch let err {
                print("Err", err)
            }}.resume()
    }
    
    func deleteBooks(completionHandler: @escaping (Int) -> ()) {
        
        guard let baseURL = baseURL else {
            completionHandler(0)
            return
        }
        
        guard let url = URL(string: "\(baseURL)/books/delete/") else {
            completionHandler(0)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                if let result = json as? NSDictionary {
                    if let id = result["status"] as? Int {
                        completionHandler(id)
                    } else {
                        completionHandler(0)
                    }
                }
            } catch let err {
                print("Err", err)
            }}.resume()
    }
}
