//
//  ProductsViewController.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 28/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {

    /// Properties
    var orderTicketViewController: OrderTicketViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        orderTicketViewController = nil
    }
    
    @IBAction func buyButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: ProductsViewController.self))
        guard let orderTicketViewController = storyboard
            .instantiateViewController(identifier: "OrderTicketViewController")as? OrderTicketViewController
            else { return }
        
        orderTicketViewController.orderTicketViewModel = OrderTicketViewModel()
        
        orderTicketViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(orderTicketViewController, animated: false, completion: nil)
        self.orderTicketViewController = orderTicketViewController
    }
}
