//
//  BindableView.swift
//  BooksMVVM
//
//  Created by L Daniel De San Pedro on 16/02/22.
//

import Foundation

protocol BindableView {
    associatedtype bindableData
    var changedValue: (() -> ())? { get set }
    // Func that should be triggerd to notify the viewModel
    func valueChanged()
    // The binding fucntion where the conneciton from the view model to the view should be stablished.
    func bind(to observable: Observable<bindableData>)
}

