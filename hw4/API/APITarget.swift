//
//  APITarget.swift
//  HW4
//
//  Created by Ян Козыренко on 08.07.2023.
//

import Moya

enum APITarget {
    case fetchData
}


extension APITarget: TargetType {
    var baseURL: URL {
        URL(string: "https://rickandmortyapi.com/api")!
    }
    var path: String {
        "/character"
    }
    var method: Method {
        .get
    }
    var sampleData: Data {
        Data()
    }
    var task: Task {
        .requestPlain
    }
    var headers: [String : String]? {
        ["Content-Type" : "application/json"]
    }
}
