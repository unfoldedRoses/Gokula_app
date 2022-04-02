import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_editable_table/constants.dart';
import 'package:flutter_editable_table/entities/table_entity.dart';
import 'package:flutter_editable_table/flutter_editable_table.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:gokula/Models/farmer_dairy.dart';
import 'package:gokula/constants/dairyFarmer.utils.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class DairyFarmer extends StatefulWidget {
  const DairyFarmer({Key? key}) : super(key: key);

  @override
  State<DairyFarmer> createState() => _DairyFarmerState();
}

class _DairyFarmerState extends State<DairyFarmer> {
  // static const platform = MethodChannel("razorpay_flutter");
  late Razorpay _razorpay;

  final maskFormatter = MaskTextInputFormatter(
      mask: '####-####-####-####', filter: {"#": RegExp(r'[0-9]')});

  final phoneMaskFormatter = MaskTextInputFormatter(
      mask: '###-###-####', filter: {"#": RegExp(r'[0-9]')});

  final GlobalKey<FormBuilderState> _personalFormKey =
      GlobalKey<FormBuilderState>();

  final GlobalKey<FormBuilderState> _cropFormKey =
      GlobalKey<FormBuilderState>();

  // final GlobalKey<FormBuilderState> _cropsForm = GlobalKey<FormBuilderState>();
  // final _editableKey = GlobalKey<EditableState>();

  final _farmer = Farmerdairy();

  final _editableTableKey = GlobalKey<EditableTableState>();
  final _editableNPTableKey = GlobalKey<EditableTableState>();

  final data = {
    "column_count": null,
    "row_count": null,
    "addable": true,
    "removable": true,
    "caption": {
      "layout_direction": "row",
      "main_caption": {
        "title": "Crops",
        "display": true,
        "editable": false,
        "style": {
          "font_weight": "bold",
          "font_size": 18.0,
          "font_color": "#333333",
          "background_color": null,
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "left"
        }
      },
      "sub_caption": {
        "title": null,
        "display": true,
        "editable": true,
        "input_decoration": {
          "min_lines": 1,
          "max_lines": 1,
          "max_length": 64,
          "hint_text": "Please input the sub-caption",
          "fill_color": null
        },
        "constrains": {"required": true},
        "style": {
          "font_weight": "normal",
          "font_size": 14.0,
          "font_color": "#333333",
          "background_color": null,
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      }
    },
    "columns": [
      {
        "primary_key": true,
        "name": "id",
        "type": "int",
        "format": null,
        "description": null,
        "display": false,
        "editable": false,
        "style": {
          "font_weight": "bold",
          "font_size": 14.0,
          "font_color": "#333333",
          "background_color": "#b5cfd2",
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      },
      {
        "auto_increase": true,
        "type": "int",
        "format": "__VALUE__",
        "description": null,
        "display": true,
        "editable": false,
        "width_factor": 0.2,
        "style": {
          "font_weight": "bold",
          "font_size": 14.0,
          "font_color": "#333333",
          "background_color": "#b5cfd2",
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      },
      {
        "name": "cropName",
        "title": "Crop Name",
        "type": "string",
        "format": null,
        "description": "Crop Name",
        "display": true,
        "editable": true,
        "width_factor": 0.4,
        "input_decoration": {
          "min_lines": 1,
          "max_lines": 1,
          "max_length": 128,
          "hint_text": "Please input the crop name"
        },
        "constrains": {"required": true},
        "style": {
          "font_weight": "bold",
          "font_size": 14.0,
          "font_color": "#333333",
          "background_color": "#b5cfd2",
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      },
      {
        "name": "variety",
        "title": "Variety",
        "type": "string",
        "format": null,
        "description": "Variety",
        "display": true,
        "editable": true,
        "width_factor": 0.2,
        "input_decoration": {
          "min_lines": 1,
          "max_lines": 1,
          "max_length": 3,
          "hint_text": "Please input the variety"
        },
        "constrains": {"required": true, "minimum": 1, "maximum": 120},
        "style": {
          "font_weight": "bold",
          "font_size": 14.0,
          "font_color": "#333333",
          "background_color": "#b5cfd2",
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      },
      {
        "name": "season",
        "title": "Season",
        "type": "string",
        "format": null,
        "description": "Season",
        "display": true,
        "editable": true,
        "width_factor": 0.4,
        "input_decoration": {
          "min_lines": 3,
          "max_lines": 5,
          "max_length": 128,
          "hint_text": "Please input the season"
        },
        "constrains": {"required": false, "minimum": 1, "maximum": 100},
        "style": {
          "font_weight": "bold",
          "font_size": 14.0,
          "font_color": "#333333",
          "background_color": "#b5cfd2",
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      },
      {
        "name": "monthOfSowing",
        "title": "Month Of Sowing",
        "type": "string",
        "format": null,
        "description": "Month Of Sowing",
        "display": true,
        "editable": true,
        "width_factor": 0.2,
        "input_decoration": {
          "min_lines": 1,
          "max_lines": 1,
          "max_length": 128,
          "hint_text": "Please input the month"
        },
        "constrains": {"required": true, "minimum": -100, "maximum": 10000},
        "style": {
          "font_weight": "bold",
          "font_size": 14.0,
          "font_color": "#333333",
          "background_color": "#b5cfd2",
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      },
      {
        "name": "estimatedYield",
        "title": "Estimated Yield",
        "type": "string",
        "format": null,
        "description": "Estimated Yield",
        "display": true,
        "editable": true,
        "width_factor": 0.12,
        "input_decoration": {
          "min_lines": 1,
          "max_lines": 1,
          "max_length": 128,
          "hint_text": "Please input the estimated yield"
        },
        "constrains": {"required": false},
        "style": {
          "font_weight": "bold",
          "font_size": 14.0,
          "font_color": "#333333",
          "background_color": "#b5cfd2",
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      },
      {
        "name": "actualYield",
        "title": "Actual Yield",
        "type": "string",
        "format": null,
        "description": "Actual Yield",
        "display": true,
        "editable": true,
        "width_factor": 0.3,
        "input_decoration": {"hint_text": "Please input the actual yield"},
        "style": {
          "font_weight": "bold",
          "font_size": 14.0,
          "font_color": "#333333",
          "background_color": "#b5cfd2",
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      },
    ],
    "rows": [
      {
        "id": 0,
        "cropName": "Tom",
        "variety": "Rice",
        "season": "Karif",
        "monthOfSowing": 'January',
        "estimatedYield": '10 acres',
        "actualYield": '9 acres',
      },
    ],
  };

  final dataNP = {
    "column_count": null,
    "row_count": null,
    "addable": true,
    "removable": true,
    "caption": {
      "layout_direction": "row",
      "main_caption": {
        "title": "Neighbouring Plots",
        "display": true,
        "editable": false,
        "style": {
          "font_weight": "bold",
          "font_size": 18.0,
          "font_color": "#333333",
          "background_color": null,
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "left"
        }
      },
      "sub_caption": {
        "title": null,
        "display": false,
        "editable": false,
        "input_decoration": {
          "min_lines": 1,
          "max_lines": 1,
          "max_length": 64,
          "hint_text": "Please input the sub-caption",
          "fill_color": null
        },
        "constrains": {"required": true},
        "style": {
          "font_weight": "normal",
          "font_size": 14.0,
          "font_color": "#333333",
          "background_color": null,
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      }
    },
    "columns": [
      {
        "primary_key": true,
        "name": "id",
        "type": "int",
        "format": null,
        "description": null,
        "display": false,
        "editable": false,
        "style": {
          "font_weight": "bold",
          "font_size": 14.0,
          "font_color": "#333333",
          "background_color": "#b5cfd2",
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      },
      {
        "auto_increase": true,
        "type": "int",
        "format": "__VALUE__",
        "description": null,
        "display": true,
        "editable": false,
        "width_factor": 0.2,
        "style": {
          "font_weight": "bold",
          "font_size": 14.0,
          "font_color": "#333333",
          "background_color": "#b5cfd2",
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      },
      {
        "name": "north",
        "title": "North",
        "type": "string",
        "format": null,
        "description": "North",
        "display": true,
        "editable": true,
        "width_factor": 0.4,
        "input_decoration": {
          "min_lines": 1,
          "max_lines": 1,
          "max_length": 128,
          "hint_text": "Please input the north"
        },
        "constrains": {"required": true},
        "style": {
          "font_weight": "bold",
          "font_size": 14.0,
          "font_color": "#333333",
          "background_color": "#b5cfd2",
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      },
      {
        "name": "south",
        "title": "South",
        "type": "string",
        "format": null,
        "description": "South",
        "display": true,
        "editable": true,
        "width_factor": 0.2,
        "input_decoration": {
          "min_lines": 1,
          "max_lines": 1,
          "max_length": 3,
          "hint_text": "Please input the south"
        },
        "constrains": {"required": true, "minimum": 1, "maximum": 120},
        "style": {
          "font_weight": "bold",
          "font_size": 14.0,
          "font_color": "#333333",
          "background_color": "#b5cfd2",
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      },
      {
        "name": "west",
        "title": "West",
        "type": "string",
        "format": null,
        "description": "West",
        "display": true,
        "editable": true,
        "width_factor": 0.4,
        "input_decoration": {
          "min_lines": 3,
          "max_lines": 5,
          "max_length": 128,
          "hint_text": "Please input the west"
        },
        "constrains": {"required": false, "minimum": 1, "maximum": 100},
        "style": {
          "font_weight": "bold",
          "font_size": 14.0,
          "font_color": "#333333",
          "background_color": "#b5cfd2",
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      },
      {
        "name": "east",
        "title": "East",
        "type": "string",
        "format": null,
        "description": "East",
        "display": true,
        "editable": true,
        "width_factor": 0.2,
        "input_decoration": {
          "min_lines": 1,
          "max_lines": 1,
          "max_length": 128,
          "hint_text": "Please input the east"
        },
        "constrains": {"required": true, "minimum": -100, "maximum": 10000},
        "style": {
          "font_weight": "bold",
          "font_size": 14.0,
          "font_color": "#333333",
          "background_color": "#b5cfd2",
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      },
    ],
    "rows": [
      {
        "id": 0,
        "north": "",
        "south": "",
        "west": "",
        "east": "",
      },
    ],
  };
  bool editing = false;
  bool editingNP = false;

  @override
  Widget build(BuildContext context) {
    final steps = [
      CoolStep(
          title: 'Personal Details',
          subtitle: 'Please fill in the personal details',
          content: FormBuilder(
              key: _personalFormKey,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                child: SingleChildScrollView(
                  child: Wrap(
                    runSpacing: 15.0,
                    children: [
                      FormBuilderTextField(
                        name: 'farmerName',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialValue: _farmer.personalDetails?.farmerName,
                        validator: ValidationBuilder().required().build(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            label: const Text(DairyFarmerFields.farmerName),
                            hintText: 'Enter ' + DairyFarmerFields.farmerName),
                      ),
                      FormBuilderTextField(
                        name: 'surname',
                        initialValue: _farmer.personalDetails?.surname,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: ValidationBuilder().required().build(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            label: const Text(DairyFarmerFields.surname),
                            hintText: 'Enter ' + DairyFarmerFields.surname),
                      ),
                      FormBuilderTextField(
                        name: 'fatherName',
                        initialValue: _farmer.personalDetails?.fatherName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: ValidationBuilder().required().build(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            label: const Text(DairyFarmerFields.fatherName),
                            hintText: 'Enter ' + DairyFarmerFields.fatherName),
                      ),
                      FormBuilderTextField(
                        name: 'village',
                        initialValue: _farmer.personalDetails?.village,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: ValidationBuilder().required().build(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            label: const Text(DairyFarmerFields.village),
                            hintText: 'Enter ' + DairyFarmerFields.village),
                      ),
                      FormBuilderTextField(
                        name: 'taluka',
                        initialValue: _farmer.personalDetails?.taluka,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: ValidationBuilder().required().build(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            label: const Text(DairyFarmerFields.taluka),
                            hintText: 'Enter ' + DairyFarmerFields.taluka),
                      ),
                      FormBuilderTextField(
                        name: 'aadharNo',
                        initialValue: _farmer.personalDetails?.aadharNo,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: ValidationBuilder().required().build(),
                        inputFormatters: [maskFormatter],
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            label: const Text(DairyFarmerFields.aadharNo),
                            hintText: 'Enter ' + DairyFarmerFields.aadharNo),
                      ),
                      FormBuilderTextField(
                        name: 'phoneNo',
                        initialValue: _farmer.personalDetails?.phoneNo,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator:
                            ValidationBuilder().required().phone().build(),
                        inputFormatters: [phoneMaskFormatter],
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            label: const Text(DairyFarmerFields.phoneNo),
                            hintText: 'Enter ' + DairyFarmerFields.phoneNo),
                      ),
                      FormBuilderTextField(
                        name: 'pan',
                        initialValue: _farmer.personalDetails?.pan,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: ValidationBuilder().required().build(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            label: const Text(DairyFarmerFields.pan),
                            hintText: 'Enter ' + DairyFarmerFields.pan),
                      ),
                    ],
                  ),
                ),
              )),
          validation: () {
            if (!_personalFormKey.currentState!.validate()) {
              debugPrint('farmer to json');
              return 'Fill form correctly';
            } else {
              _personalFormKey.currentState?.save();
              final _personal = _personalFormKey.currentState?.value;
              final _encodedP = jsonEncode(_personal);
              final _decodedP = jsonDecode(_encodedP);
              _farmer.personalDetails = PersonalDetails.fromJson(_decodedP);
              inspect(_farmer.toJson());

              return null;
            }
          }),
      CoolStep(
          title: 'Crop Details',
          subtitle: 'Please fill crop details',
          content: FormBuilder(
              key: _cropFormKey,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 35, left: 25, right: 25),
                child: SingleChildScrollView(
                  child: Wrap(
                    runSpacing: 15.0,
                    children: [
                      const Text('Status of Farmer (ರೈತರ ವಿವರ)'),
                      FormBuilderCheckboxGroup(
                        name: 'farmerStatus',
                        options: [
                          'IC1 (ಒಂದನೇಯ ಪರಿವತ೯ನೆ)',
                          'IC2 (ಎರಡನೇಯ ಪರಿವತ್೯ನೆ)',
                          'IC3 (ಸಾವಯವ-ಮೂರನೆಯ ಪರಿವತ೯ನೆ)',
                          '೧೦೦% Organic ಸಾವಯವ'
                        ]
                            .map(
                              (data) => FormBuilderFieldOption(
                                child: Text(data),
                                value: data,
                              ),
                            )
                            .toList(growable: false),
                      ),
                      const Text('Actual Area Cultivation (ಒಟ್ಟು ಜಮೀನು):'),
                      Row(
                        children: <Widget>[
                          Flexible(
                              flex: 1,
                              child: FormBuilderTextField(
                                name: 'actualAreaCultivation',
                                keyboardType: TextInputType.number,
                                validator:
                                    ValidationBuilder().required().build(),
                                decoration: const InputDecoration(
                                    filled: true,
                                    labelText: 'Area',
                                    contentPadding: EdgeInsets.all(0.0),
                                    helperText: '( ೧ ಹೆ = ೨.೫ ಎಕರೆ)'),
                              )),
                          Flexible(
                            flex: 1,
                            child: FormBuilderDropdown(
                                name: 'actualAreaCultivationType',
                                hint: const Text('Select Type'),
                                validator:
                                    ValidationBuilder().required().build(),
                                decoration: const InputDecoration(
                                    filled: true,
                                    helperText: '( ೧ ಹೆ = ೨.೫ ಎಕರೆ)',
                                    helperStyle: TextStyle(color: Colors.white),
                                    contentPadding: EdgeInsets.all(0.0)),
                                items: ['Acre  (ಎಕರೆ)', 'Ha (ಹೆ) ನೆನಪಿಡಿ']
                                    .map((String unit) =>
                                        DropdownMenuItem<String>(
                                            value: unit, child: Text(unit)))
                                    .toList(),
                                onChanged: (value) => {}),
                          )
                        ],
                      ),
                      const Text(
                          'Crop Under Cultivation( ವಾಸ್ತವ ಬೆಳೆಯುತ್ತಿರುವ ಜಮೀನು):'),
                      Row(
                        children: <Widget>[
                          Flexible(
                              flex: 1,
                              child: FormBuilderTextField(
                                name: 'cropUnderCultivation',
                                keyboardType: TextInputType.number,
                                validator:
                                    ValidationBuilder().required().build(),
                                decoration: const InputDecoration(
                                    filled: true,
                                    labelText: 'Area',
                                    contentPadding: EdgeInsets.all(0.0),
                                    helperText: '( ೧ ಹೆ = ೨.೫ ಎಕರೆ)'),
                              )),
                          Flexible(
                            flex: 1,
                            child: FormBuilderDropdown(
                                name: 'cropUnderCultivationType',
                                hint: const Text('Select Type'),
                                validator:
                                    ValidationBuilder().required().build(),
                                decoration: const InputDecoration(
                                    filled: true,
                                    helperText: '( ೧ ಹೆ = ೨.೫ ಎಕರೆ)',
                                    helperStyle: TextStyle(color: Colors.white),
                                    contentPadding: EdgeInsets.all(0.0)),
                                items: ['Acre  (ಎಕರೆ)', 'Ha (ಹೆ) ನೆನಪಿಡಿ']
                                    .map((String unit) =>
                                        DropdownMenuItem<String>(
                                            value: unit, child: Text(unit)))
                                    .toList(),
                                onChanged: (value) => {}),
                          )
                        ],
                      ),
                      const Text(
                          'Organic Area Cultivation ( ಸಾವಯವದಲ್ಲಿರುವ ಕ್ರಷಿ ಜಮೀನು):'),
                      Row(
                        children: <Widget>[
                          Flexible(
                              flex: 1,
                              child: FormBuilderTextField(
                                name: 'organicAreaCultivation',
                                keyboardType: TextInputType.number,
                                validator:
                                    ValidationBuilder().required().build(),
                                decoration: const InputDecoration(
                                    filled: true,
                                    labelText: 'Area',
                                    contentPadding: EdgeInsets.all(0.0),
                                    helperText: '( ೧ ಹೆ = ೨.೫ ಎಕರೆ)'),
                              )),
                          Flexible(
                            flex: 1,
                            child: FormBuilderDropdown(
                                name: 'organicAreaCultivationType',
                                hint: const Text('Select Type'),
                                validator:
                                    ValidationBuilder().required().build(),
                                decoration: const InputDecoration(
                                    filled: true,
                                    helperText: '( ೧ ಹೆ = ೨.೫ ಎಕರೆ)',
                                    helperStyle: TextStyle(color: Colors.white),
                                    contentPadding: EdgeInsets.all(0.0)),
                                items: ['Acre  (ಎಕರೆ)', 'Ha (ಹೆ) ನೆನಪಿಡಿ']
                                    .map((String unit) =>
                                        DropdownMenuItem<String>(
                                            value: unit, child: Text(unit)))
                                    .toList(),
                                onChanged: (value) => {}),
                          )
                        ],
                      ),
                      FormBuilderDropdown(
                        name: 'irrigationSource',
                        validator: ValidationBuilder().required().build(),
                        decoration: const InputDecoration(
                            filled: true,
                            labelText: 'Source of Irrigation (ನಿರಾವರಿ ಸೌಲಭ್ಯ)',
                            helperText: '( ೧ ಹೆ = ೨.೫ ಎಕರೆ)',
                            helperStyle: TextStyle(color: Colors.white),
                            contentPadding: EdgeInsets.all(0.0)),
                        items: [
                          'Bore well ( ಕೊಳವೆ ಬಾವಿ)',
                          'Open well ( ತೆರೆದ ಬಾವಿ)',
                          'Canal/River ( ಕೆನಾಲ್/ನದಿ ಪಂಪಸೆಟ್)'
                        ]
                            .map((String unit) => DropdownMenuItem<String>(
                                value: unit, child: Text(unit)))
                            .toList(),
                      ),
                      FormBuilderDropdown(
                          name: 'soilType',
                          validator: ValidationBuilder().required().build(),
                          decoration: const InputDecoration(
                              filled: true,
                              labelText: 'Soil Type (ಮಣ್ಣೀನ ವಿಧ)',
                              helperText: '( ೧ ಹೆ = ೨.೫ ಎಕರೆ)',
                              helperStyle: TextStyle(color: Colors.white),
                              contentPadding: EdgeInsets.all(0.0)),
                          items: [
                            'Red Soil( ಕೆಂಪು ಮಣ್ಣೂ)',
                            'Black soil (ಕರಿ/ಎರೆ ಭೂಮಿ/Sandy soil (ಮರಳು ಮಿಶ್ರಿತ)',
                            'Mixed ( ಮಿಶ್ರಿತ)'
                          ]
                              .map((String unit) => DropdownMenuItem<String>(
                                  value: unit, child: Text(unit)))
                              .toList(),
                          onChanged: (value) => {}),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const Text('Crops'),
                      //     IconButton(
                      //         onPressed: () => Dialogs.materialDialog(
                      //                 color: Colors.white,
                      //                 context: context,
                      //                 customView: FormBuilder(
                      //                   key: _cropsForm,
                      //                   child: Padding(
                      //                     padding: const EdgeInsets.symmetric(
                      //                         horizontal: 20.0, vertical: 15.0),
                      //                     child:
                      //                         Wrap(runSpacing: 10.0, children: [
                      //                       FormBuilderTextField(
                      //                         name: 'cropName',
                      //                         validator: ValidationBuilder()
                      //                             .required()
                      //                             .build(),
                      //                         decoration: const InputDecoration(
                      //                           filled: true,
                      //                           labelText: 'Crop Name',
                      //                           contentPadding:
                      //                               EdgeInsets.all(0.0),
                      //                         ),
                      //                       ),
                      //                       FormBuilderTextField(
                      //                         name: 'variety',
                      //                         validator: ValidationBuilder()
                      //                             .required()
                      //                             .build(),
                      //                         decoration: const InputDecoration(
                      //                           filled: true,
                      //                           labelText: 'Variety',
                      //                           contentPadding:
                      //                               EdgeInsets.all(0.0),
                      //                         ),
                      //                       ),
                      //                       FormBuilderTextField(
                      //                         name: 'season',
                      //                         validator: ValidationBuilder()
                      //                             .required()
                      //                             .build(),
                      //                         decoration: const InputDecoration(
                      //                           filled: true,
                      //                           labelText: 'Season',
                      //                           contentPadding:
                      //                               EdgeInsets.all(0.0),
                      //                         ),
                      //                       ),
                      //                       FormBuilderTextField(
                      //                         name: 'monthOfSowing',
                      //                         validator: ValidationBuilder()
                      //                             .required()
                      //                             .build(),
                      //                         decoration: const InputDecoration(
                      //                           filled: true,
                      //                           labelText: 'Month of Sowing',
                      //                           contentPadding:
                      //                               EdgeInsets.all(0.0),
                      //                         ),
                      //                       ),
                      //                       FormBuilderTextField(
                      //                         name: 'estimatedYield',
                      //                         validator: ValidationBuilder()
                      //                             .required()
                      //                             .build(),
                      //                         decoration: const InputDecoration(
                      //                           filled: true,
                      //                           labelText: 'Estimated Yield',
                      //                           contentPadding:
                      //                               EdgeInsets.all(0.0),
                      //                         ),
                      //                       ),
                      //                       FormBuilderTextField(
                      //                         name: 'actualYield',
                      //                         validator: ValidationBuilder()
                      //                             .required()
                      //                             .build(),
                      //                         decoration: const InputDecoration(
                      //                           filled: true,
                      //                           labelText: 'Actual Yield',
                      //                           contentPadding:
                      //                               EdgeInsets.all(0.0),
                      //                         ),
                      //                       ),
                      //                     ]),
                      //                   ),
                      //                 ),
                      //                 actions: [
                      //                   IconsOutlineButton(
                      //                     onPressed: () {
                      //                       Navigator.of(context).pop();
                      //                     },
                      //                     text: 'Cancel',
                      //                     iconData: Icons.cancel_outlined,
                      //                     textStyle: const TextStyle(
                      //                         color: Colors.grey),
                      //                     iconColor: Colors.grey,
                      //                   ),
                      //                   IconsButton(
                      //                     onPressed: () {
                      //                       if (_cropsForm.currentState!
                      //                           .validate()) {
                      //                         inspect(_cropsForm
                      //                             .currentState?.value);
                      //                         crops.add(Cropinfo());
                      //                         Navigator.of(context).pop();
                      //                       }
                      //                     },
                      //                     text: "Submit",
                      //                     iconData: Icons.delete,
                      //                     color: Colors.green,
                      //                     textStyle: const TextStyle(
                      //                         color: Colors.white),
                      //                     iconColor: Colors.white,
                      //                   ),
                      //                 ]),
                      //         icon: const Icon(Icons.add))
                      //   ],
                      // ),
                      // _getBodyWidget(context),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const Text('Neighbouring Plots'),
                      //     IconButton(
                      //         onPressed: () => Dialogs.materialDialog(
                      //                 // msg:
                      //                 //     'Are you sure ? you can\'t undo this',
                      //                 // title: "Delete",
                      //                 color: Colors.white,
                      //                 context: context,
                      //                 customView: FormBuilder(
                      //                   key: _cropsForm,
                      //                   child: Column(
                      //                     children: [
                      //                       FormBuilderTextField(
                      //                         name: 'cropName',
                      //                         validator: ValidationBuilder()
                      //                             .required()
                      //                             .build(),
                      //                         decoration: const InputDecoration(
                      //                             filled: true,
                      //                             labelText: 'Crop Name',
                      //                             contentPadding:
                      //                                 EdgeInsets.all(0.0),
                      //                             helperText:
                      //                                 '( ೧ ಹೆ = ೨.೫ ಎಕರೆ)'),
                      //                       )
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 actions: [
                      //                   IconsOutlineButton(
                      //                     onPressed: () {
                      //                       Navigator.of(context).pop();
                      //                     },
                      //                     text: 'Cancel',
                      //                     iconData: Icons.cancel_outlined,
                      //                     textStyle: const TextStyle(
                      //                         color: Colors.grey),
                      //                     iconColor: Colors.grey,
                      //                   ),
                      //                   IconsButton(
                      //                     onPressed: () {},
                      //                     text: "Submit",
                      //                     iconData: Icons.delete,
                      //                     color: Colors.green,
                      //                     textStyle: const TextStyle(
                      //                         color: Colors.white),
                      //                     iconColor: Colors.white,
                      //                   ),
                      //                 ]),
                      //         icon: const Icon(Icons.add))
                      //   ],
                      // ),
                      // _getBodyWidget_NPlot(context)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Crops'),
                          const SizedBox(width: 8.0),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              WidgetsBinding.instance?.focusManager.primaryFocus
                                  ?.unfocus();
                              _editableTableKey.currentState?.readOnly =
                                  editing;
                              setState(() {
                                editing = !editing;
                              });
                              if (!editing) {
                                debugPrint(
                                    'table filling status: ${_editableTableKey.currentState?.currentData.isFilled}');
                              }
                            },
                            child: Icon(!editing ? Icons.add : Icons.check),
                          ),
                          const SizedBox(width: 14.0),
                        ],
                      ),
                      EditableTable(
                        key: _editableTableKey,
                        data: data,
                        entity: TableEntity.fromJson(data),
                        readOnly: true,
                        tablePadding: const EdgeInsets.all(8.0),
                        captionBorder: const Border(
                          top: BorderSide(color: Color(0xFF999999)),
                          left: BorderSide(color: Color(0xFF999999)),
                          right: BorderSide(color: Color(0xFF999999)),
                        ),
                        headerBorder:
                            Border.all(color: const Color(0xFF999999)),
                        rowBorder: Border.all(color: const Color(0xFF999999)),
                        footerBorder:
                            Border.all(color: const Color(0xFF999999)),
                        removeRowIcon: const Icon(
                          Icons.remove_circle_outline,
                          size: 24.0,
                          color: Colors.redAccent,
                        ),
                        addRowIcon: const Icon(
                          Icons.add_circle_outline,
                          size: 24.0,
                          color: Colors.white,
                        ),
                        addRowIconContainerBackgroundColor: Colors.blueAccent,
                        formFieldAutoValidateMode: AutovalidateMode.always,
                        onRowRemoved: (row) {
                          debugPrint('row removed: ${row.toString()}');
                        },
                        onRowAdded: () {
                          debugPrint('row added');
                        },
                        onFilling: (FillingArea area, dynamic value) {
                          debugPrint(
                              'filling: ${area.toString()}, value: ${value.toString()}');
                        },
                        onSubmitted: (FillingArea area, dynamic value) {
                          debugPrint(
                              'submitted: ${area.toString()}, value: ${value.toString()}');
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Neighbouring Plots'),
                          const SizedBox(width: 8.0),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              WidgetsBinding.instance?.focusManager.primaryFocus
                                  ?.unfocus();
                              _editableNPTableKey.currentState?.readOnly =
                                  editingNP;
                              setState(() {
                                editingNP = !editingNP;
                              });
                              if (!editingNP) {
                                debugPrint(
                                    'table filling status: ${_editableNPTableKey.currentState?.currentData.isFilled}');
                              }
                            },
                            child: Icon(!editing ? Icons.add : Icons.check),
                          ),
                          const SizedBox(width: 14.0),
                        ],
                      ),
                      EditableTable(
                        key: _editableNPTableKey,
                        data: dataNP,
                        entity: TableEntity.fromJson(dataNP),
                        readOnly: true,
                        tablePadding: const EdgeInsets.all(8.0),
                        captionBorder: const Border(
                          top: BorderSide(color: Color(0xFF999999)),
                          left: BorderSide(color: Color(0xFF999999)),
                          right: BorderSide(color: Color(0xFF999999)),
                        ),
                        headerBorder:
                            Border.all(color: const Color(0xFF999999)),
                        rowBorder: Border.all(color: const Color(0xFF999999)),
                        footerBorder:
                            Border.all(color: const Color(0xFF999999)),
                        removeRowIcon: const Icon(
                          Icons.remove_circle_outline,
                          size: 24.0,
                          color: Colors.redAccent,
                        ),
                        addRowIcon: const Icon(
                          Icons.add_circle_outline,
                          size: 24.0,
                          color: Colors.white,
                        ),
                        addRowIconContainerBackgroundColor: Colors.blueAccent,
                        formFieldAutoValidateMode: AutovalidateMode.always,
                        onRowRemoved: (row) {
                          debugPrint('row removed: ${row.toString()}');
                        },
                        onRowAdded: () {
                          debugPrint('row added');
                        },
                        onFilling: (FillingArea area, dynamic value) {
                          debugPrint(
                              'filling: ${area.toString()}, value: ${value.toString()}');
                        },
                        onSubmitted: (FillingArea area, dynamic value) {
                          debugPrint(
                              'submitted: ${area.toString()}, value: ${value.toString()}');
                        },
                      ),
                    ],
                  ),
                ),
              )),
          validation: () {
            if (!_cropFormKey.currentState!.saveAndValidate()) {
              return 'Fill correctly';
            } else {
              _cropFormKey.currentState!.save();

              return null;
            }
          })
    ];

    final stepper = CoolStepper(
        config: CoolStepperConfig(
            backText: 'PREV',
            finalText: 'SUBMIT',
            headerColor: Theme.of(context).primaryColor.withOpacity(0.0)),
        steps: steps,
        onCompleted: () {
          debugPrint('on complete...');
          debugPrint('on complete inside');

          final _cropDetails = _cropFormKey.currentState?.value;
          final _encodedCD = jsonEncode(_cropDetails);
          final _decodedCD = jsonDecode(_encodedCD);

          final farmer = {
            "personal": jsonDecode(jsonEncode(_farmer.personalDetails)),
            "cropDetails": _decodedCD
          };

          final personalCollection =
              FirebaseFirestore.instance.collection('farmers');
          personalCollection
              .add(farmer)
              .then((value) => {
                    debugPrint('farmer added ==> '),
                    inspect(value),
                    openCheckout(value.id, _farmer.personalDetails?.phoneNo)
                  })
              .catchError((error) => debugPrint("Failed to add user: $error"));

          // } else {
          //   debugPrint('on complete inside else');
          // }
        });

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/topbar.png'),
                        fit: BoxFit.cover)),
                child: Center(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(1.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0))),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: const Text('Farmer Dairy',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                                color: Colors.white)))),
              )),
          Expanded(
            flex: 5,
            child: stepper,
          )
        ],
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(String uId, String? phoneNo) async {
    debugPrint('open checkout: $uId');
    var options = {
      'key': 'rzp_test_pZ0ILvdDioJqo7',
      'amount': 2500 * 100,
      "notes": {"farmerId": uId},
      'name': 'Gokula Organic International LLP',
      'description': 'Farmer Registration Fee',
      'prefill': {'contact': phoneNo, 'email': 'test@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
      inspect(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Navigator.pushNamed(context, 'aboutUs');
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }
}
