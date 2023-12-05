//
//  ViewController.swift
//  NewsApplication
//
//  Created by Safa on 27.08.2023.
//

import UIKit
import Combine

class ViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {

    var city : String?
    private var cityTableViewModel : CityTableViewModel?
    private var cancellable : Set<AnyCancellable> = []
    var viewModel : MainViewModel = MainViewModel()
    
    @IBOutlet weak var tableView: UITableView!
     

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.fetchFromJSON()

        viewModel.$cityList
            .sink { cities in
                
                self.cityTableViewModel = CityTableViewModel(cityList: cities)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            .store(in: &cancellable)
        

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

