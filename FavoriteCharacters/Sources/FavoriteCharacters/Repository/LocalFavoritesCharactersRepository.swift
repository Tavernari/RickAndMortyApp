//
//  LocalFavoritesCharactersRepository.swift
//  
//
//  Created by Victor C Tavernari on 19/01/21.
//

import Foundation
import Shared
import Combine

class LocalFavoritesCharactersRepository: FavoritesCharactersRepository {

    static let storageKey = "storage.characters"
    static let userDefaults = UserDefaults.standard

    private var cancellable: AnyCancellable?
    private func fetchProcessAndSave(action:@escaping ([Character])->[Character],
                                 onError:@escaping (Error)->Void,
                                 onFinished:@escaping ()->Void) {
        cancellable?.cancel()
        cancellable = self.get().sink { (completion) in
            switch completion {
            case .failure(let error):
                onError(error)
            case .finished:
                onFinished()
            }
        } receiveValue: { characters in
            let characters = action(characters)
            do {
                try self.saveLocal(characters)
            } catch {
                onError(error)
            }
        }
    }

    func save(character: Character) -> Future<Void, Error> {
        return Future<Void, Error> { promise in
            self.fetchProcessAndSave { characters in
                var characters = characters
                if !characters.contains(where: {$0.id == character.id}) {
                    characters.append(character)
                }
                return characters
            } onError: { promise(.failure($0))
            } onFinished: { promise(.success(()))}
        }
    }

    func saveLocal(_ characters: [Character]) throws {
        let encodeData = try PropertyListEncoder().encode(characters)
        LocalFavoritesCharactersRepository
            .userDefaults
            .set(encodeData, forKey: LocalFavoritesCharactersRepository.storageKey)
    }

    func remove(character: Character) -> Future<Void, Error> {
        return Future<Void, Error> { promise in

            self.fetchProcessAndSave { characters in
                var characters = characters
                characters.removeAll(where: {$0.id == character.id})
                return characters
            } onError: { promise(.failure($0))
            } onFinished: { promise(.success(()))}
        }
    }

    func get() -> Future<[Character], Error> {
        return Future<[Character], Error> { promise in
            do {
                if let data = LocalFavoritesCharactersRepository
                    .userDefaults
                    .value(forKey: LocalFavoritesCharactersRepository.storageKey) as? Data {
                let characters = try PropertyListDecoder().decode(Array<Character>.self, from: data)
                    promise(.success(characters))
                } else {
                    promise(.success([]))
                }
            } catch {
                promise(.failure(error))
            }
        }
    }
}
