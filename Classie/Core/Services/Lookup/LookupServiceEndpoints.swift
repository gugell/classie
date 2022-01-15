//
//  LookupServiceEndpoints.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//
import Moya

enum LookupServiceEndpoints {
    case listings
}

extension LookupServiceEndpoints: TargetType {
    var baseURL: URL {
        return AppEnvironment.baseURL
    }

    var path: String {
        switch self {
        case .listings:
            return "/dynamodb-writer"
        }
    }

    var method: Method {
        return .get
    }

    var encoding: ParameterEncoding {
        return URLEncoding.default
    }

    var task: Task {
        return .requestPlain
    }

    var sampleData: Data {
        switch self {
        case .listings:
            guard let url = Bundle.main.url(forResource: "listings",
                                            withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        }
    }

    var headers: [String: String]? {
        return nil
    }
}
