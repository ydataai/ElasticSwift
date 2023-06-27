import ElasticSwiftCore
import Foundation
import NIOHTTP1

// MARK: - Point In Time Request

public struct PointInTimeRequest: Request, Equatable {
  public var headers = HTTPHeaders()

  public let indices: [String]
  public let keepAlive: String

  public init(indices: [String], keepAlive: String) {
    self.indices = indices
    self.keepAlive = keepAlive
  }

  public init(indices: String..., keepAlive: String) {
    self.init(indices: indices, keepAlive: keepAlive)
  }

  public var method: HTTPMethod {
    return .POST
  }

  public var endPoint: String {
    let pitEndPoint = "_pit"

    guard !indices.isEmpty else {
        return pitEndPoint
    }

    return indices.joined(separator: ",") + "/" + pitEndPoint
  }

  public var queryParams: [URLQueryItem] {
    return [URLQueryItem(name: QueryParams.keepAlive, value: keepAlive)]
  }

  public func makeBody(_: Serializer) -> Result<Data, MakeBodyError> {
    return .failure(MakeBodyError.noBodyForRequest)
  }
}
