//
//  CollectionViewCell.swift
//  Bottle Rocket
//
//  Created by Teodora Mratinkovic on 12/9/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var restaurant: Restaurant? {
        didSet {
           updateView()
        }
    }
    
    fileprivate func updateView() {
        
        if let imageUrl = restaurant?.backgroundImageURL {
            backgroundImage.loadImage(fromURL: imageUrl)
        }
        nameLabel.text = restaurant?.name
        categoryLabel.text = restaurant?.category
    }
    
    
    override func prepareForReuse() {
        
        nameLabel.text = ""
        categoryLabel.text = ""
        backgroundImage.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
