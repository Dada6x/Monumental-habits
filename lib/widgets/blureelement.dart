import 'package:flutter/material.dart';

class BlurElement extends StatelessWidget {
  const BlurElement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Info Popup Example")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showInfoPopup(context, "This is a reusable info popup!");
          },
          child: const Text("Show Info"),
        ),
      ),
    );
  }
}

/// 📌 Reusable function to show an info popup
void showInfoPopup(BuildContext context, String text) {
  OverlayState overlayState = Overlay.of(context);
  OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top:
          MediaQuery.of(context).size.height * 0.1, // Adjust position as needed
      left: MediaQuery.of(context).size.width * 0.15,
      right: MediaQuery.of(context).size.width * 0.4,
      child: Material(
        color: Colors.transparent,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: 1.0,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    ),
  );

  // Insert the overlay
  overlayState.insert(overlayEntry);

  // Remove the popup after 3 seconds
  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
