# Classify White Flower

A simple image classification iOS app that detects whether a flower is a white flower or not using a trained CoreML model.

## Overview

This iOS app allows users to:

- Capture or select a photo of a flower.
- Use a pre-trained CoreML model to determine if the flower is white.
- Display the result in a clean, user-friendly interface.

This is a basic example of using **CoreML** and **Vision** in an iOS app to demonstrate real-time image classification with a custom-trained model.

## Built With

- **Swift**
- **UIKit**
- **CoreML**
- **Vision**
- **Xcode**
- **CreateML** (for model training)

## How It Works

1. The user selects or takes a photo.
2. The image is processed through a CoreML model.
3. The app displays a message if the flower is white or not.

## ML Model

- The CoreML model was trained using Apple’s **CreateML** tool.
- The training dataset included images of **white** and **non-white** flowers.

## Getting Started

1. Clone this repository:
   ```bash
   git clone https://github.com/malihanawshin/Classify-white-flower.git

2. Open the `.xcodeproj` file in Xcode.
3. Run the app on a simulator or real device with camera access.
4. Select or capture an image to classify it.

## Features

* Camera and photo library access
* Real-time classification
* Simple and intuitive UI
* Offline functionality using on-device ML

## Future Improvements

* [ ] Improve model accuracy with a larger dataset
* [ ] Add feedback or correction system to improve model predictions
* [ ] Support classification of more flower types
* [ ] Improve UI/UX with animations and accessibility features

## Contributing

Contributions, issues, and feature requests are welcome!

## License

This project is open source under the [MIT License](LICENSE).
