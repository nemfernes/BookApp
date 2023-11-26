//
//  UICollectionView.swift
//  BookApp
//
//  Created by Dmitry Kirpichev on 23.11.2023.
//

import Foundation
import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(cellClass: T.Type) where T: Reusable {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func centerContentHorizontalyByInsetIfNeeded(minimumInset: UIEdgeInsets) {
            guard let layout = collectionViewLayout as? UICollectionViewFlowLayout,
                layout.scrollDirection == .horizontal else {
                    assertionFailure("\(#function): layout.scrollDirection != .horizontal")
                    return
            }

            if layout.collectionViewContentSize.width > frame.size.width {
                contentInset = minimumInset
            } else {
                contentInset = UIEdgeInsets(top: minimumInset.top,
                                            left: (frame.size.width - layout.collectionViewContentSize.width) / 2,
                                            bottom: minimumInset.bottom,
                                            right: 0)
            }
        }

    func register<T: UICollectionReusableView>(
        viewClass: T.Type,
        forSupplementaryViewOfKind kind: String
    ) where T: Reusable {
        register(
            T.self,
            forSupplementaryViewOfKind: kind,
            withReuseIdentifier: T.defaultReuseIdentifier
        )
    }

    func dequeueReusableCell<T: UICollectionViewCell>(
        for indexPath: IndexPath
    ) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: T.defaultReuseIdentifier,
            for: indexPath
        ) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }

        return cell
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
        ofKind kind: String,
        for indexPath: IndexPath
    ) -> T where T: Reusable {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: T.defaultReuseIdentifier,
            for: indexPath
        ) as? T else {
            fatalError(
                "Could not dequeue supplementary view" +
                        "with identifier: \(T.defaultReuseIdentifier)"
            )
        }

        return view
    }
}

extension UITableView {
    func register<T: UITableViewCell>(cellClass: T.Type) where T: Reusable {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(
        for indexPath: IndexPath
    ) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(
            withIdentifier: T.defaultReuseIdentifier,
            for: indexPath
        ) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }

        return cell
    }

    func dequeueReusableHeaderFooterView<T: UIView>() -> T? where T: Reusable {
        self.dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier) as? T
    }

    func register<T: Reusable>(headerFooterClass: T.Type) {
        self.register(headerFooterClass, forHeaderFooterViewReuseIdentifier: headerFooterClass.defaultReuseIdentifier)
    }
}
