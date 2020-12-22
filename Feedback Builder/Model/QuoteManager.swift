//
//  QuoteManager.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-12-22.
//

import Foundation
protocol GetQuoteDelegate{
    func todaysQuote(quote:String)
}
class QuoteManager{
    
    var getQuoteDelegate : GetQuoteDelegate?
    
    func getDailyQuotes(){
       
      
        
        let url = URL(string: "https://staging.quotable.io/random")
        let session = URLSession(configuration: .default)
        if let finalUrl = url{
            let task = session.dataTask(with: finalUrl) { (data, resoponse, error) in
                if let currentError = error{
                    print(currentError)
                }
                else{
                    if let safeData = data{
                       let quote = (parseJSON(safeData))
                        self.getQuoteDelegate?.todaysQuote(quote: quote)
                    }
                }
            }
            task.resume()
        }
    
    }
    
}

func parseJSON(_ quoteData:Data)->String{
    let decoder = JSONDecoder()

    do{
        let response = try decoder.decode(QuoteData.self, from: quoteData)
        print(response)
        return response.content
       
    
    }catch{
        print(error)
        return "Error"
        
    }
    
}
