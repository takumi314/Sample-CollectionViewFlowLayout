//
//  CustomCollectionViewFlowLayout.swift
//  Sample-CollectionViewFlowLayout
//
//  Created by NishiokaKohei on 05/12/2018.
//  Copyright © 2018 Takumi. All rights reserved.
//

import UIKit

final class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {

    struct Settings {
        static let kMinimumInteritemSpacing: CGFloat    = 20.0      // セル間隔
        static let kItemWidth: CGFloat                  = 120.0       // セル幅サイズ
        static let kItemHeight: CGFloat                 = 250.0     // セル高さサイズ
        static let kFlickVelocityThreshold: CGFloat     = 0.2       //
    }


    override func awakeFromNib() {
        super.awakeFromNib()

        self.itemSize = CGSize(width: Settings.kItemWidth, height: Settings.kItemHeight)
        self.minimumLineSpacing = CGFloat(Settings.kMinimumInteritemSpacing)

        // スクロール方向
        self.scrollDirection = .horizontal

        //
        let horizontalInset = (UIScreen.main.bounds.width - Settings.kItemWidth) / 2
        let verticalInset   = (UIScreen.main.bounds.height - Settings.kItemHeight) / 2

        self.sectionInset = UIEdgeInsets(top: verticalInset,
                                         left: horizontalInset,
                                         bottom: verticalInset,
                                         right: horizontalInset)

    }

    // MARK: - Override

    ///
    /// スクロール後の停止位置を返却する
    ///
    /// @param proposedContentOffset スクロールの早さから推測される停止位置
    /// @param velocity              1秒あたりの移動距離 (単位:ポイント)
    ///
    /// @return proposedContentOffset の代わりの contentOffset
    ///
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        // 指を離したタイミングでのページ番号
        let currentPage = self.collectionView!.contentOffset.x / pageWidth

        // velocity.x が閾値より大きい場合 (アイテムを左右にフリックした場合)
        if abs(velocity.x) > Settings.kFlickVelocityThreshold  {
            // velocity.x が正の場合は、currentPage を切り上げた値を「スクロール先のページ番号」とする (負の場合はその逆)
            let nextPage = velocity.x > 0.0 ? ceil(currentPage) : floor(currentPage)
            // 「スクロール先のページ番号」と「ページ幅」を掛けて contentOffset.x を計算する
            // contentOffset.y は proposedContentOffset.y をそのまま設定
            return CGPoint(x: (nextPage * pageWidth), y: proposedContentOffset.y)

        } else {
            // velocity.x が閾値以下の場合 (アイテムをドラッグした後に指を離した場合)

            // currentPage を四捨五入して「スクロール先のページ番号」とする
            // contentOffset は「velocity.x が閾値より大きい場合」と同様に計算
            return CGPoint(x: (round(currentPage) * pageWidth), y: proposedContentOffset.y)
        }

    }




    // MARK: - Private

    /// ページ幅
    var pageWidth: CGFloat {
        return itemSize.width + minimumLineSpacing
    }
}
