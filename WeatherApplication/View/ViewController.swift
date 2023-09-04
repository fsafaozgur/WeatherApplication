//
//  ViewController.swift
//  NewsApplication
//
//  Created by Safa on 27.08.2023.
//

import UIKit

class ViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {

    var city : String?
    var cities : [Cities]?
    private var cityTableViewModel : CityTableViewModel?
    
    @IBOutlet weak var tableView: UITableView!
     

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        cities = fetchFromJSON(jsonName: "cities")
        self.cityTableViewModel = CityTableViewModel(cityList: cities!)

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    
        
        
    }
        
    
    func fetchFromJSON (jsonName : String) -> [Cities]? {
        
        if let path = Bundle.main.path(forResource: jsonName, ofType: "json")
     {
         do {
             let url = URL(fileURLWithPath: path)
             let data = try Data(contentsOf: url)
             let jsonData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
             
     
                if let cities = jsonData!["city"] as? [[String:String]] {
                 
                    var cityArray = [Cities]()
                    
                    for item in cities {
                     
                        if let name = item["name"] {
                            let city = Cities(name: name)
                            cityArray.append(city)
                        }
                    }
                    return cityArray
                }
 
            
            }catch {
                 print(error.localizedDescription)
             }
         
     }else {
        print("file cannot be found ")
      }
      
        
     return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        city = cityTableViewModel?.cityList[indexPath.row].name
        performSegue(withIdentifier: "toWeatherVC", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWeatherVC" {
            let destination = segue.destination as! WeatherViewController
            destination.selectedCity = city!
        }
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityTableViewModel?.numberOfRowSection() ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let cityCell = cityTableViewModel?.cellForRowAt(index: indexPath.row)
        cell.textLabel?.text = cityCell?.name
        return cell
    }
    

}

