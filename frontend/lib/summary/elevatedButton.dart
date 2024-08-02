import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ElevatedbuttonW extends StatelessWidget {
  final String displayText;
  final String displayNum;
  const ElevatedbuttonW({required this.displayText, required this.displayNum});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 380,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                displayText,
                style: GoogleFonts.outfit(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text(
                    displayNum,
                    style: GoogleFonts.outfit(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 20,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.white,
                        )),
                  )
                ],
              )
            ],
          )),
    );
  }
}
