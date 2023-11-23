//
//  CurrentUser.swift
//  dtr
//
//  Created by ICTU1 on 11/13/23.
//

import Foundation


class CurrentUser: ObservableObject {
    var id: String?
    var fname: String?
    var lname: String?
    var authority: String?
    var section: String?
    var dmo_roles: Int?
    var area_of_assignment_roles: Int?
    var region: String?
    var domain: String
    
    init(id: String, fname: String, lname: String, authority: String, section: String, dmo_roles: Int, area_of_assignment_roles: Int, region: String) {
        self.id = id
        self.fname = fname
        self.lname = lname
        self.authority = authority
        self.section = section
        self.dmo_roles = dmo_roles
        self.area_of_assignment_roles = area_of_assignment_roles
        self.region = region
        UserDefaults.standard.setValue(id, forKey: "userid")
        UserDefaults.standard.setValue(fname, forKey: "fname")
        UserDefaults.standard.setValue(lname, forKey: "lname")
        UserDefaults.standard.setValue(authority, forKey: "authority")
        UserDefaults.standard.setValue(section, forKey: "section")
        UserDefaults.standard.setValue(dmo_roles, forKey: "dmo_roles")
        UserDefaults.standard.setValue(area_of_assignment_roles, forKey: "area_of_assignment_roles")
        UserDefaults.standard.setValue(region, forKey: "region")
        self.domain = "49.157.74.3"
    }
    
    func updateUser(id: String, fname: String, lname: String, authority: String, dmo_roles: Int, area_of_assignment_roles: Int, region: String, domain: String) {
        self.id = id
        self.fname = fname
        self.lname = lname
        self.authority = authority
        self.dmo_roles = dmo_roles
        self.area_of_assignment_roles = area_of_assignment_roles
        self.region = region
        UserDefaults.standard.setValue(id, forKey: "userid")
        UserDefaults.standard.setValue(fname, forKey: "fname")
        UserDefaults.standard.setValue(lname, forKey: "lname")
        UserDefaults.standard.setValue(authority, forKey: "authority")
        UserDefaults.standard.setValue(NSNumber(value: dmo_roles), forKey: "dmo_roles")
        UserDefaults.standard.setValue(NSNumber(value: area_of_assignment_roles), forKey: "area_of_assignment_roles")
        UserDefaults.standard.setValue(region, forKey: "region")
    }

    init(){
        self.id = UserDefaults.standard.string(forKey: "userid")
        self.fname = UserDefaults.standard.string(forKey: "fname")
        self.lname = UserDefaults.standard.string(forKey: "lname")
        self.authority = UserDefaults.standard.string(forKey: "authority")
        self.section = UserDefaults.standard.string(forKey: "section")
        self.dmo_roles = UserDefaults.standard.integer(forKey: "dmo_roles")
        self.area_of_assignment_roles = UserDefaults.standard.integer(forKey: "area_of_assignment_roles")
        self.region = UserDefaults.standard.string(forKey: "region")
        self.domain = "49.157.74.3"
    }
    
    func logout(){
        UserDefaults.standard.removeObject(forKey: "userid")
        UserDefaults.standard.removeObject(forKey: "fname")
        UserDefaults.standard.removeObject(forKey: "lname")
        UserDefaults.standard.removeObject(forKey: "authority")
        UserDefaults.standard.removeObject(forKey: "section")
        UserDefaults.standard.removeObject(forKey: "dmo_roles")
        UserDefaults.standard.removeObject(forKey: "area_of_assignment_roles")
        UserDefaults.standard.removeObject(forKey: "region")
        self.id = UserDefaults.standard.string(forKey: "userid")
        self.fname = UserDefaults.standard.string(forKey: "fname")
        self.lname = UserDefaults.standard.string(forKey: "lname")
        self.authority = UserDefaults.standard.string(forKey: "authority")
        self.section = UserDefaults.standard.string(forKey: "section")
        self.dmo_roles = UserDefaults.standard.integer(forKey: "dmo_roles")
        self.area_of_assignment_roles = UserDefaults.standard.integer(forKey: "area_of_assignment_roles")
        self.region = UserDefaults.standard.string(forKey: "region")
    }
    
    func setDomain(domain: String){
        self.domain = domain
    }
}
