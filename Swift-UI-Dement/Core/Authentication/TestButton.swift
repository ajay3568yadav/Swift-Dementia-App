import SwiftUI

struct TestButton: View {
    var body: some View {
        Button(action: {
            // Define the action for the button here
            print("Plus button tapped")
        }) {
            Image(systemName: "plus") // Using a system image for the plus icon
                .font(.largeTitle) // Set the font size of the plus icon
                .foregroundColor(.black) // Set the color of the plus icon
                .padding() // Add padding around the icon to increase the tap area
                .background(Circle() // Create a circle background
                                .fill(Color.white) // Fill the circle with blue color
                                .shadow(radius: 5)) // Optional: Add a shadow for a 3D effect
        }
    }
}

#Preview {
    TestButton()
}
