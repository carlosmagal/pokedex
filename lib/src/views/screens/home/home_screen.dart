import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:pokedex_app/src/core/utils/shared/colors_util.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.background,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: TextPlus(
        'Pokédex',
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: ColorsUtil.cinzaEscuro,
      ),
      centerTitle: false,
    );
  }

  _buildBody() {
    return Container();
  }
}
