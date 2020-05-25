//
//  UIViewController + Extension.swift
//  Chatter
//
//  Created by Кирилл Медведев on 20.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func configure<T: SelfConfiguringCell, U: Hashable>(collectionView: UICollectionView, cellType: T.Type, with value: U, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else { fatalError()}
        cell.configure(with: value)
        return cell
    }
}
