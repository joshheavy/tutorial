import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:leta_sasa/services/auth_service.dart';
import 'package:leta_sasa/services/geolocator_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:leta_sasa/utils/app_colors.dart';

class AddShopScreen extends StatefulWidget {
  @override
  _AddShopScreenState createState() => _AddShopScreenState();
}

class _AddShopScreenState extends State<AddShopScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool loading=false;

  toggleLoading(){
    setState(() {
      loading=!loading;
    });

  }

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    return FormBuilder(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.appBarColor,
            elevation: 0.0,
          ),
          backgroundColor: AppColors.appBarColor,
          body: loading?Center(child: CircularProgressIndicator()):Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Register Your Shop Now',
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ), 
              ),
              SizedBox(height: 70,),
              Container(
                padding: EdgeInsets.only(left:10),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)),
                child: FormBuilderTextField(
                  name: 'shop_name',
                  decoration: InputDecoration(
                    hintText: 'Shop Name',
                    suffixIcon: Icon(Icons.shop)
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.only(left:10, right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)),
                child: FormBuilderDropdown(
                  name: 'service_type',
                  decoration: InputDecoration(
                    labelText: 'Service Type',
                    hintText: 'Select Service Type',
                    isDense: true,
                  ),
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(context)]),
                  items: ['Miraa', 'Drinks', 'Food & Grocery']
                      .map((gender) => DropdownMenuItem(
                      value: gender, child: Text('$gender')))
                      .toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.only(left:10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)),
                child: FormBuilderDateTimePicker(
                  name: 'opening_time',
                  inputType: InputType.time,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'OPening time',
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: Color(0xFF8E8E8E),
                    ),
                  ),),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.only(left:10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)),
                child: FormBuilderDateTimePicker(
                  name: 'closing_time',
                  inputType: InputType.time,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Closing time',
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: Color(0xFF8E8E8E),
                    ),
                  ),),
              ),

              MaterialButton(
                color: Color(0xff24d875),
                height: 50,
                minWidth: 200,
                onPressed: ()async{
                toggleLoading();

                if(_formKey.currentState.saveAndValidate()){
                  Position location=await GeolocatorService().getLocation();
                FirebaseFirestore.instance.collection('shops').doc().set(
                    {..._formKey.currentState.value,
                      'latitude':location.latitude,
                      'longitude':location.longitude
                    }).then((value) {
                  Navigator.pop(context);
                  toggleLoading();
                  return value;
                });}
              },
              child: Text(
                "Add shop",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            )

            ],
          ),
        ));
  }
}
