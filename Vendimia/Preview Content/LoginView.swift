//
//  LoginView.swift
//  Vendimia
//
//  Created by Ultiimate Dog on 24/04/24.
//

import SwiftUI

struct LoginView: View {
    var modelData: ModelData = .shared
    let colorP = ColorPalette()
    
    @State var teleNumber = ""
    @State var password = ""
    @State var fullName = ""
    @State var username = ""
    
    @Binding var isLogin: Bool
    
    @State var createAccount = false
    
    var body: some View {
        GeometryReader { proxy in
            let dWidth = proxy.size.width
            let dHeigth = proxy.size.height
            
            ZStack {
                Rectangle()
                    .fill(Color.white)
                Circle()
                    .fill(colorP.rojo)
                    .scaledToFit()
                    .frame(width: dWidth)
                    .scaleEffect(createAccount ? 3.6 : 1)
                    .offset(x: -dWidth * 0.85 / 4, y: -dWidth * 0.85 / 4 - dHeigth / 4)
                Image("Edificio banorte")
                    .resizable()
                    .scaledToFit()
                    .frame(width: dWidth*1.2)
                    .offset(x: -dWidth * 0.08, y: dWidth * 0.09)
                    .clipShape(Circle())
                    .offset(x: dWidth / 4, y: -dWidth / 3 - dHeigth / 4)
                Text(createAccount ? "Create account" : "Welcome\n back!")
                    .font(.largeTitle)
                    .foregroundStyle(Color.white)
                    .bold()
                    .scaleEffect(1.2)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, createAccount ? 35 : 0)
                    .offset(x: -dWidth * 0.85 / 4, y: -dHeigth / 5)
                
                VStack(spacing: 0) {
                    HStack {
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(createAccount ? Color.white : Color.black)
                            .frame(width: dWidth*0.06)
                        TextField("Full name", text: $fullName)
                            .foregroundStyle(createAccount ? Color.white : Color.black)
                            .padding()
                    }
                    .padding(.leading, dWidth*0.1)
                    RoundedRectangle(cornerRadius: 2)
                        .fill(createAccount ? Color.white : Color.black)
                        .frame(width: dWidth*0.8,height: 3)
                        .padding(.bottom, 10)
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(createAccount ? Color.white : Color.black)
                            .frame(width: dWidth*0.07)
                        Spacer()
                        TextField("Username", text: $username)
                            .foregroundStyle(createAccount ? Color.white : Color.black)
                            .padding()
                    }
                    .padding(.leading, dWidth*0.1)
                    RoundedRectangle(cornerRadius: 2)
                        .fill(createAccount ? Color.white : Color.black)
                        .frame(width: dWidth*0.8,height: 3)
                        .padding(.bottom, 10)
                }
                .frame(width: dWidth,height: dHeigth)
                .offset(x: !createAccount ? -dWidth : 0,y: -dHeigth*0.05)
                
                VStack(spacing: 0) {
                    HStack {
                        Image(systemName: "phone")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(createAccount ? Color.white : Color.black)
                            .frame(width: dWidth*0.06)
                        TextField("Telephone number", text: $teleNumber)
                            .foregroundStyle(createAccount ? Color.white : Color.black)
                            .padding()
                    }
                    .padding(.leading, dWidth*0.1)
                    RoundedRectangle(cornerRadius: 2)
                        .fill(createAccount ? Color.white : Color.black)
                        .frame(width: dWidth*0.8,height: 3)
                        .padding(.bottom, 10)
                    HStack {
                        Image(systemName: "lock")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(createAccount ? Color.white : Color.black)
                            .frame(width: dWidth*0.04)
                        Spacer()
                        SecureField("Password", text: $password)
                            .foregroundStyle(createAccount ? Color.white : Color.black)
                            .padding()
                    }
                    .padding(.leading, dWidth*0.12)
                    RoundedRectangle(cornerRadius: 2)
                        .fill(createAccount ? Color.white : Color.black)
                        .frame(width: dWidth*0.8,height: 3)
                        .padding(.bottom, 10)
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("Forgot your password ?")
                                .foregroundStyle(Color.black)
                                .bold()
                                .offset(x: createAccount ? dWidth : 0)
                                .padding(.trailing, 20)
                        }
                    }
                    Button {
                        withAnimation {
                            isLogin = false
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(createAccount ? Color.white : colorP.rojo)
                            .frame(width: dWidth * 0.6, height: dWidth*0.12)
                            .overlay {
                                Text(createAccount ? "Create account" : "Login")
                                    .font(.title2)
                                    .bold()
                                    .foregroundStyle(createAccount ? colorP.rojo : Color.white)
                            }
                    }
                    .padding(.top, 20)
                }
                .frame(width: dWidth,height: dHeigth)
                .offset(y: createAccount ? dHeigth*0.15 : dHeigth*0.06)
                
                VStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: dWidth*0.2)
                        .fill(colorP.rojo)
                        .frame(width: dWidth*1.1,height: dHeigth*0.12)
                        .overlay {
                            HStack {
                                Text(createAccount ? "Already have an account ?" : "Don't have an account ?")
                                    .foregroundStyle(Color.white)
                                    .font(.title3)
                                    .bold()
                                Button {
                                    withAnimation {
                                        createAccount.toggle()
                                    }
                                } label: {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(colorP.grisOscuro)
                                        .frame(width: dWidth*0.4, height: dHeigth*0.05)
                                        .overlay {
                                            Text(createAccount ? "Login" : "Create account")
                                                .foregroundStyle(Color.white)
                                                .font(.title3)
                                                .bold()
                                        }
                                }
                            }
                            .offset(y: -dHeigth*0.01)
                        }
                }
            }
            .frame(width: dWidth,height: dHeigth)
            .ignoresSafeArea()
        }
        .ignoresSafeArea()

    }
}
