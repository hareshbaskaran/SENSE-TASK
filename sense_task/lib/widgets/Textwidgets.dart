import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class tasktypetitle extends StatelessWidget {
  String text;
  tasktypetitle({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '$text',
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width * 0.045),
      ),
    );
  }
}

class mediumtext extends StatelessWidget {
  String text;
  mediumtext({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        '$text',
        style: GoogleFonts.lato(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }
}
