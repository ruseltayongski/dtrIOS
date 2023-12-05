//
//  CTOView.swift
//  dtr
//
//  Created by ICTU1 on 12/1/23.
//

import SwiftUI
import SwiftData

struct CTOView: View {
    @Query var ctos: [Cto]
    @Environment(\.modelContext) var modelContext
    @State private var showSheet = false
    @State private var showAlert = false
    @State var userid: String = (CurrentUser().id ?? "")
    @EnvironmentObject var userData: CurrentUser
    @State var toast: Toast? = nil
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottomTrailing){
                List{
                    ForEach(ctos) { cto in
                        VStack {
                            VStack{
                                Text("CTO dates: ").frame(maxWidth: .infinity, alignment: .leading).fontWeight(.bold)
                                Text(cto.inclusive_date)
                            }.frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }.onDelete(perform: deleteCto)
                }.navigationTitle("Compensatory Time Off")
                
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
                        AddCtoModal(toast: $toast)
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
                        if(!ctos.isEmpty) {
                            var arrayCto: Array<CTO> = []
                            for cto in ctos {
                                let cto = CTO(daterange: cto.inclusive_date)
                                arrayCto.append(cto)
                            }
                            let ctoData = TimeOffData(userid: userid, cdo: arrayCto)
                            let response = await uploadCto(timeOff: ctoData, domain: userData.domain)
                            if(response == "200"){
                                deleteAllCto(ctos: ctos)
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
    
    func deleteCto(_ indexSet: IndexSet) {
        for index in indexSet {
            let cto = ctos[index]
            modelContext.delete(cto)
        }
    }
    
    func deleteAllCto(ctos: [Cto]) {
        for cto in ctos {
            modelContext.delete(cto)
        }
    }
}

struct AddCtoModal: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State private var date_from: Date = Date()
    @State private var date_to: Date = Date()
    @State private var showErrorAlert: Bool = false
    @State private var alertMessage: String = ""
    @Binding var toast: Toast?
    var body: some View {
        NavigationStack{
            VStack {
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
                        if date_to < date_from {
                            alertMessage = "Date To should be later or equal to Date From"
                        }
                        
                        if !alertMessage.isEmpty {
                            showErrorAlert = true
                        } else {
                            addCto(inclusive_date: formatDate(date_from: date_from, date_to: date_to))
                            toast = Toast(style: .success, message: "Successfully added CTO")
                            dismiss()
                        }
                    } label: {
                        Text("Submit")
                    }
                    .background(Color.green)
                    .padding()
                }
            }.navigationTitle("File CTO")
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
    
    func addCto(inclusive_date: String) {
        let timeOff = Cto(inclusive_date: inclusive_date)
        modelContext.insert(timeOff)
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
    CTOView()
}
