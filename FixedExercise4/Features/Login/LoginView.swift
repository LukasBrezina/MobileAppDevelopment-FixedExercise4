//
//  LoginView.swift
//  FixedExercise4
//
//  Created by Lukas Brezina on 28.09.26.
//
import SwiftUI

struct LoginView: View {
    
    @State
    private var email = "mad-fe@mad.at"
    
    @State
    private var password = "madmad"
    
    @State
    private var isLoading = false
    
    @State
    private var alert: AlertInfo?
    
    @State
    private var loginSuccess = false
    
    private let minHeight: CGFloat = 40
    
    private enum Field {
        case email
        case password
    }
    
    @FocusState
    private var focusedField: Field?
    
    @State
    var user: User?
    

    var body: some View {
        
        VStack {
                
            Spacer()
            
            Text("Login")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, minHeight: minHeight)
                .padding(24)
                .bold()
            
            
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .focused($focusedField, equals: .email)
                .submitLabel(.next)
                .autocorrectionDisabled()
                .frame(maxWidth: .infinity, minHeight: minHeight)
                .font(.title2)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .onSubmit {
                    focusedField = .password
                }
            
            SecureField("Password", text: $password)
                .textContentType(.password)
                .focused($focusedField, equals: .password)
                .submitLabel(.go)
                .frame(maxWidth: .infinity, minHeight: minHeight)
                .font(.title2)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .onSubmit {
                    login()
                }
            
            Spacer()
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity, minHeight: minHeight)
                    .padding()
            } else {
                Button {
                    login()
                } label: {
                    Text("Login")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: minHeight)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            
            Spacer()
        }
        .disabled(isLoading)
        .padding()
        .infoAlert($alert)
        .toolbar(.hidden, for: .navigationBar)
        .navigationTitle("Login Screen")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $loginSuccess) {
            CountriesView(loginIdToken: user?.idToken ?? "")
        }
    }
    
    func login() {
        
        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            alert = AlertInfo(message: "Email missing!")
            return
        }
        
        guard !password.isEmpty else {
            alert = AlertInfo(message: "Password missing!")
            return
        }
        
        isLoading = true
        focusedField = nil
        
        APIClient.shared.login(username: email, password: password) { user, error in
            isLoading = false
            if let error {
                alert = AlertInfo(message: error.message)
            } else if user != nil {
                self.user = user
                loginSuccess = true
            }
        }
    }
}
