//
//  SwiftUIView.swift
//  Proto
//
//  Created by Iris Yan on 8/3/23.
//
import SwiftUI
import HealthKit
import FirebaseAuth
import FirebaseFirestore

struct HealthDataAccessView: View {
    @State private var appleHealthEnabled = false
    @State private var fitbitEnabled = false
    @Binding var hasCompletedHealthDataAccess: Bool
    @EnvironmentObject var fitbitAuthManager: FitbitAuthManager
    @State private var showReauthorizeAlert = false
    // Assuming tokenExpiredOrInvalid is a state you want to monitor
    @State private var tokenExpiredOrInvalid = false

    var healthStore = HKHealthStore()
    @State private var showNextView = false
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    @State private var accessToken: String?
    let fitbitClientID = "23R4V3"
    let fitbitRedirectURI = "https://www.amicahealth.com"
    
    var fitbitAuthURL: URL {
        URL(string: "https://www.fitbit.com/oauth2/authorize?response_type=code&client_id=\(fitbitClientID)&redirect_uri=\(fitbitRedirectURI)&scope=activity%20nutrition%20heartrate%20location%20nutrition%20profile%20settings%20sleep%20social%20weight")!
    }
    @State private var authorizationCode: String?

    func handleFitbitToggleChange(isOn: Bool) {
        if isOn {
            UIApplication.shared.open(fitbitAuthURL)
        }
    }

    func handleAuthorizationCallback(url: URL) {
        if let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code" })?.value {
            authorizationCode = code
            exchangeAuthorizationCodeForAccessToken()
        }
    }

    func exchangeAuthorizationCodeForAccessToken() {
        guard let code = authorizationCode else { return }
        isLoading = true

        let firebaseFunctionURL = URL(string: "https://us-central1-tandem-health.cloudfunctions.net/fitbitCallback")!
        var request = URLRequest(url: firebaseFunctionURL)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let bodyData = "code=\(code)"
        request.httpBody = bodyData.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let data = data, error == nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let token = jsonResponse?["access_token"] as? String {
                            self.accessToken = token
                            // Save to Firestore
                            saveAccessTokenToFirestore(token: token)
                        } else if let errorDescription = jsonResponse?["errors"] as? [[String: Any]], let firstError = errorDescription.first, let message = firstError["message"] as? String {
                            self.errorMessage = message
                        }
                    } catch {
                        self.errorMessage = "Failed to parse response."
                    }
                } else {
                    self.errorMessage = error?.localizedDescription ?? "Unknown error occurred."
                }
            }
        }.resume()
    }
//save fitbit token to firestore:
    
    func saveAccessTokenToFirestore(token: String) {
        // Fetch the current user's UID from Firebase Authentication
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error: User not logged in.")
            return
        }

        let db = Firestore.firestore()
        db.collection("users").document(userID).setData(["fitbitAccessToken": token]) { error in
            if let error = error {
                print("Error saving token: \(error)")
                self.errorMessage = "Failed to save access token."
            } else {
                print("Token saved successfully!")
            }
        }
    }

    func fetchAccessTokenFromFirestore(completion: @escaping (String?) -> Void) {
        // Fetch the current user's UID from Firebase Authentication
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error: User not logged in.")
            completion(nil)
            return
        }

        let db = Firestore.firestore()
        db.collection("users").document(userID).getDocument { document, error in
            if let document = document, document.exists, let data = document.data() {
                let token = data["fitbitAccessToken"] as? String
                completion(token)
            } else {
                print("Document does not exist or error fetching token: \(error?.localizedDescription ?? "No error message")")
                completion(nil)
            }
        }
    }

    
    private func requestHealthAccess(enabled: Bool) {
        if enabled {
            let readDataTypes: Set<HKObjectType> = [
                HKObjectType.quantityType(forIdentifier: .stepCount)!,
                HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!,
                HKObjectType.quantityType(forIdentifier: .bloodGlucose)!
            ]
            let writeDataTypes: Set<HKSampleType> = [
                HKObjectType.quantityType(forIdentifier: .stepCount)!,
                HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!,
                HKObjectType.quantityType(forIdentifier: .bloodGlucose)!
            ]
            healthStore.requestAuthorization(toShare: writeDataTypes, read: readDataTypes) { success, error in
                if let error = error {
                    print("Error requesting health data access: \(error.localizedDescription)")
                }
            }
        }
    }
    
//    let response = // Your API call response
//    if response.statusCode == 401 {
//        self.tokenExpiredOrInvalid = true
//    }


    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Health Data Access")
                                .font(.headline)
                                .padding(.top)) {
                        Toggle("Apple Health", isOn: $appleHealthEnabled)
                            .onChange(of: appleHealthEnabled) { newValue in
                                requestHealthAccess(enabled: newValue)
                            }
                        Toggle("Fitbit", isOn: $fitbitEnabled)
                            .onChange(of: fitbitEnabled, perform: handleFitbitToggleChange)
                    }
                    .padding()
                    Text("Enable access to Apple Health and Fitbit to allow the app to gather health data.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding()
                }
                Spacer()
                Button("Continue") {
                    showNextView = true
                    hasCompletedHealthDataAccess = true
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(15)
                .padding()
                
                if isLoading {
                    ProgressView("Loading...")
                        .padding()
                }

                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .navigationBarTitle("Health Data", displayMode: .inline)
            .alert(isPresented: $showReauthorizeAlert) {
                Alert(
                    title: Text("Reauthorize Fitbit"),
                    message: Text("We need to reauthorize your Fitbit account. Please log in again."),
                    primaryButton: .default(Text("Reauthorize"), action: {
                        // Trigger the Fitbit authorization process again
                        UIApplication.shared.open(fitbitAuthURL)
                    }),
                    secondaryButton: .cancel()
                )
            }
        }
        .onAppear {
            // Sample logic for token expiration. Adjust as necessary.
            if tokenExpiredOrInvalid {
                self.showReauthorizeAlert = true
            }
        }
    }
}

