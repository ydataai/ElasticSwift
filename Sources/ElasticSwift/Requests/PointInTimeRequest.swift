import ElasticSwiftCore
import NIOHTTP1
import Foundation

// MARK: - Point In Time Request

public struct PointInTimeRequest: Request {
  public var headers = HTTPHeaders()

    public let indices: [String]
    public let keepAlive: String 

    public init(indices: [String], keepAlive: String){
       self.indices = indices
       self.keepAlive = keepAlive 
    }

    public init(indices: String..., keepAlive: String){
        self.init(indices: indices, keepAlive: keepAlive)
    }

    public var method: HTTPMethod {
        return .POST
    }

    public var endPoint: String {
        var _endPoint = "_pit"
        if !indices.isEmpty {
            _endPoint = indices.joined(separator: ",") + "/" + _endPoint
        }
        return _endPoint
    }

    public var queryParams: [URLQueryItem] {
        return [URLQueryItem(name: QueryParams.keepAlive, value: keepAlive)]
    }

    public func makeBody(_: Serializer) -> Result<Data, MakeBodyError> {
        return .failure(MakeBodyError.noBodyForRequest)
    }
}

extension PointInTimeRequest: Equatable {}

