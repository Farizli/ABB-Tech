//
//  FirstVM.swift
//  Rick-and-Morty-
//
//  Created by Ali  Farizli  on 30.10.22.
//

import Foundation

class FirstVM {
    var successOnNext: ((ApiData?) -> Void)?
    var success: ((ApiData?) -> Void)?
    var error: ((_ message: String) -> Void)?
    var page = 1
    
    
    func getChars(title: String = "", text: String = "") {
        self.page = 1
        let string = "https://rickandmortyapi.com/api/character?page=\(page)&\(title.lowercased())=\(text)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print("urlll", string)
        guard let url = URL(string: string ?? "") else {return}
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                print(error!)
                return
            }
            if let safeData = data{
                do{
                    let decodedData = try JSONDecoder().decode(ApiData.self, from: safeData)
                    self.success?(decodedData)
                }catch{
                    self.error?(error.localizedDescription)
                }
                
            }
        }
        session.resume()
    }
    
    func getNextChars(title: String = "", text: String = "") {
        self.page += 1
        let string = "https://rickandmortyapi.com/api/character?page=\(page)&\(title.lowercased())=\(text)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print("urlll", string)
        guard let url = URL(string: string ?? "") else {return}
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                print(error!)
                return
            }
            if let safeData = data{
                do{
                    let decodedData = try JSONDecoder().decode(ApiData.self, from: safeData)
                    self.successOnNext?(decodedData)
                }catch{
                    self.error?(error.localizedDescription)
                }
                
            }
        }
        session.resume()
    }
}
