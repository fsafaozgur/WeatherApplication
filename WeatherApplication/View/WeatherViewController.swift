//
//  WeatherViewController.swift
//  WeatherApplication
//
//  Created by Safa on 1.09.2023.
//

import UIKit



class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    
    @IBOutlet weak var tableView: UITableView!
    
    
    

    var selectedCity = "ankara"
    var weatherTableViewModel : WeatherTableViewModel?


    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        
       fetchData()
        
    }
    

    
     
    func fetchData () {
        
        
        let headers = [
          "content-type": "application/json",
          "authorization": "apikey 2Wyw6ntUnM0ljtfOkuEAuX:7rekZl5MYoDe2h6fnawju4"
        ]
        
        //Ucretsiz uyelik oldugu icin apikey gizlenmedi

        
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=\(trToEng(string: selectedCity))")! as URL,cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        
        
        WebService().getWeatherDatas(request: request as URLRequest) { (weather) in
            
            if let weather = weather {
                self.weatherTableViewModel = WeatherTableViewModel(weatherList: weather)
              
                
                //Internetten gelen veriler pekcok faktor sebebiyle gecikmeli gelebilecegi icin biz veriler geldikten sonra asenkron olarak calisarak tabloyu yenilemesi icin yenileme kodlarini main thread icerisine gonderiyoruz
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                
            }
        }
        
        
    }
        
        
      
    
    
    //WebService kullanmayarak ve haliyle decodable ViewModel kullanmayarak veriyi cekmek istesek boyle bir fonksiyon kullanabiliriz
    func fetchDataWithoutWebservice() {
            
        
        let headers = [
          "content-type": "application/json",
          "authorization": "apikey 2Wyw6ntUnM0ljtfOkuEAuX:7rekZl5MYoDe2h6fnawju4"
        ]
        //Ucretsiz uyelik oldugu icin apikey gizlenmedi


        let request = NSMutableURLRequest(url: NSURL(string: "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=\(trToEng(string: selectedCity))")! as URL,cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error?.localizedDescription)
          } else {
            if let data = data {
                do{
                    if let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any]{
                
                        if let array = dictionary["result"] as? [[String:String]]
                        {
                    
                            var weatherArray = [Weather]()
                    
                    
                            for dict in array {
                                
                                   
                                if let status = dict["status"],
                                   let degree = dict["degree"],
                                   let min = dict["min"],
                                   let night = dict["night"],
                                   let day = dict["day"],
                                   let humidity = dict["humidity"],
                                   let date = dict["date"],
                                   let description = dict["description"],
                                   let max = dict["max"],
                                   let icon = dict["icon"]
                                {
                      
                                let weather = Weather(status: status, degree: degree, min: min, max: max, night: night, day: day, humidity: humidity, date: date, description: description, icon: icon)
                                        
                                weatherArray.append(weather)
                                    
                            }
                    
                    
                
                        }
                    
                        self.weatherTableViewModel = WeatherTableViewModel(weatherList: weatherArray)
                    

                    
                        //Yenileme islemini bir fonksiyon icerisinde degil main thread icerisinde yapilmasi uyarisinda bulundugu icin yenileme islemi uygulanmak uzere main thread icerisine gonderilmektedir
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }

                    }
            }}catch{}
            }
            
            
            
          }
        })

        dataTask.resume()

    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherTableViewModel == nil ? 0 : weatherTableViewModel!.numberOfRowsInSection()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WCell", for: indexPath) as! WeatherCell
        
        let weatherCell = weatherTableViewModel?.cellForRowAt(index: indexPath.row)
        
        cell.cityCell.text = selectedCity
        
        cell.dayCell.text = weatherCell?.day
        
        cell.dateCell.text = weatherCell?.date
        
        cell.currentTempCell.text = "Anlik: \(weatherCell!.degree) °"
        
        cell.descriptionCell.text = weatherCell?.description
        
        cell.maxTempCell.text = "Maksimum: \(weatherCell!.max) °"
        
        
        cell.minTempCell.text = "Minimum: \(weatherCell!.min) °"
        
        cell.nightTempCell.text = "Gece: \(weatherCell!.night) °"
        
        
        cell.humidityCell.text = "Nem: % \(weatherCell!.humidity)"
        
        let urlString = weatherCell?.icon
        
        if let imageUrl = URL( string: urlString!) {
        
        
            do {
                let imageData = try Data(contentsOf: imageUrl)
                cell.imageViewCell.image = UIImage(data: imageData)
            
            } catch {
                print(error.localizedDescription)
            }
        }
        
        
        return cell
    }
    
        
        
    
    func trToEng (string : String) -> String {
        let string = string.lowercased()
    .replacingOccurrences(of: "ı", with: "i")
    .replacingOccurrences(of: "ğ", with: "g")
    .replacingOccurrences(of: "ç", with: "c")
    .replacingOccurrences(of: "ş", with: "s")
    .replacingOccurrences(of: "ü", with: "u")
    .replacingOccurrences(of: "ö", with: "o")
  
    return string
    }
    
}
