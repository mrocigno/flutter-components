import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/containers/BackgroundContainer.dart';
import 'package:infrastructure/flutter/components/image/UserIcon.dart';
import 'package:infrastructure/flutter/components/textviews/Hyperlink.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:mopei_app/src/ui/login/LoginModal.dart';
import 'package:mopei_app/src/ui/main/user/UserScreenBloc.dart';

class UserScreen extends StatelessWidget {

  final UserScreenBloc bloc = inject();

  void onSuccessLogin() {
    bloc.setSigned();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<bool>(
      stream: bloc.isSigned,
      builder: (context, snapshot) {
        if(!snapshot.hasData || !snapshot.data) return Center(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.vertical,
            children: <Widget>[
              Icon(Icons.account_circle, color: Colors.white, size: 150),
              Text("Você não está logado", style: TextStyles.title2White),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Hyperlink("Clique aqui para logar",
                  style: TextStyles.subtitleWhite,
                  onPress: () {
                    LoginModal(context, onSuccess: onSuccessLogin).show();
                  },
                ),
              )
            ],
          ),
        );

        return Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  UserIcon(
                    userName: "Matheus Rocigno",
                    imagePath: "",
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
                          Text("Matheus rocigno", style: TextStyles.subtitleWhiteBold,),
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
            )
          ],
        );
      },
    );
  }
}

class UserMenuCard extends StatelessWidget {

  final Widget icon;
  final String text;

  UserMenuCard({
    this.icon,
    this.text
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        elevation: 2,
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.all(Radius.circular(10)),
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
        )
      ),
    );
  }

}