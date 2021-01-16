import Foundation
import Combine

public enum RickAndMortyRestAPIError: Error {
    case invalidData
}
public struct RickAndMortyRestAPI {
    public static func allCharacters(page: Int) -> Future<FetchCharactersResponse, Error> {
        return .init { promise in
            URLSession.shared.dataTask(with: RickAndMortyURLMaker.characters(page: page).url) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }

                guard let data = data else {
                    return
                }

                guard let fetchCharactersResponse = try? JSONDecoder().decode(FetchCharactersResponse.self, from: data) else {
                    //"{\"error\":\"There is nothing here\"}"
                    promise(.failure(RickAndMortyRestAPIError.invalidData))
                    return
                }

                promise(.success(fetchCharactersResponse))
            }.resume()
        }
    }
}

