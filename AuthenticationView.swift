//
//  AuthenticationView.swift
//  Proto
//
//  Created by Iris Yan on 8/3/23.
//import SwiftUI




//
//
//import FirebaseAuth
//import FirebaseFirestore
//
//struct AuthenticationView: View {
//    @Binding var isAuthenticated: Bool
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var errorMessage: String? // For displaying error messages
//
//    var body: some View {
//        VStack {
//            // ... [Your other UI elements]
//
//
//            Button("Sign Up") {
//                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//                    if let error = error {
//                        print("Error signing up: \(error.localizedDescription)")
//                        self.errorMessage = error.localizedDescription
//                    } else {
//                        // The user account is successfully created
//                        isAuthenticated = true
//                    }
//                }
//            }
//            .padding()
//            .background(Color.green)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//            .padding(.horizontal)
//
//
//            Button("Login") {
//                // Authenticate the user with Firebase
//                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
//                    if let error = error {
//                        print("Error signing in: \(error.localizedDescription)")
//                        self.errorMessage = error.localizedDescription
//                    } else {
//                        // The user is successfully authenticated
//                        isAuthenticated = true
//                    }
//                }
//            }
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//            .padding(.horizontal)
//
//            if let errorMessage = errorMessage {
//                Text(errorMessage)
//                    .foregroundColor(.red)
//                    .padding()
//            }
//        }
//        .padding(.top, 50)
//    }
//}
import SwiftUI
import FirebaseAuth

struct AuthenticationView: View {
    @Binding var isAuthenticated: Bool
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            Button("Sign Up") {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        print("Error signing up: \(error.localizedDescription)")
                        self.errorMessage = error.localizedDescription
                    } else {
                        isAuthenticated = true
                    }
                }
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)

            Button("Login") {
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        print("Error signing in: \(error.localizedDescription)")
                        self.errorMessage = error.localizedDescription
                    } else {
                        isAuthenticated = true
                    }
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding(.top, 50)
    }
}
