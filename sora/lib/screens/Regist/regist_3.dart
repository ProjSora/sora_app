/// this page is for regist 3rd page
/// this page collect required information for regist
///   1. user name
///   2. user nick name
///   3. user gender
///   4. user university
///   5. user department
///   6. user student id

import 'package:flutter/material.dart';

import 'package:sora/screens/Regist/regist_4.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:sora/utils/university.dart';

String signUpGender = '남';
class SignUpThirdPage extends StatefulWidget {
  final String email;
  final String password;
  final String phone;
  const SignUpThirdPage(this.email, this.password, this.phone, {Key? key})
      : super(key: key);

  @override
  State<SignUpThirdPage> createState() => _SignUpThirdPageState();
}

class _SignUpThirdPageState extends State<SignUpThirdPage> {
  late TextEditingController nameController;
  late TextEditingController nickNameController;
  late TextEditingController universityController;
  late TextEditingController departmentController;
  late TextEditingController studentIdController;
  late TextEditingController mbtiController;

  final List<String> mbtiList = [
    'ISTJ', 'ISFJ', 'INFJ', 'INTJ',
    'ISTP', 'ISFP', 'INFP', 'INTP',
    'ESTP', 'ESFP', 'ENFP', 'ENTP',
    'ESTJ', 'ESFJ', 'ENFJ', 'ENTJ'
  ];

  late List<String> university = universityList;

  String? selectedMbti;
  String? selectedUniversity;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    nickNameController = TextEditingController();
    universityController = TextEditingController();
    departmentController = TextEditingController();
    studentIdController = TextEditingController();
    mbtiController = TextEditingController();
  }

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: ColorScheme.fromSwatch(primarySwatch: Colors.lightGreen)
                .secondary,
          ),
          title: const Text('회원가입', style: TextStyle(fontFamily: 'bitbit', fontSize: 30)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Center(  
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.radio_button_unchecked_outlined, size: 20),
                        SizedBox(width: 20),
                        Icon(Icons.radio_button_unchecked_outlined, size: 20),
                        SizedBox(width: 20),
                        Icon(Icons.radio_button_checked, size: 40),
                        SizedBox(width: 20),
                        Icon(Icons.radio_button_unchecked_outlined, size: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("회원가입을 위한 필수 정보를 입력 해 주세요."),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.person),
                                border: OutlineInputBorder(),
                                labelText: '이름',
                              ),
                            ),],
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GenderChoice()
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: nickNameController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.badge),
                            border: OutlineInputBorder(),
                            labelText: '닉네임',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: const Text('MBTI'),
                                items: mbtiList.map(
                                      (item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  ),
                                ).toList(),
                                value: selectedMbti,
                                onChanged: (value) => setState(() => selectedMbti = value),
                                buttonStyleData: ButtonStyleData(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  height: 65,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(color: Colors.grey),
                                  )
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(Icons.search),
                                ),
                                dropdownStyleData: const DropdownStyleData(
                                  maxHeight: 200,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                                dropdownSearchData: DropdownSearchData(
                                  searchController: mbtiController,
                                  searchInnerWidgetHeight: 50,
                                  searchInnerWidget: Container(
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 4,
                                      right: 8,
                                      left: 8,
                                    ),
                                    child: TextField(
                                      expands: true,
                                      maxLines: null,
                                      controller: mbtiController,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        hintText: 'MBTI 검색',
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    )
                                  ),
                                  searchMatchFn: (item, searchValue) {
                                    return item.value.toString().contains(searchValue) || 
                                    item.value.toString().toLowerCase().contains(searchValue);
                                  }
                                ),
                                onMenuStateChange: (isOpened) {
                                  if (isOpened) {
                                    mbtiController.clear();
                                  }
                                },
                              )
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(
                        flex:1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.school)
                          ],
                        )
                      ),
                      Expanded(
                        flex: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: const Text('대학교'),
                                items: university.map(
                                      (item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  ),
                                ).toList(),
                                value: selectedUniversity,
                                onChanged: (value) => setState(() => selectedUniversity = value),
                                buttonStyleData: ButtonStyleData(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  height: 65,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color: Colors.black45),
                                  )
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(Icons.search),
                                ),
                                dropdownStyleData: const DropdownStyleData(
                                  maxHeight: 200,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                                dropdownSearchData: DropdownSearchData(
                                  searchController: universityController,
                                  searchInnerWidgetHeight: 50,
                                  searchInnerWidget: Container(
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 4,
                                      right: 8,
                                      left: 8,
                                    ),
                                    child: TextField(
                                      expands: true,
                                      maxLines: null,
                                      controller: universityController,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        hintText: '대학교 검색',
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    )
                                  ),
                                  searchMatchFn: (item, searchValue) {
                                    return item.value.toString().contains(searchValue);
                                  },
                                ),
                                onMenuStateChange: ((isOpen) {
                                  if (isOpen) {
                                    universityController.clear();
                                  }
                                })
                              )
                            )
                          ],
                        )
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: departmentController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.history_edu),
                      border: OutlineInputBorder(),
                      labelText: '학과',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: studentIdController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.numbers),
                      border: OutlineInputBorder(),
                      labelText: '학번',
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpFourthPage(
                            widget.email,
                            widget.password,
                            widget.phone,
                            nameController.text,
                            nickNameController.text,
                            selectedMbti!,
                            signUpGender,
                            selectedUniversity!,
                            departmentController.text,
                            studentIdController.text,
                          ),
                        ),
                      );
                    },
                    child: const Text('다음'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum Genders {male, female}

class GenderChoice extends StatefulWidget {
  const GenderChoice({Key? key}) : super(key: key);

  @override
  State<GenderChoice> createState() => _GenderChoiceState();
}

class _GenderChoiceState extends State<GenderChoice> {
  Genders selectedGender = Genders.male;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Genders>(
      segments: const <ButtonSegment<Genders>>[
        ButtonSegment<Genders>(
          value: Genders.male,
          label: Text('남자'),
          icon: Icon(Icons.man),
        ),
        ButtonSegment(
          value: Genders.female,
          label: Text("여자"),
          icon: Icon(Icons.girl)
        )
      ],
      selected: <Genders>{selectedGender},
      onSelectionChanged: (Set<Genders> newSelection) {
        setState(() {
          selectedGender = newSelection.first;
          if (selectedGender == Genders.male){
            signUpGender = '남';
          } else {
            signUpGender = '여';
          }
        });
      },
    );
  }
}