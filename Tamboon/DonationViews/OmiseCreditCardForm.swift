//
//  CreditCardForm.swift
//  Tamboon
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import OmiseSDK
import SwiftUI
import TamboonModel

public struct OmiseCreditCardFormWrapper: UIViewControllerRepresentable {
    
    let donationsViewModel: DonationViewModel
    
    public func makeUIViewController(context: Context) -> OmiseCreditCardForm {
        let omiseCreditCardForm = OmiseCreditCardForm(donationsViewModel: donationsViewModel)

        return omiseCreditCardForm
    }

    public func updateUIViewController(_ uiViewController: OmiseCreditCardForm, context: Context) {

    }
}

public class OmiseCreditCardForm: UIViewController {
    
    private let publicKey = "pkey_test_5jt7wzlwesogyowyugv"
    let donationsViewModel: DonationViewModel
    
    init(donationsViewModel: DonationViewModel) {
        self.donationsViewModel = donationsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presentCreditCardForm()
    }
    
    private func presentCreditCardForm() {
        let creditCardViewController = createCreditCardForm()
        
        self.addChild(creditCardViewController)
        guard let creditCardView = creditCardViewController.view else { return }
        self.view.addSubview(creditCardView)
        
        creditCardView.translatesAutoresizingMaskIntoConstraints = false
        creditCardView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        creditCardView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        creditCardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        creditCardView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
    
    private func createCreditCardForm() -> CreditCardFormViewController {
        let creditCardViewController = CreditCardFormViewController.makeCreditCardFormViewController(withPublicKey: publicKey)
        creditCardViewController.delegate = self
        creditCardViewController.handleErrors = true
        
        return creditCardViewController
    }
    
}

extension OmiseCreditCardForm: CreditCardFormViewControllerDelegate {
    
    public func creditCardFormViewController(_ controller: CreditCardFormViewController, didSucceedWithToken token: Token) {
        print(token)
        //donationsViewModel.placeDonation(name: token.card.name, token: <#T##String#>, amount: token.card.)
        
    }
    
    public func creditCardFormViewController(_ controller: CreditCardFormViewController, didFailWithError error: Error) {
        print(error)
    }
    
    public func creditCardFormViewControllerDidCancel(_ controller: CreditCardFormViewController) {
        
    }
    
    
}
