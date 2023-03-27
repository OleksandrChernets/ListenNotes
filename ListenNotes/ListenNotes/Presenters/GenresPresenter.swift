//
//  GenresPresenter.swift
//  ListenNotes
//
//  Created by Alexandr Chernets on 27.03.2023.
//
import Foundation

protocol GenresView: AnyObject {
    func display(_ genres: [Genre])
    func display(isLoading: Bool)
}

class GenresPresenter {
    weak var view: GenresView?
    
    func onRefresh() {
        print("onRefresh")
        view?.display(isLoading: true)
        let request = URLRequest(url: URL(string: "https://listen-api-test.listennotes.com/api/v2/genres")!)
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(GenreResult.self, from: data)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.view?.display(result.genres)
                    self.view?.display(isLoading: false)
                }
            } catch {
                print("DECODING ERROR \(error)")
                DispatchQueue.main.async {
                    self.view?.display(isLoading: false)
                }
            }
        }
        task.resume()
    }
    func onSelect(_ genre: Genre) {
        print("SELECTED \(genre)")
    }
}
