import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:sora/providers/login_model.dart';
import 'package:sora/providers/user_model.dart';
import 'package:sora/screens/Login/login.dart';

import 'package:sora/screens/Profile/update_screens/email_update.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  // This widget is the profile page of the app.
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // This is the state of the profile page.
  static const storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    Login loginInfo = Provider.of<Login>(context);
    UserInfo userInfo = Provider.of<UserInfo>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('회원정보', style: TextStyle(fontFamily: 'bitbit', fontSize: 30)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            Text(userInfo.userNickName??"", style: const TextStyle(fontSize: 30, fontFamily: 'bitbit')),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${userInfo.userMbti?? ""} / ${userInfo.userGender ?? ""}"),
                                Text(userInfo.userUniversity ?? ""),
                                Text("${userInfo.userDepartment ?? ""} / ${userInfo.userStudentId ?? ""}"),
                              ],
                            ),
                            const SizedBox(width: 20),
                            if (userInfo.userAuth == true) const Text("인증됨", style: TextStyle(color: Colors.green)),
                            if (userInfo.userAuth == false) const Text("인증되지 않음", style: TextStyle(color: Colors.red)),
                            const SizedBox(width: 20),
                          ],
                        ),
                        const Divider(height: 0,),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("자기소개"),
                            Text(userInfo.userDescription ?? ""),
                          ],
                        )
                      ]
                    )
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text("  계정", style: TextStyle(fontFamily: "bitbit", fontSize: 25),),
                        const SizedBox(height: 10),
                        const Divider(height: 0,),
                        ListTile(
                          title: const Text('학교인증'),
                          onTap: () => Navigator.pushNamed(context, '/university'),
                        ),
                        const Divider(height: 0,),
                        ListTile(
                          title: const Text("비밀번호 변경"),
                          onTap: () => Navigator.pushNamed(context, '/password'),
                        ),
                        const Divider(height: 0,),
                        ListTile(
                          title: const Text("이메일 변경"),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EmailUpdate())),
                        ),
                      ],
                    )
                  )
                ),
                const SizedBox(width: 20),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text("  회원정보", style: TextStyle(fontFamily: "bitbit", fontSize: 25),),
                        const SizedBox(height: 10),
                        const Divider(height: 0,),
                        ListTile(
                          title: const Text('닉네임 변경'),
                          onTap: () => Navigator.pushNamed(context, '/university'),
                        ),
                        const Divider(height: 0,),
                        ListTile(
                          title: const Text("MBTI 변경"),
                          onTap: () => Navigator.pushNamed(context, '/password'),
                        ),
                        const Divider(height: 0,),
                        ListTile(
                          title: const Text("자기소개 수정"),
                          onTap: () => Navigator.pushNamed(context, '/password'),
                        ),
                      ],
                    )
                  )
                ),
                const SizedBox(width: 20),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text("  기타", style: TextStyle(fontFamily: "bitbit", fontSize: 25),),
                        const SizedBox(height: 10),
                        const Divider(height: 0,),
                        ListTile(
                          title: const Text('회원탈퇴', style: TextStyle(color: Colors.red)),
                          onTap: () => Navigator.pushNamed(context, '/university'),
                        ),
                        const Divider(height: 0,),
                        ListTile(
                          title: const Text("로그아웃", style: TextStyle(color: Colors.red)),
                          onTap: () async {
                            await storage.delete(key: "id");
                            await storage.delete(key: "password");
                            loginInfo.logout();
                            if (!mounted) return;
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ), (route) => false,
                            );
                          }
                        ),
                      ],
                    )
                  )
                ),
                const SizedBox(width: 20),
              ],
            ),
          ]
        ),
      ),
    );
  }
}