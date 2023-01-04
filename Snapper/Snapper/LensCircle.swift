//
//  LensCircle.swift
//  Snapper
//
//  Created by Prahlad Dhungana on 2022-11-16.
//

import Foundation
import UIKit


class LensCircleCell: UICollectionViewCell {
  
  static let identifier = "LensCell"
  private let imageView = UIImageView()
  private let blackBorderView = UIView()
  
  var image: UIImage? {
    didSet {
      guard let image = image else { return }
      imageView.image = image
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpViews() {
    
    contentView.addSubview(blackBorderView)
    blackBorderView.translatesAutoresizingMaskIntoConstraints = false
    
    blackBorderView.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.backgroundColor = .clear
    
    contentView.addConstraints([
      NSLayoutConstraint(item: blackBorderView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: blackBorderView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: blackBorderView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: blackBorderView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
      ])
    
    blackBorderView.backgroundColor = .gray
    blackBorderView.layer.cornerRadius = 36
    
    contentView.addConstraints([
      NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: blackBorderView, attribute: .centerX, multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: blackBorderView, attribute: .centerY, multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: blackBorderView, attribute: .width, multiplier: 0.98, constant: 0.0),
      NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: blackBorderView, attribute: .height, multiplier: 0.98, constant: 0.0)
      ])
    
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 35
    imageView.layer.borderColor = UIColor.white.cgColor
    imageView.layer.borderWidth = 3
  }
}

