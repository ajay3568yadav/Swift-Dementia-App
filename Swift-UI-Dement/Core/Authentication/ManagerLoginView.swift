import SwiftUI

struct ManagerLoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false // State to trigger the alert
    @State private var navigateToSignUp = false // State to control navigation to sign up
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Text("Log in")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 20)

                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)

                HStack {
                    Button("Sign in") {
                        if email.isEmpty || password.isEmpty {
                            showAlert = true // Show alert if fields are empty
                        } else {
                            Task {
                                try await viewModel.signIn(withEmail: email, password: password)
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: ManagerSignup().navigationBarBackButtonHidden(true), isActive: $navigateToSignUp) {
                        Button("Sign up") {
                            navigateToSignUp = true
                        }
                        .foregroundColor(.black)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding()
            .alert("Required Fields", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please enter both email and password.")
            }
        }
    }
}

// Preview
struct ManagerLoginView_Previews: PreviewProvider {
    static var previews: some View {
        ManagerLoginView()
    }
}
