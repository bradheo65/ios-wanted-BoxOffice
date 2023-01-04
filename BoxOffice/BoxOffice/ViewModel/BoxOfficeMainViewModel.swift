//
//  BoxOfficeMainViewModel.swift
//  BoxOffice
//
//  Created by brad on 2023/01/04.
//

import Foundation
import SwiftUI

protocol BoxOfficeListProtocol {
    var movieList: [DailyBoxOfficeList] { get }
    var images: [UIImage] { get }
    
    func fetchDailyBoxOfficeList(dateType: GetDateType, targetDate: String)
}

final class BoxOfficeListViewModel: ObservableObject, BoxOfficeListProtocol {
    
    var boxOfficeAPI = BoxOfficeAPI()
    
    @Published var movieList = [DailyBoxOfficeList]()
    @Published var images = [UIImage]()
    
    let url =  ["https://m.media-amazon.com/images/M/MV5BYjhiNjBlODctY2ZiOC00YjVlLWFlNzAtNTVhNzM1YjI1NzMxXkEyXkFqcGdeQXVyMjQxNTE1MDA@._V1_SX300.jpg", "https://m.media-amazon.com/images/M/MV5BMjE4MDdmYjItZThiOC00MjMzLTg2NjgtMWNiNWNkZWYxMmViXkEyXkFqcGdeQXVyNTczOTM5MTQ@._V1_SX300.jpg",
        "",
        "https://m.media-amazon.com/images/M/MV5BYjhiNjBlODctY2ZiOC00YjVlLWFlNzAtNTVhNzM1YjI1NzMxXkEyXkFqcGdeQXVyMjQxNTE1MDA@._V1_SX300.jpg",
        "https://m.media-amazon.com/images/M/MV5BYjhiNjBlODctY2ZiOC00YjVlLWFlNzAtNTVhNzM1YjI1NzMxXkEyXkFqcGdeQXVyMjQxNTE1MDA@._V1_SX300.jpg",
        "https://m.media-amazon.com/images/M/MV5BYjhiNjBlODctY2ZiOC00YjVlLWFlNzAtNTVhNzM1YjI1NzMxXkEyXkFqcGdeQXVyMjQxNTE1MDA@._V1_SX300.jpg",
        "https://m.media-amazon.com/images/M/MV5BYjhiNjBlODctY2ZiOC00YjVlLWFlNzAtNTVhNzM1YjI1NzMxXkEyXkFqcGdeQXVyMjQxNTE1MDA@._V1_SX300.jpg",
        "https://m.media-amazon.com/images/M/MV5BYjhiNjBlODctY2ZiOC00YjVlLWFlNzAtNTVhNzM1YjI1NzMxXkEyXkFqcGdeQXVyMjQxNTE1MDA@._V1_SX300.jpg",
        "https://m.media-amazon.com/images/M/MV5BYjhiNjBlODctY2ZiOC00YjVlLWFlNzAtNTVhNzM1YjI1NzMxXkEyXkFqcGdeQXVyMjQxNTE1MDA@._V1_SX300.jpg",
        "https://m.media-amazon.com/images/M/MV5BYjhiNjBlODctY2ZiOC00YjVlLWFlNzAtNTVhNzM1YjI1NzMxXkEyXkFqcGdeQXVyMjQxNTE1MDA@._V1_SX300.jpg"]
    
    func fetchDailyBoxOfficeList(dateType: GetDateType, targetDate: String) {
        boxOfficeAPI.getBoxOffice(dateType: dateType, targetDate: targetDate) { (response) in
            switch response {
            case .success(let boxOfficeData):
                let decodeData = boxOfficeData
                DispatchQueue.main.async {
                    self.movieList = decodeData.boxOfficeResult.dailyBoxOfficeList
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func getYesterdayDate() -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        
        let date = dateFormatter.date(from: Date().translateToString())
        let beforeDay = calendar.date(byAdding: .day, value: -1, to: date ?? Date())
        
        return beforeDay?.translateToString() ?? ""
    }
}
