//
//  MockMoyaProvider.swift
//  Classie
//
//  Created by Ilia Gutu on 16.01.2022.
//

import Moya

enum MockMoyaProvider {

    typealias ResponseClosure = () -> EndpointSampleResponse

    static func mocked<Target: TargetType>(ofType type: Target.Type,
                                           responseTime: TimeInterval = 0.3,
                                           statusCode: Int = 200,
                                           mockData: Data = Data(),
                                           errorMessage: String? = nil) -> MoyaProvider<Target> {
        return MoyaProvider<Target>(endpointClosure: { target -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: getEndpointSampleClosure(statusCode, mockData, errorMessage),
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }, stubClosure: getStubClosure(from: responseTime))
    }

    /// Determine if needs a delayed stubbing from given response time
    private static func getStubClosure<Target: TargetType>(from responseTime: TimeInterval) -> ((Target) -> StubBehavior) {
        return responseTime > 0 ? MoyaProvider.delayedStub(responseTime) : MoyaProvider.immediatelyStub
    }

    private static func getEndpointSampleClosure(_ statusCode: Int,
                                                 _ mockData: Data,
                                                 _ errorMessage: String?) -> Endpoint.SampleResponseClosure {
        return {
            if let errorMessage = errorMessage {
                let error = NSError(domain: "com.classie.app",
                                    code: -1234,
                                    userInfo: [NSLocalizedDescriptionKey: errorMessage])
                return .networkError(error)
            }

            return .networkResponse(statusCode, mockData)
        }
    }
}
