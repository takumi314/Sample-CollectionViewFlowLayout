//
//  ViewController.swift
//  Sample-CollectionViewFlowLayout
//
//  Created by NishiokaKohei on 05/12/2018.
//  Copyright © 2018 Takumi. All rights reserved.
//

import UIKit

let numberOfSection = 1
let numberOfCell    = 10

class ViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self

    }

}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSection
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCell
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let identifier = "cell"

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CustomCollectionViewCell
        cell.imageView.image = UIImage(named: "picker_cloud")

        return cell
    }

}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        // 選択したセルを中心に移動する
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)

    }

}
