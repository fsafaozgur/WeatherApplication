//
//  WeatherCell.swift
//  WeatherApplication
//
//  Created by Safa on 2.09.2023.
//

import UIKit

class WeatherCell: UITableViewCell {

    
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var cityCell: UILabel!
    @IBOutlet weak var descriptionCell: UILabel!
    @IBOutlet weak var currentTempCell: UILabel!
    @IBOutlet weak var maxTempCell: UILabel!
    @IBOutlet weak var minTempCell: UILabel!
    @IBOutlet weak var nightTempCell: UILabel!
    @IBOutlet weak var humidityCell: UILabel!
    @IBOutlet weak var dateCell: UILabel!
    @IBOutlet weak var dayCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
