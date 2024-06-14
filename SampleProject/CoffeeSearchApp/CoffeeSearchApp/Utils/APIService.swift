//
//  APIService.swift
//  CoffeeSearchApp
//
//  Created by 석기권 on 6/14/24.
//

import Foundation
import RxSwift

let CoffeeUrl = "https://fake-coffee-api.vercel.app/api"

enum ApiError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
    case failed(Int)
}

class APIService {
    static func fetchAllCoffee() -> Observable<[Coffee]> {
        let response = Observable<[Coffee]>.create { observer in
            guard let url = URL(string: CoffeeUrl) else {
                observer.onError(ApiError.invalidUrl)
                return Disposables.create()
            }
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    observer.onError(error)
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    observer.onError(ApiError.invalidResponse)
                    return
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    observer.onError(ApiError.failed(httpResponse.statusCode))
                    return
                }
                
                guard let data = data else {
                    observer.onError(ApiError.invalidData)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    
                    let coffeeList = try decoder.decode([Coffee].self, from: data)
                    observer.onNext(coffeeList)
                } catch {
                    observer.onError(error)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
        return response
    }
}


