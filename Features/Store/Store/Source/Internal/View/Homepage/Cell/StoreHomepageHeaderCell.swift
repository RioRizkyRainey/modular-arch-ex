//
//  StoreHomepageHeaderCell.swift
//  Store
//
//  Created by Rio Rizky Rainey Ferbiansyah on 22/12/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import UIKitExtension

class StoreHomepageHeaderCell: BaseCell {

    static let name = "StoreHomepageHeaderCell"
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(StoreHomepageBannerCell.name)
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    var disposeBag = DisposeBag()
    
    var viewModel: StoreHomepageHeaderViewModel!
    
    func configure(with viewModel: StoreHomepageHeaderViewModel) {
        self.viewModel = viewModel
        setupObserver()
    }
    
    private func setupObserver() {
        viewModel.images
            .bind(to: collectionView.rx.items) { (collectionView: UICollectionView, row: Int, photo: String) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreHomepageBannerCell.name, for: indexPath) as StoreHomepageBannerCell!
                cell.bannerImageView.setImage(with: photo)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
}
