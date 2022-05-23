//
//  MainViewControllerCellTableViewCell.swift
//  MVVM+Coordinator
//
//  Created by Жеребцов Данил on 17.05.2022.
//

import UIKit

class MainViewControllerCellTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.descriptionLabel.text = nil
    }    
}
