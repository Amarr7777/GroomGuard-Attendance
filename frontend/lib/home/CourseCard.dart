import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class courseCard extends StatelessWidget {
  const courseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(10.0),
    child: 
    ElevatedButton(
        onPressed: () {
          print("ElevatedButton pressed");
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Microservices",
                    style: GoogleFonts.outfit(fontWeight: FontWeight.bold,color: Colors.black),
                  ),
                  Text(
                    "4MCAB",
                    style: GoogleFonts.outfit(fontWeight: FontWeight.w300,color: Colors.black),
                  )
                ],
              ),
              Row(children: [
                Text("63",
                    style: GoogleFonts.outfit(fontWeight: FontWeight.bold,color: Colors.black)),
                    const SizedBox(width: 10),
                    Icon(Icons.supervisor_account_sharp,color: Theme.of(context).primaryColor)
              ])
            ],
          ),
        ))
    );
  }
}
