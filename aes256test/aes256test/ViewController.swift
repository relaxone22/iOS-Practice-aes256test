//
//  ViewController.swift
//  aes256test
//
//  Created by TDCC_IFD on 2020/10/13.
//  Copyright © 2020 TDCC_IFD. All rights reserved.
//

import UIKit
import CryptoSwift

class ViewController: UIViewController {
    // 測試資料
    private let hexKeyString = "B639AF7DC503C1F45E56198851D02DFECF837D73EBFAC5D8D1897035964C88F7"
    // IV (HEX) 544443434F50454E544F42414E4B4956
    private let ivString =  "TDCCOPENTOBANKIV"
    // 本文(HEX) EX1:41313233343536373839,A123456789
    private let plainText = "A123456789"
    // 密文(HEX) EX1:1764AF1A366F32AC869453C86FB2BBA6
    private let encryptText = "1764AF1A366F32AC869453C86FB2BBA6"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aes256Encrypt()
        aes256decrypt()
        
        
    }

    // CBC/PKCS5Padding
    private func aes256Encrypt() {
        do {
            let hexArray = Array<UInt8>.init(hex: hexKeyString)
            let plain = Array(plainText.utf8)
            let iv = Array(ivString.utf8)
            let encrypted = try AES(key: hexArray, blockMode: CBC(iv: iv), padding: .pkcs5).encrypt(plain)
            
            
            print(encrypted.toHexString().uppercased())
        } catch {
            print(error)
        }
    }
    
    private func aes256decrypt() {
        do {
        let hexArray = Array<UInt8>.init(hex: hexKeyString)
        let iv = Array(ivString.utf8)
        let encrypted = Array<UInt8>.init(hex: encryptText)
        let decrypted = try AES(key: hexArray, blockMode: CBC(iv: iv), padding: .pkcs5).decrypt(encrypted)
        
        let str = String(bytes: decrypted, encoding: String.Encoding.utf8)
        print(str ?? "error")
        } catch {
            print(error)
        }
    }

}

