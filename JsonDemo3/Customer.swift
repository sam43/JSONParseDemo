//
//  Customer.swift
//  PracticeJson
//
//  Created by Kazi Abdullah Al Mamun on 4/25/17.
//  Copyright © 2017 Kazi Abdullah Al Mamun. All rights reserved.
//

import Foundation

struct CustomerAddress {
    var streetAddress:String
    var city:String
    var state:String
    var postalCode:String
}

struct CustomerphoneNumber {
    var type:String
    var number:String
}

class Customer{
    
    
    var firstName:String?
    var lastName:String?
    var age:Double?
    
    var customerAddress:CustomerAddress?
    var customerPhoneNumbers:[CustomerphoneNumber] = []
    
    init() {
    }
}

extension Customer{
    
    public static func getDataSet() -> [Customer]{
        
        var customerArray:[Customer] = []
        
        do {
            let jsonRoot = try JSONSerialization.jsonObject(with: getData(), options: []) as? [Any]
            
            for customer in jsonRoot!{
                let myCustomer = customer as? [String:Any]
                let customerObj = Customer()
                customerObj.firstName = myCustomer?["firstName"] as? String
                customerObj.lastName = myCustomer?["lastName"] as? String
                customerObj.age = myCustomer?["age"] as? Double
                
                let customerAddressJson = myCustomer?["address"] as? [String:String]
                let customerAddress = CustomerAddress(streetAddress: (customerAddressJson?["streetAddress"])!,
                                                      city: (customerAddressJson?["city"])!,
                                                      state: (customerAddressJson?["state"])!,
                                                      postalCode: (customerAddressJson?["postalCode"])!)
                
                customerObj.customerAddress = customerAddress
                
                let customerPhoneNumberJsonArray = myCustomer!["phoneNumber"] as? [[String:String]]
                
                for phoneNumber in customerPhoneNumberJsonArray!{
                    let customerPhoneNumber = CustomerphoneNumber(type: phoneNumber["type"]!, number: phoneNumber["number"]!)
                    customerObj.customerPhoneNumbers.append(customerPhoneNumber)
                }
                customerArray.append(customerObj)
                print(customerObj.customerPhoneNumbers)
                print(customerObj.customerAddress! )
                print(customerObj.firstName!)
            }
            //print(jsonRoot ?? "nill")
        }catch{
            print(error)
        }
        return customerArray
    }
    
    private static func getFilePath() -> URL {
        let jsonFilePath = Bundle.main.url(forResource: "customer", withExtension: "json")
        return jsonFilePath!
}
    
    private static func getData() -> Data {
        let jsonFilePath = getFilePath()
        var jsonData:Data = Data()
        do {
             jsonData = try Data(contentsOf: jsonFilePath, options: [])
        } catch{
            print(error)
        }
        return jsonData
    }
}
