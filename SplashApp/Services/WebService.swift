//
//  WebService.swift
//  SplashApp
//
//  Created by Baya Walid on 03/10/2022.
//

import Foundation

public class WebService {
    let apiKey = "-f7ejw_gbW7eNP3eWuqPaLLZN2ygcMKtRXcnPl_FXzc"
    let apiUrl = "https://api.unsplash.com/"
    
    func searchFor(query: String, completion: @escaping (PhotosModel?) -> ()) {
        
        let url = URL(string :"\(apiUrl)search/photos?query=\(query)")!
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(format:"Client-ID %@",apiKey), forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        session.dataTask(with: request as URLRequest) { data, urlResponse, error in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let result = try! jsonDecoder.decode(PhotosModel.self, from: data)
                completion(result)
            } else {
                completion(nil)
            }
            
        }.resume()
    }
    
}
