//
//  PhotoCollectionViewCell.swift
//  CameraFilterRxSwift
//
//  Created by 大西玲音 on 2021/04/18.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    static var identifier: String {
        return String(describing: self)
    }
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    @IBOutlet private weak var imageView: UIImageView!
    
    func configure(image: UIImage) {
        imageView.image = image
    }
}
