import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group{
            if viewModel.userSession != nil{
//                ManagerLogin()
            }
            else{
                ManagerLoginView()
            }
        }
    }
}

// Preview provider for SwiftUI preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
