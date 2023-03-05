//
// Accountlist.swift
//
// Generated by JSONClassExporter on Mar 01, 2023
//

import Foundation

struct Accountlist: Codable {

    let accountId: String
    let balance: Double
    let billPaymentAllowed: String
    let currency: String
    let iban: String
    let paymentStatus: String
    let tdSetup: String
    let typeBG: String
    let typeEN: String
    let workingbalance: Double
    let multibankingAccount: Bool
    let logoUrl: String?
    let bankId: String?
    let bankName: String?

    enum CodingKeys: String, CodingKey {
    case accountId, balance,  currency, iban, paymentStatus, tdSetup, typeBG, typeEN, workingbalance, multibankingAccount, logoUrl, bankId, bankName

    case billPaymentAllowed = "billPaymentAllowed"
    }
}