import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kpu_app_serkom/bloc/add_user/add_user_cubit.dart';
import 'package:kpu_app_serkom/model/user_model.dart';
import 'package:kpu_app_serkom/theme.dart';
import 'package:kpu_app_serkom/widgets/custom_form.dart';
import 'package:permission_handler/permission_handler.dart';

class FormEntry extends StatefulWidget {
  const FormEntry({super.key});

  @override
  _FormEntryState createState() => _FormEntryState();
}

class _FormEntryState extends State<FormEntry> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nikEcd = TextEditingController();
  TextEditingController nameEcd = TextEditingController();
  TextEditingController noEcd = TextEditingController();
  TextEditingController alamatEcd = TextEditingController();
  String? _gender, _date;

  File? _image;
  final ImagePicker _picker = ImagePicker();
  @override
  void dispose(){
    super.dispose();
    nikEcd.dispose();
    nameEcd.dispose();
    noEcd.dispose();
    alamatEcd.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      final status = await Permission.camera.request();
      if (status != PermissionStatus.granted) {
        return;
      }
    } else if (source == ImageSource.gallery) {
      final status = await Permission.photos.request();
      if (status != PermissionStatus.granted) {
        return;
      }
    }

    final XFile? pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddUserCubit, AddUserState>(
      listener: (context, state) {
        if(state is AddUserSuccess){
          ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Berhasil menambahkan data"), backgroundColor: Colors.green,));
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Form Entry'),
        ),
        body: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRow(
                            'NIK',
                            CustomForm(
                                keyboardType: TextInputType.number,
                                controller: nikEcd,
                                hintText: "Masukan NIK")),
                        _buildRow(
                            'Nama',
                            CustomForm(
                                controller: nameEcd, hintText: "Masukan Nama")),
                        _buildRow(
                            'No. HP',
                            CustomForm(
                                keyboardType: TextInputType.phone,
                                controller: noEcd,
                                hintText: "08XXX")),
                        _buildRow(
                            "JK",
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'L',
                                  groupValue: _gender,
                                  onChanged: (value) {
                                    setState(() {
                                      _gender = value;
                                    });
                                  },
                                ),
                                const Text("L"),
                                Radio<String>(
                                  value: 'P',
                                  groupValue: _gender,
                                  onChanged: (value) {
                                    setState(() {
                                      _gender = value;
                                    });
                                  },
                                ),
                                const Text("P"),
                              ],
                            )),
                        _buildRow(
                          "Tanggal",
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Pilih tanggal'),
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _date = "${pickedDate.toLocal()}".split(' ')[0];
                                });
                              }
                            },
                            readOnly: true,
                            controller: TextEditingController(text: _date),
                          ),
                        ),
                        _buildRow(
                            'Alamat',
                            CustomForm(
                                controller: alamatEcd, hintText: "Masukan alamat")),
                        _buildRow(
                            "",
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: cDarkGreen),
                                onPressed: () {},
                                child: const Text(
                                  "Cek Lokasi",
                                  style: TextStyle(color: Colors.white),
                                ))),
                        _buildRow(
                          "",
                          GestureDetector(
                            onTap: _showImageSourceActionSheet,
                            child: Container(
                              color: Colors.grey[300],
                              height: 150,
                              width: double.infinity,
                              child: _image != null
                                  ? Image.file(
                                      _image!,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(Icons.add_a_photo, size: 50),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: cDarkGreen),
                              onPressed: () {
                                context.read<AddUserCubit>().addUser(UsersModel(alamat: alamatEcd.text, jk: _gender??"", name: nameEcd.text, gamber: "asd", nik: int.parse(nikEcd.text), no: noEcd.text, tanggal: _date ?? ""));
                              },
                              child: const Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(label),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}