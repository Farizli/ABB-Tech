//
//  FirstVM.swift
//  Rick-and-Morty-
//
//  Created by Ali  Farizli  on 30.10.22.
//

import Foundation

class FirstVM {
    
    var success: ((ApiData?) -> Void)?
    var error: ((_ message: String) -> Void)?
    
    
    func getChars(page: Int, name: String = "", species: String = "", gender: String = "", state: String = "") {
        let string = "https://rickandmortyapi.com/api/character?page=\(page)" + (name != "" ? "&name=\(name)" : "") + (species != "" ? "&species=\(species)" : "")
        + (gender != "" ? "&gender=\(gender)" : "") + (state != "" ? "&state=\(state)" : "")
        
        guard let url = URL(string: string) else {return}
        
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
}
