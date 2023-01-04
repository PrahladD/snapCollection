//
//  CustomCollectionViewLayout.swift
//  Snapper
//
//  Created by Prahlad Dhungana on 2022-11-15.
//

import Foundation
import UIKit

var defaultItemScale: CGFloat = 0.75

class CustomCollectionViewLayout: UICollectionViewFlowLayout {
    // MARK: - Prepare
        
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
       // debugPrint(minimumLineSpacing)
        minimumLineSpacing = 5
        let leftSpacing = (collectionView!.bounds.size.width / 2) - 30
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: leftSpacing, bottom: 0, right: leftSpacing)
        invalidateLayout()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var copyAttributes: [UICollectionViewLayoutAttributes] = []
        
        for attribute in attributes ?? [] {
            if let copy = attribute.copy() as? UICollectionViewLayoutAttributes {
                updateLayoutChange(copy)
                copyAttributes.append(copy)
            }
      }
        
        return copyAttributes
    }
    
    // so the layout is called again with new bounds
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {

        return true

    }
    
    private func updateLayoutChange(_ attributes:  UICollectionViewLayoutAttributes) {
        guard let collectionView = collectionView else { return }
        
        let collectionViewCenter = collectionView.frame.size.width / 2
        let horizontalOffset = collectionView.contentOffset.x
        let actualCenter = attributes.center.x - horizontalOffset
        
        let maxDistance = itemSize.width - minimumLineSpacing
        let actualDistance = abs(collectionViewCenter - actualCenter)
        let scaleDistance = min(actualDistance, maxDistance)

        
        if (actualCenter + maxDistance) <= (collectionViewCenter - (80 )) {
            let ratio = (maxDistance - scaleDistance) / maxDistance
            
            let scale = 0.6 + ratio * (1 - 0.6)

            attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1 )
        } else if  (actualCenter - maxDistance) >= (collectionViewCenter + 80)  {
            let ratio = (maxDistance - scaleDistance) / maxDistance
            
            let scale = 0.6 + ratio * (1 - 0.6)
            
            attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        }
        else  {
            
            let ratio = (maxDistance - scaleDistance) / maxDistance
            
            let scale = defaultItemScale + ratio * (1 - defaultItemScale)
            
            attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        }
        
        
        
    }
}
