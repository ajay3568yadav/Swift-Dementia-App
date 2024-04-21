import SwiftUI

struct ManagerSignup: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false  // State to trigger the alert
    @State private var alertMessage = ""  // Message to show in the alert
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var shouldShowLogin = false // State to control navigation
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Text("Sign up")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 20)

                TextField("Username", text: $username)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)

                
                TextField("Email", text: $email)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never) 
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)

                HStack(spacing: 10) {
                    Button(action: {
                        shouldShowLogin = true
                        print("Before")
                    }) {
                        Text("Sign in")
                            .foregroundColor(.black)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                    .background(NavigationLink("", destination: ManagerLoginView().navigationBarBackButtonHidden(true), isActive: $shouldShowLogin).hidden())

                    Button(action: {
                        if username.isEmpty || email.isEmpty || password.isEmpty {
                            alertMessage = "All fields are required. Please enter your username, email, and password."
                            showAlert = true
                            
                        } else {
                            print("Before")
                            Task {
                                try await viewModel.createUser(withEmail: email, password: password, fullname: username)
                            }
                            print("After")
                        }
                    }) {
                        Text("Sign up")
                            .foregroundColor(.white)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Missing Information"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

// Preview
struct ManagerSignup_Previews: PreviewProvider {
    static var previews: some View {
        ManagerSignup()
    }
}
