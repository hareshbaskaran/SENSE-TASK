import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class tasktypetitle extends StatelessWidget {
  String text = 'default text';
  tasktypetitle({Key? key, text: String}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: MediaQuery.of(context).size.width * 0.045),
    );
  }
}
