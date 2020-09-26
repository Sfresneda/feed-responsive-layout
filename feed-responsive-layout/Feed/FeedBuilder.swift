//
//  FeedBuilder.swift
//  feed-responsive-layout
//
//  Created by Sergio Fresneda on 9/26/20.
//

import Foundation
class FeedBuilder {
    static func build() -> FeedViewController {
        let view = FeedViewController.init()
        let presenter = FeedPresenter.init()
        
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}

