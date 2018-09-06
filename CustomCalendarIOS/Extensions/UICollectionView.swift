//
//  UICollectionView+.swift
//  
//
//  Created by iMac on 16/08/2018.
//  Copyright © 2018 Umair Afzal. All rights reserved.
//

import UIKit

extension UICollectionView {

    func scrollToIndexpathByShowingHeader(_ indexPath: IndexPath) {
        let sections = self.numberOfSections

        if indexPath.section <= sections {
            let attributes = self.layoutAttributesForSupplementaryElement(ofKind: UICollectionElementKindSectionHeader, at: indexPath)
            let topOfHeader = CGPoint(x: 0, y: attributes!.frame.origin.y - self.contentInset.top)
            self.setContentOffset(topOfHeader, animated:false)
        }
    }

}
