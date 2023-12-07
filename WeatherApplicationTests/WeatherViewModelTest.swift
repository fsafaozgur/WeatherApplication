//
//  WeatherViewModelTest.swift
//  WeatherApplicationTests
//
//  Created by Safa on 23.10.2023.
//

import XCTest
@testable import WeatherApplication
import Combine



class WeatherViewModelTest: XCTestCase {
    
    var viewModel : WeatherViewModel!
    var testWeather : [Weather]?
    private var cancellable : Set<AnyCancellable>!

    
    override func setUp() {
        super.setUp()
        
        //using MockWebService object instead of WebService object to load data locally for pretending datas that normally being fetched from web
        viewModel = WeatherViewModel(service: MockWebService())
        cancellable = []
    }
    

    override func tearDown() {
        super.tearDown()
        viewModel = nil
        cancellable = []
    }

    func testFetchDatasSuccessfully() throws {
    
        
        let expectation = XCTestExpectation(description: "fetching datas")
        
        //load datas
        self.viewModel.fetchDatas(city: "AnyCity")
        
        //wait until the end of loading using Combine
        viewModel.$testObject
            .sink { values in
                
                //testing whether two datas in Cities.json being received or not
                XCTAssertEqual(values?.count, 2)
                //mark the expectation as fulfilled
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        //In case of not being fulfilled, add a timeout to expectation
        wait(for: [expectation], timeout: 2)

        
    }
    
    func testTrToEngSuccessfully() throws {
    

        //testing that translating characters from Turkish to English successfully
        XCTAssertEqual(self.viewModel.trToEng(string: "Gümüşhane"), "gumushane")
        
    }


}
