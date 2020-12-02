import 'dart:developer' as dev;

import 'package:data/local/entity/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_useful_things/components/alert/AlertConfig.dart';
import 'package:flutter_useful_things/components/alert/AlertActionSheet.dart';
import 'package:flutter_useful_things/components/containers/BackgroundContainer.dart';
import 'package:flutter_useful_things/components/image/UserIcon.dart';
import 'package:flutter_useful_things/components/menu/ExpandableMenu.dart';
import 'package:flutter_useful_things/components/textviews/EmptyState.dart';
import 'package:flutter_useful_things/components/textviews/Hyperlink.dart';
import 'package:flutter_useful_things/components/textviews/TextStyles.dart';
import 'package:core/constants/Colors.dart' as Constants;
import 'package:flutter_useful_things/di/Injection.dart';
import 'package:flutter_useful_things/routing/ScreenTransitions.dart';
import 'package:mopei_app/src/ui/login/LoginModal.dart';
import 'package:mopei_app/src/ui/main/user/UserBloc.dart';
import 'package:mopei_app/src/ui/payment/CardListScreen.dart';
import 'package:mopei_app/src/ui/payment/addCard/AddCreditCardScreen.dart';

class UserScreen extends StatefulWidget {

  _UserScreenState createState() => _UserScreenState();

}

class _UserScreenState extends State<UserScreen> {

  final UserBloc bloc = inject();

  void onSuccessLogin() {
    bloc.getSession();
  }

  @override
  void initState() {
    super.initState();
    bloc.getSession();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = Duration(milliseconds: 300);
    return Stack(
      children: <Widget>[
        StreamBuilder<bool>(
          stream: bloc.user.empty,
          initialData: false,
          builder: (context, snapshot) {
            bool show = snapshot.data;
            return AnimatedOpacity(
              duration: duration,
              opacity: show? 1 : 0,
              child: Center(
                child: EmptyState(
                  icon: Icons.account_circle,
                  title: "Você não está logado",
                  hyperlink: "Clique aqui para logar",
                  onHyperlinkPressed: () {
                    LoginModal(context, onSuccess: onSuccessLogin).show();
                  },
                ),
              )
            );
          },
        ),
        StreamBuilder<User>(
          stream: bloc.user.success,
          builder: (context, snapshot) {
            if(!snapshot.hasData) return Wrap();

            User user = snapshot.data;
            return Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      UserIcon(
                        userName: user.name,
                        imagePath: user.photoPath,
                        onPressed: () => dev.log("Teste"),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Wrap(
                            spacing: 6,
                            direction: Axis.vertical,
                            children: [
                              Text(user.name, style: TextStyles.subtitleWhiteBold,),
                              Hyperlink("Ver seu perfil", style: TextStyles.poppinsMedium,)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              UserMenuCard(
                                icon: Icon(Icons.home, size: 30, color: Constants.Colors.PRIMARY_SWATCH,),
                                text: "Endereços cadastrados",
                              ),
                              UserMenuCard(
                                  icon: Image.asset("assets/img/icMcCard.webp", height: 30, width: 30,),
                                  text: "Cartões cadastrados",
                                  onPress: () {
                                    ScreenTransitions.push(context, CardListScreen(), animation: Animations.SLIDE_DOWN);
                                  }
                              ),
                            ],
                          ),
                        ),
                        Container(width: 10),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              UserMenuCard(
                                icon: Icon(Icons.star, size: 30, color: Colors.amber,),
                                text: "Itens marcados como favorito",
                              ),
                              UserMenuCard(
                                icon: Icon(Icons.library_books, size: 30, color: Colors.blue,),
                                text: "Meus pedidos",
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ExpandableMenu(
                  menus: [
                    ExpandableMenuItem(
                        title: "Configurações",
                        icon: Stack(
                          alignment: Alignment.bottomLeft,
                          children: <Widget>[
                            Icon(Icons.brightness_5, size: 20, color: Constants.Colors.WHITE_TRANSPARENT_MEDIUM,),
                            Icon(Icons.build, size: 30, color: Colors.white,),
                          ],
                        ),
                        items: [
                          ExpandableItem(
                              icon: Icon(Icons.exit_to_app, size: 30, color: Colors.black,),
                              title: "Sair",
                              onPress: () {
                                AlertActionSheet(context,
                                    alertConfig: AlertConfig(
                                        title: "Você tem certeza?",
                                        text: "Você está prestes a sair da sua conta, deseja realmente sair?",
                                        primaryButton: AlertButton(
                                          text: "Não",
                                        ),
                                        secondButton: AlertButton(
                                            text: "Sim",
                                            onPress: () => bloc.closeSession()
                                        )
                                    )
                                ).show();
                              }
                          )
                        ]
                    )
                  ],
                )
              ],
            );
          },
        ),
      ],
    );
  }

}

class UserMenuCard extends StatelessWidget {

  final Widget icon;
  final String text;
  final Function onPress;

  UserMenuCard({
    this.icon,
    this.text,
    this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        elevation: 2,
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: InkWell(
          onTap: onPress,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: icon,
                ),
                Text(text, style: TextStyles.body)
              ],
            ),
          ),
        )
      ),
    );
  }

}