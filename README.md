Topic:Federal qidiruv bo;limi

Scaffold: The outermost widget that provides the basic structure for the screen. It includes the app bar, body, and other structural elements.

backgroundColor: Sets the background color of the Scaffold to deep purple.

body: The main content of the screen. It contains a Center widget to center its child vertically and horizontally.

Column: A vertical arrangement of widgets that displays its children in a column.

Text: Displays the text "Federal qidiruv bo'limi" with specified text styles such as color, font size, and font weight.

Image.asset: Loads an image from the assets directory. The image file is 'assets/img1.png', and it is set to have a width and height of 150.0 pixels. fit: BoxFit.contain ensures that the image scales to fit within the specified dimensions while maintaining its aspect ratio.

SizedBox: Adds some empty space (vertical separation) between the image and the elevated button.

ElevatedButton: A button with elevated appearance. It has a background color set to a specific shade of purple, and the text on the button is "Tarmog'ga ulanish".

onPressed: Defines the action to be taken when the button is pressed. In this case, it navigates to the FirstScreen using Navigator.pushReplacement.

child: The text displayed on the button.

The Column widget arranges these components vertically in the center of the screen.

