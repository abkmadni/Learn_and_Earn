// ignore_for_file: must_be_immutable, camel_case_types

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/tools/applayout.dart';
import 'package:provider/provider.dart';
import 'package:textfield_datepicker/textfield_dateAndTimePicker.dart';
import 'package:intl/intl.dart';
import '../../../tools/appstate.dart';
import '../../../tools/col.dart';

class interview extends StatefulWidget {
  interview({super.key, required this.data, required this.keyval});
  Map data;
  String keyval;

  @override
  State<interview> createState() => _interviewState();
}

class _interviewState extends State<interview> {
  Key datekey = UniqueKey();
  TextEditingController _date = TextEditingController();
  TextEditingController _time = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);
    final datetimekey = provider.database.child('interview').push();

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                abouduser(num: widget.data['appliedby'].toString()),
                cer(
                  num: widget.data['appliedby'],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(widget.data['title'],
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: AppLayout.getwidth(context) * 0.05)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    widget.data['des'],
                    style: GoogleFonts.poppins(),
                  ),
                ),
                Container(
                  width: AppLayout.getwidth(context),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Interview link',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: AppLayout.getwidth(context) * 0.04),
                      ),
                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        ],
                        maxLines: null,
                        initialValue: "https://",
                        onChanged: (val) {
                          provider.confirm = val;
                        },
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(),
                            hintText: "Interview link"),
                        style: GoogleFonts.roboto(),
                      )
                    ],
                  ),
                ),
                Container(
                  width: AppLayout.getwidth(context),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Date/Time',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: AppLayout.getwidth(context) * 0.04),
                      ),
                      TextField(
                          controller: _date,
                          decoration: InputDecoration(
                              icon: Icon(Icons.date_range),
                              hintStyle: GoogleFonts.roboto()),
                          onTap: () async {
                            DateTime? pickeddate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year + 1));
                            var pickedtime = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            if (pickeddate != null) {
                              setState(() {
                                _date.text =
                                    DateFormat('dd-MM-yyyy').format(pickeddate);
                              });
                            }
                            if (pickedtime != null) {
                              setState(() {
                                _date.text += " " + pickedtime.format(context);
                              });
                            }
                          }),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (provider.confirm == "" || provider.pass == "") {
                      AppLayout.showsnakbar(
                          context, 'Add Interview link and Date Time');
                    } else {
                      final key = provider.database.child('interview').push();
                      key.set({
                        'link': provider.confirm,
                        'time': provider.pass,
                        'added': widget.data['added'],
                        'appliedby': widget.data['appliedby'],
                      }).then((value) {
                        provider.database
                            .child('applyjob')
                            .child(widget.keyval)
                            .remove();
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: AppLayout.getwidth(context) * 0.5,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      'Hire',
                      style: GoogleFonts.poppins(
                          color: col.wh,
                          fontWeight: FontWeight.w600,
                          fontSize: AppLayout.getwidth(context) * 0.05),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class cer extends StatelessWidget {
  cer({super.key, required this.num});
  String num;

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);

    return SizedBox(
      width: AppLayout.getwidth(context),
      height: 50,
      child: FutureBuilder(
          future: getcer(num, provider),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  Map s = snapshot.data as Map;
                  final k = s.keys;
                  return Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: col.pruple),
                    child: Center(
                      child: Text(
                        s[k.elementAt(index)]['title'].toString(),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, color: col.wh),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Icon(Icons.error_outline);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Future<Map> getcer(String num, AppState provider) async {
    Map fdata = {};
    await provider.database.child("getcer").child(num).get().then((value) {
      if (value.exists) {
        fdata = value.value as Map;
      }
    });
    return fdata;
  }
}

class abouduser extends StatelessWidget {
  abouduser({Key? key, required this.num}) : super(key: key);
  String num;

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);

    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: AppLayout.getwidth(context),
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.blue),
        child: FutureBuilder(
            future: getstdata(num, provider),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: col.wh,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data['img'].toString(),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data['name'],
                            style: GoogleFonts.poppins(
                              color: col.wh,
                              fontWeight: FontWeight.w600,
                              fontSize: AppLayout.getwidth(context) * 0.05,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.transgender,
                                color: col.wh,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                snapshot.data['gender'],
                                style: GoogleFonts.poppins(
                                  color: col.wh,
                                  fontSize: AppLayout.getwidth(context) * 0.035,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.school_outlined,
                                color: col.wh,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                snapshot.data['edu'],
                                style: GoogleFonts.poppins(
                                  color: col.wh,
                                  fontSize: AppLayout.getwidth(context) * 0.035,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return const Icon(Icons.error_outline);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

  Future<Map> getstdata(String num, AppState provider) async {
    Map sdata = {};
    await provider.database.child("user").child(num).get().then((value) {
      if (value.exists) {
        sdata = value.value as Map;
      }
    });
    return sdata;
  }
}
