//
//  AppDelegate.swift
//  PhotoGallery
//
//  Created by Sumo Group on 14/07/20.
//  Copyright © 2020 Sumo Group. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

/*
 ** jsonDomObject abstracts GET requests to various endpoints and translating
 ** the JSON data to appropriate data sructures. "getDataFromCloud()" method makes the
 ** request to get the JSON. subsequent calls can be made to get data and count
 ** of the JSON data received.
 ** Request for data is to be passed from right to left to identify the key / value node
 ** RootNode, Index, Key will featch the value of [rootnode][index][key].value
 */

public class jsonDomObject {
    private var m_gotData:Bool
    private var m_url: String
    private let m_BaseUrl: String
    private var m_swiftyJsonVar : JSON
    private var m_swiftyJsonArray : [JSON]
    
    init(reqUrl : String){
        m_gotData = false
        m_url = reqUrl
        m_BaseUrl = ""
        m_swiftyJsonVar = JSON.null
        m_swiftyJsonArray = []
    }
    
    
    init(){
        m_gotData = false
        m_url = ""
        m_BaseUrl = ""
        m_swiftyJsonVar = JSON.null
        m_swiftyJsonArray = []
    }
    func getDataFromCloud(callBack: @escaping (Bool)->Void) -> Void {
        assert(!m_url.isEmpty,"getDataFromCloud URL null")
        
        Alamofire.request(self.m_url).responseJSON { (responseData) -> Void in
            print("GETDC",responseData)
            switch responseData.result {
            case .success:
                if((responseData.result.value) != nil) {
                    self.m_swiftyJsonVar = JSON(responseData.result.value!)
                    callBack(true)
                }else {
                    callBack(false)
                }
            case .failure(let error):
                // assertionFailure("request failed")
                callBack(false)
            }
        }
    }

    func getDataFromCloud(endPointUrl:String, callBack: @escaping (Bool)->Void) -> Void {
        assert(!m_url.isEmpty,"getDataFromCloud URL null")
        Alamofire.request(endPointUrl).responseJSON { (responseData) -> Void in
            switch responseData.result {
            case .success:
                if((responseData.result.value) != nil) {
                    self.m_swiftyJsonVar = JSON(responseData.result.value!)
                    callBack(true)
                }else {
                    callBack(false)
                }
            case .failure(let error):
                // assertionFailure("request failed")
                callBack(false)
            }
        }
    }
    func getDataFromCloud(reqUrl:String, callBack: @escaping (JSON?, NSError?)->Void) -> Void {
        assert(!m_url.isEmpty,"getDataFromCloud URL null")
        Alamofire.request(reqUrl).responseJSON { (responseData) -> Void in
            switch responseData.result {
            case .success:
                if((responseData.result.value) != nil) {
                    self.m_swiftyJsonVar = JSON(responseData.result.value!)
                    callBack(JSON(responseData.result.value!), nil)
                }else {
                    // callBack()
                }
            case .failure(let error):
                // assertionFailure("request failed")
                callBack(nil,error as NSError)
            }
        }
    }
    
    private func getString(rootKey: String)->String {
        return self.m_swiftyJsonVar[rootKey].stringValue
    }
    
    private func getString(rootKey: String, secondKey: String)->String {
        return self.m_swiftyJsonVar[rootKey][secondKey].stringValue
    }
    // used
    func getString(rootKey: String, index: Int, leafKey: String)->String {
        return self.m_swiftyJsonVar[rootKey][index][leafKey].stringValue
    }
    
    func getString(rootKey: String, secondKey: String, thirdKey: String)->String {
        return self.m_swiftyJsonVar[rootKey][secondKey][thirdKey].stringValue
    }
    func getAsDictionaryKeys() -> [String]{
        var myKeyArray = [String]()
        for value in (self.m_swiftyJsonVar.dictionary?.keys)! {
            myKeyArray.append(value)
        }
       return myKeyArray
    }
    func getAsDictionaryValues() -> [String]{
        var myKeyArray = [String]()
        for value in (self.m_swiftyJsonVar.dictionary?.values)! {
            myKeyArray.append(value.string!)
        }
        return myKeyArray
    }
    // used to count dates from server
    func getNumElementsDictionary() -> Int {
        var myKeyArray = [String]()
        for value in (self.m_swiftyJsonVar.dictionary?.keys)! {
            myKeyArray.append(value)
        }
        return myKeyArray.count
    }

    func getAsDictionaryKeys() -> [String:Any]{
        return self.m_swiftyJsonVar.dictionary!
    }
    
    
    func getAsDictionaryKeys() -> [String:String]{
        var newDict = [String:String]()
        let myDict = self.m_swiftyJsonVar.dictionary!
        for myString in myDict {
            let myValue = myString.value.description // jsonToString(json: myString.value)
            newDict.updateValue(myValue, forKey: myString.key)
        }
        return newDict
    }
    

    private func jsonToString(json: AnyObject) -> String {
        var convertedString = ""
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            convertedString = String(data: data1, encoding: String.Encoding.utf8) ?? "" // the data will be converted to the string
            // print(convertedString ?? "defaultvalue")
        } catch let myJSONError {
            print(myJSONError)
        }
        return convertedString
    }
    
    func getString(rootKey: String, index: Int, secondKey: String, thirdKey: String)->String {
        return self.m_swiftyJsonVar[rootKey][index][secondKey][thirdKey].stringValue
    }
    func getString(rootKey: String, index: Int, secondKey: String, thirdKey: String, fourthKey: String)->String {
        return self.m_swiftyJsonVar[rootKey][index][secondKey][thirdKey][fourthKey].stringValue
    }
    func getString(rootKey: String, index: Int, secondKey: String, thirdKey: String, fourthKey: String, fifthKey: String)->String {
        return self.m_swiftyJsonVar[rootKey][index][secondKey][thirdKey][fourthKey][fifthKey].stringValue
    }
    func getString(rootKey: String, index: Int, secondKey: String, thirdKey: String, fourthKey: String, fifthKey: String, sixthKey: String)->String {
        return self.m_swiftyJsonVar[rootKey][index][secondKey][thirdKey][fourthKey][fifthKey][sixthKey].stringValue
    }
    
    private func getStringFromArray(rootKey: String, index: Int)->String? {
        if (self.m_swiftyJsonVar[rootKey].arrayValue.count > index){
            return self.m_swiftyJsonVar[rootKey][index].stringValue
        }else
        {
            return nil
        }
    }
    
    func getStringFromArray(rootKey: String,
                                    index: Int,
                                    leafKey: String)->String? {
        return self.m_swiftyJsonVar[rootKey][index][leafKey].stringValue
    }
    func getNumElements(rootKey:String) -> Int {
        return (self.m_swiftyJsonVar[rootKey].arrayValue.count)
    }
    
    private func getStringFromArray(rootKey: String,
                                    secondKey: String,
                                    index: Int)->String {
        return self.m_swiftyJsonVar[rootKey][index][secondKey].stringValue
    }
    
    private func getStringFromArray(rootKey: String,
                                    secondKey: String,
                                    thirdKey: String,
                                    index: Int)->String {
        return (self.m_swiftyJsonVar[rootKey][secondKey][thirdKey].arrayValue[index]).stringValue
    }
    
    private func getIntFromArray(rootKey: String, index: Int)->Int {
        return (self.m_swiftyJsonVar[rootKey].arrayValue[index]).intValue
    }
    
    private func getIntFromArray(rootKey: String, secondKey: String, index: Int)->Int {
        return (self.m_swiftyJsonVar[rootKey][secondKey].arrayValue[index]).intValue
    }
    
    private func getStringFromArray(rootKey: String, secondKey: String, thirdKey: String, index: Int)->Int {
        return (self.m_swiftyJsonVar[rootKey][secondKey][thirdKey].arrayValue[index]).intValue
    }
    
    private func getStringArray(rootKey: String)->[String] {
        var retArray = [String]()
        for (jsonVal) in (self.m_swiftyJsonVar[rootKey].arrayValue){
            retArray.append(jsonVal.stringValue)
        }
        return retArray
    }
    
    private func getStringArray(rootKey: String, secondKey: String)->[String] {
        var retArray = [String]()
        for (jsonVal) in (self.m_swiftyJsonVar[rootKey][secondKey].arrayValue){
            retArray.append(jsonVal.stringValue)
        }
        return retArray
    }
    
    private func getNStringArray(rootKey: String, secondKey: String, thirdKey: String)->[String] {
        var retArray = [String]()
        for (jsonVal) in (self.m_swiftyJsonVar[rootKey][secondKey][thirdKey].arrayValue){
            retArray.append(jsonVal.stringValue)
        }
        return retArray
    }
    
    private func getInt(rootKey: String)->Int {
        return self.m_swiftyJsonVar[rootKey].intValue
    }
    
    private func getInt(rootKey: String, secondKey: String)-> Int {
        return self.m_swiftyJsonVar[rootKey][secondKey].intValue
    }
    func getInt(rootKey: String, index: Int, secondKey: String)-> Int {
        return self.m_swiftyJsonVar[rootKey][index][secondKey].intValue
    }
    func getInt(rootKey: String, index: Int, secondKey: String, thirdKey: String)->Int
    {
        return self.m_swiftyJsonVar[rootKey][index][secondKey][thirdKey].intValue
    }
    func getInt(rootKey: String, index: Int, secondKey: String, thirdKey: String, fourthKey: String)->Int
    {
        let value = self.m_swiftyJsonVar[rootKey][index][secondKey][thirdKey][fourthKey].intValue
        return value
    }
    private func getInt(rootKey: String, secondKey: String, thirdKey: String)->Int {
        return self.m_swiftyJsonVar[rootKey][secondKey][thirdKey].intValue
    }
    
    private func getBool (rootKey: String, secondKey: String, thirdKey: String)->Bool {
        return self.m_swiftyJsonVar[rootKey][secondKey][thirdKey].boolValue
    }
    func getBool (rootKey: String, index: Int, secondKey: String)->Bool {
        return self.m_swiftyJsonVar[rootKey][index][secondKey].boolValue
    }
    
} /* jsonDomObject */

