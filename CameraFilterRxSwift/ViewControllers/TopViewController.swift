//
//  TopViewController.swift
//  CameraFilterRxSwift
//
//  Created by 大西玲音 on 2021/04/18.
//

import UIKit
import RxSwift
import RxCocoa

final class TopViewController: UIViewController {
    
    @IBOutlet private weak var applyFilterButton: UIButton!
    @IBOutlet private weak var photoImageView: UIImageView!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        applyFilterButton.isHidden = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationC = segue.destination as? UINavigationController,
              let photosCVC = navigationC.viewControllers.first as? PhotosViewController else { return }
        photosCVC.selectedPhoto
            .subscribe(onNext: { [weak self] photoImage in
                DispatchQueue.main.async {
                    self?.updateUI(with: photoImage)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func updateUI(with image: UIImage) {
        photoImageView.image = image
        applyFilterButton.isHidden = false
    }
    
    @IBAction private func applyFilterButtonDidTapped(_ sender: Any) {
        guard let sourceImage = photoImageView.image else { return }
        FilterService().applyFilter(to: sourceImage)
            .subscribe(onNext: { filteredImage in
                DispatchQueue.main.async {
                    self.photoImageView.image = filteredImage
                }
            })
            .disposed(by: disposeBag)
    }

}

