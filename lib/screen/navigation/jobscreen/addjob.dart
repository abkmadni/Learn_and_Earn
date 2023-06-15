import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/tools/applayout.dart';
import 'package:my_flutter_app/tools/col.dart';
import 'package:my_flutter_app/tools/top.dart';
import 'package:provider/provider.dart';

import '../../../tools/appstate.dart';

class addjob extends StatelessWidget {
  const addjob({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              top(title: "Add Job"),

              Container(
                width: AppLayout.getwidth(context),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.1)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Job Title',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize: AppLayout.getwidth(context)*0.04),),
                    TextFormField(
                      onChanged: (val){
                          provider.name = val;
                      },
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.roboto(),
                        hintText: "Job Title"
                      ),
                      style: GoogleFonts.roboto(),
                    )
                  ],
                ),
              ),

              Container(
                width: AppLayout.getwidth(context),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.1)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Description',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize: AppLayout.getwidth(context)*0.04),),
                    TextFormField(
                      maxLines: null,
                      onChanged: (val){
                          provider.otp = val;
                      },
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.roboto(),
                          hintText: "Description"
                      ),
                      style: GoogleFonts.roboto(),
                    )
                  ],
                ),
              ),

              Container(
                width: AppLayout.getwidth(context),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.1)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Company name',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize: AppLayout.getwidth(context)*0.04),),
                    TextFormField(
                      maxLines: null,
                      onChanged: (val){
                        provider.confirm = val;
                      },
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.roboto(),
                          hintText: "Company name"
                      ),
                      style: GoogleFonts.roboto(),
                    )
                  ],
                ),
              ),

              Container(
                width: AppLayout.getwidth(context),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.1)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Salary',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize: AppLayout.getwidth(context)*0.04),),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (val){
                        provider.pass = val;
                      },
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.roboto(),
                          hintText: "Salary"
                      ),
                      style: GoogleFonts.roboto(),
                    )
                  ],
                ),
              ),

              InkWell(
                onTap: () async {
                  if(provider.name==''||provider.confirm==''||provider.otp==''||provider.pass==''){
                    AppLayout.showsnakbar(context, "Fill all fields");
                  }else{

                    final key = await provider.database.child('job').push();
                    await key.set({
                      "title":provider.name,
                      "des":provider.otp,
                      "salary":provider.pass,
                      'comp':provider.confirm,
                      'added':provider.prefs.getString('phone')
                    });

                    AppLayout.showsnakbar(context, "Applied sucessfully");
                    Navigator.pop(context);

                  }
                },
                child: Container(
                  width: AppLayout.getwidth(context)*0.4,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: col.pruple
                  ),
                  child:
                      Center(child: Text('Add',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,
                          fontSize: AppLayout.getwidth(context)*0.04,color: Colors.white),)),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
