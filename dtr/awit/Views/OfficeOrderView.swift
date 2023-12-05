//
//  OfficeOrderView.swift
//  dtr
//
//  Created by ICTU1 on 11/23/23.
//

import SwiftUI
import SwiftData

struct OfficeOrderView: View {
    @Environment(\.modelContext) var modelContext
    @Query var officeOrders: [OfficeOrder]
    @State private var showSheet = false
    @State private var showAlert = false
    @State var userid: String = (CurrentUser().id ?? "")
    @EnvironmentObject var userData: CurrentUser
    @State var toast: Toast? = nil
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                List{
                    ForEach(officeOrders) { officeOrder in
                        VStack {
                            VStack{
                                Text("SO#").frame(maxWidth: .infinity, alignment: .leading)
                                Text("SO#" + officeOrder.so_no).fontWeight(.bold)
                            }.frame(maxWidth: .infinity, alignment: .leading)
                            VStack{
                                Text("Inclusive Dates").frame(maxWidth: .infinity, alignment: .leading)
                                Text(officeOrder.inclusive_date).fontWeight(.bold)
                            }.frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }.onDelete(perform: deleteSO)
                }
                .navigationTitle("Office Order")
                
                Button {
                    showSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 4, x: 0, y: 4)
                    
                }
                .sheet(isPresented: $showSheet){
                    ZStack {
                        Color.black.opacity(0.5)
                            .background(BackgroundClearView())
                            .edgesIgnoringSafeArea(.all)
                        AddSOModal(toast: $toast)
                    }
                    
                }
            }.toolbar {
                ToolbarItem() {
                    Button(){
                        showAlert.toggle()
                    } label: {
                        Image(systemName: "icloud.and.arrow.up.fill")
                    }
                }
            }
            .alert(Text("Are you sure you want to upload?"), isPresented: $showAlert) {
                Button("Cancel", role: .cancel) {}
                Button("OK") {
                    
                    Task {
                        if(!officeOrders.isEmpty) {
                            var arraySo: Array<SO> = []
                            for officeOrder in officeOrders {
                                let so = SO(so_no: officeOrder.so_no, daterange: officeOrder.inclusive_date)
                                arraySo.append(so)
                            }
                            let officeOrderData = OfficeOrderData(userid: userid, so: arraySo)
                            let response = await uploadSo(officeOrder: officeOrderData, domain: userData.domain)
                            if(response == "200"){
                                deleteAllSO(officeOrders: officeOrders)
                                toast = Toast(style: .success, message: "successfully uploaded")
                            }
                            else {
                                toast = Toast(style: .error, message: "Network error")
                            }
                        }
                        else {
                            toast = Toast(style: .error, message: "Nothing to upload")
                        }
                    }
                    
                    
                }
                
            }
        }.toastView(toast: $toast)
    }
    
    func deleteSO(_ indexSet: IndexSet){
        for index in indexSet {
            let officeOrder = officeOrders[index]
            modelContext.delete(officeOrder)
        }
    }
    
    func deleteAllSO(officeOrders: [OfficeOrder]){
        for officeOrder in officeOrders {
            modelContext.delete(officeOrder)
        }
    }
}

struct AddSOModal: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State private var so_no: String = ""
    @State private var date_from: Date = Date()
    @State private var date_to: Date = Date()
    @State private var showErrorAlert: Bool = false
    @State private var alertMessage: String = ""
    @Binding var toast: Toast?
    var body: some View {
        NavigationStack{
            VStack {
                TextField("SO no.", text: $so_no)
                DatePicker("Date From", selection: $date_from, in: ...date_to, displayedComponents: [.date])
                DatePicker("Date To", selection: $date_to, in: date_from..., displayedComponents: [.date])
                HStack{
                    Button{
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    .padding()
                    .foregroundColor(.red)
                    Button{
                        alertMessage = ""
                        
                        if so_no.isEmpty {
                            alertMessage = "SO no. cannot be blank"
                        } else if date_to < date_from {
                            alertMessage = "Date To should be later or equal to Date From"
                        }
                        
                        if !alertMessage.isEmpty {
                            showErrorAlert = true
                        } else {
                            addSo(soNo: so_no, inclusive_date: formatDate(date_from: date_from, date_to: date_to))
                            toast = Toast(style: .success, message: "Successfully added SO")
                            dismiss()
                        }
                    } label: {
                        Text("Submit")
                    }
                    .background(Color.green)
                    .padding()
                }
            }.navigationTitle("File Office Order")
                .foregroundColor(Color.black)
                .background(Color.white)
                .environment(\.colorScheme, .light)
                .cornerRadius(10)
                .padding(25)
                .alert("Error", isPresented: $showErrorAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(alertMessage)
                }
        }.toastView(toast: $toast)
    }
    func addSo(soNo: String, inclusive_date: String) {
        let order = OfficeOrder(so_no: soNo, inclusive_date: inclusive_date)
        modelContext.insert(order)
    }

    func formatDate(date_from: Date, date_to: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let stringFrom = dateFormatter.string(from: date_from)
        let stringTo = dateFormatter.string(from: date_to)
        return (stringFrom + " - " + stringTo)
    }
}
    
#Preview {
    OfficeOrderView()
}
