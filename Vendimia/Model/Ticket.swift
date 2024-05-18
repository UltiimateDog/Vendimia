//
//  Articulo.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 04/03/24.
//

import Foundation
import SwiftUI

struct Ticket: Identifiable {
    var tracking_key: String // 20 characters
    var reciever_account: String // Card Number
    var giver_account: String // Card number
    var reciever_bank: String
    var account_name: String // Name of the one who made the transaction
    var comision: Float
    var IVA_comision: Float
    var concept: String
    var reference: String
    var transaction : String // Type of transaction

    var money_in: Bool // If given or give
    var ticketImage: Image
    var ticket_color: Color
    var ticket_arrow: Image
    
    var date: Date
    
    var quantity: Float
    
    var id: String { tracking_key }
    
    init(tracking_key: String?, reciever_account: String, giver_account: String, reciever_bank: String, account_name: String, comision: Float, concept: String, reference: String, transaction: String, money_in: Bool, date: [Int]?, quantity: Float) {
        self.tracking_key = tracking_key ?? "NULL"
        self.reciever_account = reciever_account
        self.giver_account = giver_account
        self.reciever_bank = reciever_bank
        self.account_name = account_name
        self.comision = comision
        self.IVA_comision = comision * 0.16
        self.concept = concept
        self.reference = reference
        self.transaction = transaction
        self.money_in = money_in
        
        switch transaction {
            case "Seguros":
                self.ticketImage = Image(systemName: "shield.righthalf.filled")
            case "Hipotecas":
                self.ticketImage = Image(systemName: "house.fill")
            case "Servicios públicos":
                self.ticketImage = Image(systemName: "lightbulb.led.fill")
            case "Comercio":
                self.ticketImage = Image(systemName: "dollarsign.arrow.circlepath")
            case "Cuentas de celular":
                self.ticketImage = Image(systemName: "apps.iphone")
            case "Servicio de administración":
                self.ticketImage = Image(systemName: "briefcase.fill")
            case "Pagos futuros":
                self.ticketImage = Image(systemName: "deskclock.fill")
            case "Transferencia":
                self.ticketImage = Image(systemName: "arrow.left.arrow.right.circle")
            default:
                self.ticketImage = Image(systemName: "dollarsign.arrow.circlepath")
        }
                
        self.ticket_color = money_in ? Color.green : Color.red
        self.ticket_arrow = money_in ? Image(systemName: "arrow.up.forward") : Image(systemName: "arrow.down.right")
        
        if date != nil {
            let dateComponents = DateComponents(year: date![0], month: date![1], day: date![2], hour: date![3], minute: date![4])
            let cal = Calendar(identifier: .gregorian)
            self.date = cal.date(from: dateComponents)!
        } else { self.date = Date.now }
        
        self.quantity = quantity
    }

}


struct testTickets {
    let a1 = Ticket(tracking_key: "Hyf9M8KImZE0jFGdrMhB", reciever_account: "4238127575709472", giver_account: "0733980816595683", reciever_bank: "Banorte", account_name: "Rodrigo Espiritu Berra", comision: 0, concept: "Comida", reference: "5736432", transaction: "Comercio", money_in: false, date: [2024, 4, 15, 15, 24], quantity: 230.37)
    let a2 = Ticket(tracking_key: "tcTpOAgNgfjuW1n2hkAv", reciever_account: "5149591859055456", giver_account: "0733980816595683", reciever_bank: "Banorte", account_name: "Rodrigo Espiritu Berra", comision: 0, concept: "Walmart", reference: "3308395", transaction: "Comercio", money_in: false, date: [2024, 4, 15, 18, 41], quantity: 1756.03)
    let a3 = Ticket(tracking_key: "I0WTmMeB7gk1Rtr9uITC", reciever_account: "0733980816595683", giver_account: "9222029689367609", reciever_bank: "Banorte", account_name: "Rodrigo Espiritu Berra", comision: 0, concept: "Quincena", reference: "9334961", transaction: "Transferencia", money_in: true, date: [2024, 4, 15, 22, 03], quantity: 10_000.00)
    let a4 = Ticket(tracking_key: "6pMNwkkLH5PfjMSJtN5c", reciever_account: "5740141309007768", giver_account: "0733980816595683", reciever_bank: "Banorte", account_name: "Rodrigo Espiritu Berra", comision: 0, concept: "Liverpool", reference: "3408973", transaction: "Comercio", money_in: false, date: [2024, 4, 16, 12, 11], quantity: 499.99)
    let a5 = Ticket(tracking_key: "5kCT1RoIE8DpNUp0F3B0", reciever_account: "2304312498584416", giver_account: "0733980816595683", reciever_bank: "Banorte", account_name: "Rodrigo Espiritu Berra", comision: 0, concept: "Liverpool", reference: "0424108", transaction: "Comercio", money_in: false, date: [2024, 4, 16, 14, 20], quantity: 200.00)
    
    let a6 = Ticket(tracking_key: "dWoTN179dqQ5CzK6NYCu", reciever_account: "4238127575709472", giver_account: "0733980816595683", reciever_bank: "Banorte", account_name: "Rodrigo Espiritu Berra", comision: 0, concept: "Comida", reference: "5736432", transaction: "Comercio", money_in: false, date: [2024, 4, 17, 15, 24], quantity: 230.37)
    let a7 = Ticket(tracking_key: "MOqTIQkdzZDdbPhfto9N", reciever_account: "0733980816595683", giver_account: "5149591859055456", reciever_bank: "Banorte", account_name: "Rodrigo Espiritu Berra", comision: 0, concept: "Diviertete", reference: "3308395", transaction: "Transferencia", money_in: true, date: [2024, 4, 20, 18, 41], quantity: 3000.00)
    let a8 = Ticket(tracking_key: "hxXlDdbDEtrItotewowe", reciever_account: "0733980816595683", giver_account: "9222029689367609", reciever_bank: "Banorte", account_name: "Rodrigo Espiritu Berra", comision: 0, concept: "Quincena", reference: "9334961", transaction: "Transferencia", money_in: true, date: [2024, 4, 21, 22, 03], quantity: 10_000.00)
    let a9 = Ticket(tracking_key: "cBZ2l3ppkOshSDJTJDoZ", reciever_account: "5740141309007768", giver_account: "0733980816595683", reciever_bank: "Banorte", account_name: "Rodrigo Espiritu Berra", comision: 0, concept: "Liverpool", reference: "3408973", transaction: "Comercio", money_in: false, date: [2024, 4, 22, 12, 11], quantity: 499.99)
    let a10 = Ticket(tracking_key: "sKLEyx7Gx4l6ip8BZDg8", reciever_account: "2304312498584416", giver_account: "0733980816595683", reciever_bank: "Banorte", account_name: "Rodrigo Espiritu Berra", comision: 0, concept: "Ikea", reference: "0424108", transaction: "Comercio", money_in: false, date: [2024, 4, 22, 14, 20], quantity: 4000.00)
    let a11 = Ticket(tracking_key: "jsF7RcZo2LZu8tUnUtDN", reciever_account: "2304312498584416", giver_account: "0733980816595683", reciever_bank: "Banorte", account_name: "Rodrigo Espiritu Berra", comision: 0, concept: "Palacio de hierro", reference: "0424108", transaction: "Comercio", money_in: false, date: [2024, 4, 22, 15, 30], quantity: 7_000.00)
    
    let testArray: [Ticket]
    
    init() {
        self.testArray = [a11,a10,a9,a8,a7,a6,a5,a4,a3,a2,a1]
    }
    
}
