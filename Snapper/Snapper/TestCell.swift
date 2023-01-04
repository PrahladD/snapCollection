//
//  TestCell.swift
//  Snapper
//
//  Created by Prahlad Dhungana on 2022-11-15.
//

import UIKit

class TestCell: UICollectionViewCell {
    
    @IBOutlet weak var wrapperView: UIView!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var testCellTopConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configure(img: UIImage?) {
        self.img.image = img
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        wrapperView.layer.cornerRadius = bounds.size.height / 2
        wrapperView.layer.borderWidth = 2
        wrapperView.layer.borderColor = UIColor.systemOrange.cgColor
        img.clipsToBounds = true
        img.layer.cornerRadius = (bounds.size.height * 0.9) / 2
        img.backgroundColor = .white
    }
}
