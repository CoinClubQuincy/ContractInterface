//
//  DApps.swift
//  ContractInterface
//
//  Created by Quincy Jones on 12/16/22.
//

import SwiftUI
//MARK: DApps
struct ContractInterface: View {
    @Binding var backgroundColor:LinearGradient
    @State var searchBar:String = ""
    @StateObject var vm = DownloadCIMLDocument.init()
    @StateObject var contractInterface:ContractModel
    @State var overlayinfo:Bool = false
    @State var showDAppSettings:Bool = false
    @State var showDapplet:Bool = false
    
    
    @State var presented: Bool = false
    @State var alertTitle:String = ""
    @State var alertMessage:String = ""
    
    
    let data = Array(0...0).map { "DApp \($0)" }
    let layout = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                    .ignoresSafeArea(.all)
                    .navigationTitle("DApps")
                    .navigationBarItems(
                        leading:
                            NavigationLink(
                                destination: Text("Favorites")
                                .navigationTitle("Favorites")
                                ,label: {
                                    Image(systemName: "qrcode")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.black)
                                        .padding(.trailing,10)
                                }
                            )
                        ,
                        trailing:
                            NavigationLink(
                                destination: Wallets()
                                .navigationTitle("Wallet")
                                ,label: {
                                    Image(systemName: "wallet.pass.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.black)
                                        .padding(.trailing,10)
                                }
                            )
                    )
                VStack {
                    //MARK: DApplet Grid
                    if(showDapplet){
                        CIMLFinalView(contractInterface: contractInterface)
                            .gesture(DragGesture(minimumDistance: 100, coordinateSpace: .local)
                                                .onEnded({ value in
                                                    if value.translation.height < 0 {
                                                        // up
                                                        withAnimation {
                                                            showDapplet = false
                                                        }
                                                    }
                                                }))
                    } else {
                    HStack {
//                        ForEach(vm.ciml){ciml in
//                            Text(ciml.name ?? "Error")
//                        }
                        TextField("Search...", text: $searchBar)
                            .frame(height: 50)
                            .padding(.leading)
                            .background(Color(.white))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.leading,5)
                            .shadow(radius: 6)
                        
                        
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.black)
                                .frame(width: 55,height: 55, alignment: .center)
                                .cornerRadius(10)
                                .padding(.trailing,10)
                        })
                    }
                        ScrollView {
                            LazyVGrid(columns: layout, spacing: 20){
                                ForEach(data, id: \.self){item in
                                    HStack {
                                        
                                        Button(action: {
                                            withAnimation {
                                                showDapplet.toggle()
                                            }
                                        }, label: {
                                            VStack{
                                                Image("echo")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 60, height: 60)
                                                    .cornerRadius(10)
                                                    .shadow(radius: 10)
                                                    .padding(5)
                                                Text(item)
                                                    .font(.footnote)
                                                    .foregroundColor(.black)
                                            }
                                        })
                                        
                                    }
                                    //                                ZStack{
                                    //                                    Circle()
                                    //                                        .fill(Color.red)
                                    //                                        .frame(width: 20,height: 20)
                                    //
                                    //                                    Text("2")
                                    //                                        .font(.footnote)
                                    //                                        .foregroundColor(.white)
                                    //                                }
                                    
                                    .overlay(
                                        
                                        Button(action: {
                                            showDAppSettings.toggle()
                                        }, label: {
                                            Image(systemName: "info.circle")
                                                .foregroundColor(.blue)
                                                .background(Color.white)
                                                .cornerRadius(50)
                                        })
                                        .sheet(isPresented: $showDAppSettings) {
                                            SettingsPallet
                                        }
                                        , alignment: .topLeading
                                    )
                                    
                                    
                                }
                            }
                            .padding(.top)
                        }
                    }

                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
            }
        }
    }
    //MARK: SettingsPallet
    var SettingsPallet: some View{
        VStack{
            List{
                Section("DApplet"){
                    Image("XTB")
                        .resizable()
                        .scaledToFit()
                    HStack{
                        Circle()
                            .frame(width: 30)
                        
                        Text("Name")
                        Text("-")
                        Text("SYMBOL")
                    }
//                    HStack{ // Event Listener
//                        Text("Notifications: ")
//                        Spacer()
//                        Text("X")
//                            .font(.title3)
//                            .bold()
//                    }
                    HStack{
                        Text("{App} Version: ")
                        Spacer()
                        Text("0.0.0")
                            .font(.title3)
                            .bold()
                    }
                    
                    Text("This is the description of the Dapp provided")
                    
                    HStack(){
                        Text("Website:")
                        Text(" https\\:DAppletSite.com")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                    
                    HStack{
                        Text("Network:")
                        Spacer()
                        Text("XDC")
                            .font(.title3)
                            .bold()
                    }
                    HStack{
                        VStack{
                            Text("Contract:")
                        }
                        Spacer()
                        Text("xdce64996f74579ed41674a26216f8ecf980494dc38")
                            .font(.body)
                            .bold()
                    }
                    HStack{
                        VStack{
                            Image(systemName: "network")
                            Text("Explorer")
                                .font(.footnote)
                                .foregroundColor(.blue)
                        }
                        
                        Spacer()
                        
                        VStack{
                            Image(systemName: "qrcode")
                            Text("CI Schema")
                                .font(.footnote)
                                .foregroundColor(.blue)
                        }
                    }
                }
                Section("Contract Interface"){
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("v1.0.0")
                            .bold()
                    }
                }
                Section("3rd Party Verification "){
                    HStack {
                        Text("CoinClubLabs")
                        Spacer()
                        HStack {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.green)
                            Image(systemName: "info.circle")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .listStyle(.grouped)
            Button(action: {
                buttonAlert(title: "Delete DApplet", msg: "Are you sure you want to Delete this Dapplet?")
            }, label: {
                Text("Delete")
                    .cornerRadius(20)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                    .padding()
            })
            .background(Color.red)
            .alert(isPresented: $presented, content: {
                getAlert()
            })

        }
    }
    
    //MARK: DApp Functions
    func getAlert() -> Alert{
        return Alert(title: Text(alertTitle),
                     message: Text(alertMessage),
                     primaryButton: .destructive(Text("Delete")) {
                         print("Deleting...")
                     },
                     secondaryButton: .cancel())
    }
    
    func buttonAlert(title:String, msg:String){
        alertTitle = title
        alertMessage = msg
        presented.toggle()
    }
    
}

