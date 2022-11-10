import 'package:flutter/material.dart';
import 'package:yourfuel/models/fuel_price.dart';
import 'package:yourfuel/utils/app_utils.dart';
import 'package:intl/intl.dart';

import 'nhap_kho_bloc.dart';

class NhapKhoPage extends StatelessWidget {
  NhapKhoPage({Key? key}) : super(key: key);

  final _bloc = NhapKhoBloc();

  late TextStyle labelTextStyle;
  late TextStyle normalTextStyle;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _bloc.getData();
    });
    return Scaffold(
        backgroundColor: AppColors.pinkLightPurple,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("Nhập kho"),
          backgroundColor: AppColors.primaryColor,
        ),
        body: inputUI(context));
  }

  Widget inputUI(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                StreamBuilder<String>(
                    stream: _bloc.onChangeDate.stream,
                    initialData: DateFormat('dd-MM-yyyy').format(_bloc.today),
                    builder: (context, snapshot) {
                      return Text(
                        "Ngày nhập: " + snapshot.data!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                            fontSize: 17),
                      );
                    }),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                    onTap: () => _selectDate(context),
                    child: const Icon(
                      Icons.calendar_today,
                      color: AppColors.primaryColor,
                    ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  "Loại nhiên liệu: ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      fontSize: 17),
                ),
                const SizedBox(
                  width: 20,
                ),
               SizedBox(width: 100,height:50,child: dropdownType())
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            MoneyTextField(
              data: _bloc.itemNhapKho.soLuong.toString(),
              maxLength: 6,
              onDataChange: (value) => {_bloc.itemNhapKho.soLuong = value},
              labelText: "Số lượng:",
            ),
            MoneyTextField(
              data: _bloc.itemNhapKho.giaNhap.toString(),
              maxLength: 6,
              onDataChange: (value) => {_bloc.itemNhapKho.giaNhap = value},
              labelText: "Giá nhập:",
            ),
                InkWell(onTap: ()=>_bloc.onSave(context),
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    constraints: const BoxConstraints(minWidth: 100, maxWidth: 100),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: const LinearGradient(colors: [
                          AppColors.primaryColor,
                          AppColors.primaryColorDark
                        ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
                    child: const Text(
                      "Lưu",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          fontSize: 17),
                    ),
                  ),
                ),)
          ]),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _bloc.currentDay,
        firstDate: DateTime(2022),
        lastDate: DateTime(2025));
    if (picked != null) {
      print("rio get date: " + picked.day.toString());
      _bloc.currentDay = picked;
      _bloc.itemNhapKho.date=DateFormat('dd-MM-yyyy').format(picked);
      _bloc.onChangeDate.add(DateFormat('dd-MM-yyyy').format(picked));
    }
  }

  Widget dropdownType() {
    return StreamBuilder<FuelPrice>(
      stream: _bloc.onChangeFuelType.stream,
      initialData: _bloc.dropdownValue,
      builder: (context, snapshot) {
        return DropdownButton<FuelPrice>(
          value: _bloc.dropdownValue,
          isExpanded: true,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (FuelPrice? newValue) {
            _bloc.dropdownValue = newValue ?? _bloc.fuelPriceList[0];
            _bloc.itemNhapKho.typeName = _bloc.dropdownValue!.name;
            _bloc.onChangeFuelType.add(newValue ?? _bloc.fuelPriceList[0]);
          },
          items: _bloc.fuelPriceList
              .map<DropdownMenuItem<FuelPrice>>((FuelPrice value) {
            return DropdownMenuItem<FuelPrice>(
              value: value,
              child: Text(
                value.name,
                style: const TextStyle(fontSize: 13),
              ),
            );
          }).toList(),
        );
      }
    );
  }
}

class MoneyTextField extends StatelessWidget {
  MoneyTextField(
      {Key? key,
      required this.onDataChange,
      this.data,
      this.labelText,
      this.isEnable,
      this.maxLength})
      : super(key: key);

  TextEditingController textEditingController = TextEditingController();
  final Function(int) onDataChange;
  String? data;
  String? labelText;
  int? maxLength = 6;
  bool? isEnable = true;

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern("en").format(int.parse(s));

  @override
  Widget build(BuildContext context) {
    if (data != null && data!.isNotEmpty) {
      textEditingController.text = _formatNumber(data!.replaceAll(',', ''));
    } else {
      textEditingController.text = "";
    }
    return TextField(
        controller: textEditingController,
        keyboardType: TextInputType.number,
        maxLines: 1,
        enabled: isEnable,
        maxLength: maxLength,
        decoration: InputDecoration(
            counter: const Offstage(),
            labelText: labelText,
            fillColor: AppColors.primaryColor),
        onChanged: (value) {
          if (value.isNotEmpty) {
            value = value.replaceAll(",", "");
            onDataChange((value.isNotEmpty) ? int.parse(value) : 0);
            value = _formatNumber(value.replaceAll(',', ''));
            textEditingController.value = TextEditingValue(
              text: value,
              selection: TextSelection.collapsed(offset: value.length),
            );
          }
        });
  }
}
