//
//  OrderTicketViewModel.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 28/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import UIKit

protocol OrderTicketViewProtocol {
    func viewDidLoad()
    func viewDidAppear()
}

class OrderTicketViewModel {
    
    // MARK: - Public routines
    init() { }

}

extension OrderTicketViewModel: OrderTicketViewProtocol {
    func viewDidLoad() {
        /// Call Service
    }
    
    func viewDidAppear() {}
}
