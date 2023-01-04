//
//  BoxOfficeAPI.swift
//  BoxOffice
//
//  Created by brad on 2023/01/04.
//

import Foundation
import SwiftUI

enum VendorInfo {
    static let key = "d43c612ada006712230e28a87d48913b"
}

enum GetDateType {
    case daily
    case weekly
}

final class BoxOfficeAPI {
    
    private enum BoxOfficeURL {
        static let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice"
        static let dailyJson = "/searchDailyBoxOfficeList.json?"
        static let weeklyJson = "/searchWeeklyBoxOfficeList.json?"
        static let key = "key"
        static let targetDate = "targetDt"
    }
    
    func getBoxOffice(dateType: GetDateType, targetDate: String, completion: @escaping(Result<BoxOfficeList, Error>) -> ()) {
        let session = URLSession(configuration: .ephemeral)
        var urlComponents: URLComponents?
        
        switch dateType {
        case .daily:
            urlComponents = URLComponents(string: BoxOfficeURL.url + BoxOfficeURL.dailyJson)
        case .weekly:
            urlComponents = URLComponents(string: BoxOfficeURL.url + BoxOfficeURL.weeklyJson)
        }
        let key = URLQueryItem(name: BoxOfficeURL.key, value: VendorInfo.key)
        let date = URLQueryItem(name: BoxOfficeURL.targetDate, value: targetDate)
        
        urlComponents?.queryItems = [key, date]
        
        let requestURL = URLRequest(url: (urlComponents?.url)!)
        
        let dataTask = session.dataTask(with: requestURL) { data, response, error in
            if error != nil {
                print(error!)
                return
            }
            
            if let myData = data {
                do {
                    let decodeData = try JSONDecoder().decode(BoxOfficeList.self, from: myData)
                    completion(.success(decodeData))
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        dataTask.resume()
    }
    
    func getBoxOffice2(dateType: GetDateType, targetDate: String, completion: @escaping(Result<BoxOfficeList, Error>) -> ()) {
        let session = URLSession(configuration: .ephemeral)
        var urlComponents: URLComponents?
        
        switch dateType {
        case .daily:
            urlComponents = URLComponents(string: BoxOfficeURL.url + BoxOfficeURL.dailyJson)
        case .weekly:
            urlComponents = URLComponents(string: BoxOfficeURL.url + BoxOfficeURL.weeklyJson)
        }
        let key = URLQueryItem(name: BoxOfficeURL.key, value: VendorInfo.key)
        let date = URLQueryItem(name: BoxOfficeURL.targetDate, value: targetDate)
        
        urlComponents?.queryItems = [key, date]
        
        let requestURL = URLRequest(url: (urlComponents?.url)!)
        
        let dataTask = session.dataTask(with: requestURL) { data, response, error in
            if error != nil {
                print(error!)
                return
            }
            
            if let myData = data {
                do {
                    let decodeData = try JSONDecoder().decode(BoxOfficeList.self, from: myData)
                    completion(.success(decodeData))
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        dataTask.resume()
    }

}
