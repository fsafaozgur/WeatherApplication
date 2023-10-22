//
//  WebServiceTest.swift
//  WeatherApplicationTests
//
//  Created by Safa on 22.10.2023.
//

import XCTest
@testable import WeatherApplication

class WebServiceTest: XCTestCase {

    /*
     Test seneryomuzda, uygulamayi programatik olarak calistiriyor ve bunu yaparken Mock sinifimizi kullaniyoruz, boylece normalde internetten gelen veriyi taklit ederek bir local JSON dosyasi kullanarak verileri uygulamamiza yolluyor ve bunu tuketmesini sagliyoruz, bu sekilde test islemimizi yapiyoruz
     */
    
    
    
    var viewController : WeatherViewController!

    
    override func setUpWithError() throws {
        super.setUp()
        
        //Storyboard seciyoruz
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //Programatik olarak bir WeatherViewController olusturuyoruz
        viewController = storyboard.instantiateViewController(withIdentifier: "WeatherVC") as? WeatherViewController
        //Test yapacagimiz icin Mock sinifimizi initialize ediyoruz
        viewController.service = MockWebService()
        
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
    

    func testExample() throws {
           
        //Verileri WeatherViewController objemizin fetchDatas() fonksiyonu ile cekiyoruz
        self.viewController.fetchDatas()
       
        //MockWeather.json dosyamizi okumamiz sonucunda TableView, 2 adet veri ile doldurulacagi icin bunu test ediyoruz
        DispatchQueue.main.async {
            XCTAssertEqual(self.viewController.weatherTableViewModel?.weatherList.count, 2)
        }
            

    }

    

}
