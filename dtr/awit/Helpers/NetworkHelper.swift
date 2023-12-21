//
//  NetworkHelper.swift
//  dtr
//
//  Created by ICTU1 on 11/7/23.
//

import Foundation
import SwiftUI
//domain not declared here because Property wrappers are not supported in top-level code yet

func resetPassword(userid: String, reset_userid: String, domain: String) async -> String? {
    guard let url = URL(string: "http://\(domain)/dtr/mobile/reset_password?userid=\(userid)&reset_userid=\(reset_userid)") else {
        print ("Invalid URL")
        return ""
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedResponse = try? JSONDecoder().decode(String?.self, from: data)
        if let decodedResponse = decodedResponse {
            return decodedResponse
        } else {
            print("User not found or no authority")
            return ""
        }
    } catch{
        print("Error: \(error)")
        return ""
    }
}
func login(imei: String, domain: String) async -> LoginResponse? {
    guard let url = URL(string: "http://\(domain)/dtr/mobileV2/login1?imei=\(imei)") else {
        print("Invalid Url")
        return nil
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedResponse = try? JSONDecoder().decode(LoginResponse.self, from: data)
        if let decodedResponse = decodedResponse {
            switch (decodedResponse.code) {
            case 200:
                
                return decodedResponse
            default :
                return nil
            }
        } else {
            print("Decoding failed or response is nil")
            return nil
        }
    } catch{
        print("Error: \(error)")
        return nil
    }
}

func logout(){
    
}

func updateIMEI(imei: String, userid: String, domain: String) async -> String {
    guard let url = URL(string: "http://\(domain)/dtr/mobileV2/imei?imei=\(imei)&userid=\(userid)") else {
        print("Invalid URL")
        return ""
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    // Set up the request body if needed (e.g., sending parameters)

    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedResponse = try? JSONDecoder().decode(Response.self, from: data)

        if let decodedResponse = decodedResponse {
            print("Code: \(decodedResponse.code)")
            print("Response: \(decodedResponse.response)")

            return decodedResponse.response
        } else {
            print("Decoding failed or response is nil")
            return ""
        }
    } catch {
        print("Error: \(error)")
        return ""
    }
}

func checkUserName(userid: String, domain: String) async -> String? {
    guard let url = URL(string: "http://\(domain)/dtr/mobile/check_username?&reset_userid=\(userid)") else {
        print("Invalid URL")
        return ""
    }
    
    var request = URLRequest(url:url)
    request.httpMethod = "POST"
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedResponse = try? JSONDecoder().decode(String?.self, from: data)
        print(decodedResponse ?? "none")
        return decodedResponse
    } catch {
        print("Error: \(error)")
        return ""
    }
}

func uploadSo(officeOrder: OfficeOrderData, domain: String) async -> String? {
    guard let url = URL(string: "http://\(domain)/dtr/mobileV2/add-so") else {
        print("Invalid URL")
        return ""
    }

    var request = URLRequest(url: url)
    
    request.httpMethod = "POST"
    
    // Set Content-Type header for JSON
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    do {
        let jsonData = try JSONEncoder().encode(["data": officeOrder.description])
        
        request.httpBody = jsonData
        printRequestDetails(request)

        let (data, response) = try await URLSession.shared.data(for: request)
        let decodedResponse = try? JSONDecoder().decode(String?.self, from: data)
        // Print raw response
         print("Raw Response: \(String(data: data, encoding: .utf8) ?? "Unable to convert data to string")")

         // Check HTTP status code
         guard let httpResponse = response as? HTTPURLResponse else {
             return("no response")
         }
        print("HTTP Status Code: \(httpResponse.statusCode)")
         // Decode response if needed
         
        print(decodedResponse ?? "No response")
        return String(httpResponse.statusCode)
    }
    catch {
        // Print the error message
        print("Error: \(error)")
        return "Error: \(error.localizedDescription)"
    }
}

func uploadCto(timeOff: TimeOffData, domain: String) async -> String?{
    guard let url = URL(string: "http://\(domain)/dtr/mobileV2/add-cdo") else {
        print("Invalid URL")
        return "Invalid URL"
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    do {
        let jsonData = try JSONEncoder().encode(["data" : timeOff.description])
        request.httpBody = jsonData
        printRequestDetails(request)
        let (data, response) = try await URLSession.shared.data(for: request)
        let decodedResponse = try? JSONDecoder().decode(String?.self, from: data)
        print("Raw Response: \(String(data: data, encoding: .utf8) ?? "Unable to convert data to string")")
        guard let httpResponse = response as? HTTPURLResponse else {
            return("no response")
        }
       print("HTTP Status Code: \(httpResponse.statusCode)")
        // Decode response if needed
        
       print(decodedResponse ?? "No response")
       return String(httpResponse.statusCode)
    } catch {
        print("Error: \(error)")
        return "Error: \(error.localizedDescription)"
    }
}

func printRequestDetails(_ request: URLRequest) {
    print("URL: \(request.url?.absoluteString ?? "")")
    print("Method: \(request.httpMethod ?? "")")
    if let headers = request.allHTTPHeaderFields {
        print("Headers: \(headers)")
    }
    if let body = request.httpBody {
        print("Body: \(String(data: body, encoding: .utf8) ?? "")")
    }
}

func getAnnouncement(domain: String) async-> Announcement{
    guard let url = URL(string: "http://\(domain)/dtr/mobile/office/announcement") else {
        print("Invalid URL")
        return Announcement(code: 0, message: "Invalid URL")
    }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedAnnouncement = try? JSONDecoder().decode(Announcement.self, from: data)
        if let decodedAnnouncement = decodedAnnouncement {     
            return decodedAnnouncement
        } else {
            return Announcement(code: 0, message: "Decoding failed")
        }
    } catch {
        print("Network error or decoding failed")
        return Announcement(code: 0, message: "Network error or decoding failed")
    }
}

func getUpdate(domain: String) async-> ForceUpdateResponse?{
    guard let url = URL(string: "http://\(domain)/dtr/mobile/get/version") else {
        print("Invalid URL")
        return nil
    }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedUpdate = try? JSONDecoder().decode(ForceUpdateResponse.self, from: data)
        if let decodedUpdate = decodedUpdate {
            return decodedUpdate
        } else {
            return nil
        }
    } catch {
        print("Network error")
        return nil
    }
}

struct Response: Codable {
    let code: Int
    let response: String
}

struct LoginResponse: Codable {
    let code: Int
    let response: UserDetails
}

struct UserDetails: Codable {
    let userid: String
    let fname: String
    let lname: String
    let authority: String
    let section: Int
    let dmo_roles: Int
    let area_of_assignment_roles: Int
    let region: String
}

struct TimeOffData: Codable {
    let userid: String
    let cdo: Array<CTO>
}

struct OfficeOrderData: Codable {
    let userid: String
    let so: Array<SO>
    
}

struct CTO: Codable {
    let daterange: String
}

struct SO: Codable {
    let so_no: String
    let daterange: String
}

extension TimeOffData: CustomStringConvertible {
    var description: String {
        let ctoDescriptions = cdo.map { "\($0)" }.joined(separator: ", ")
        return "{\"userid\": \"\(userid)\", \"cdo\": [\(ctoDescriptions)]}"
    }
}

extension OfficeOrderData: CustomStringConvertible {
    var description: String {
        let soDescriptions = so.map { "\($0)" }.joined(separator: ", ")
        return "{\"userid\": \"\(userid)\", \"so\": [\(soDescriptions)]}"
    }
}

extension CTO: CustomStringConvertible {
    var description: String {
        return "{\"daterange\": \"\(daterange)\"}"
    }
}

extension SO: CustomStringConvertible {
    var description: String {
        return "{\"so_no\": \"\(so_no)\", \"daterange\": \"\(daterange)\"}"
    }
}
