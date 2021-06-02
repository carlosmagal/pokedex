import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:pokedex_app/src/core/utils/shared/colors_util.dart';
import 'package:pokedex_app/src/views/screens/home/components/typeCard.dart';

class DetalheScreen extends StatelessWidget {

  DetalheScreen(this.background, this.imageUrl);
  final Color background;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this._buildAppBar(),
      body: this._buildBody(context),
    );
  }

  _buildAppBar(){
    return AppBar(
      backgroundColor: this.background,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.favorite),
          onPressed: (){},
        )
      ],
    );
  }

  _buildBody(BuildContext context){
    return ContainerPlus(
      color: this.background,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ContainerPlus(
              isCenter: true,
              margin: EdgeInsets.symmetric(horizontal:48),
              child: Hero(
                tag:this.imageUrl,
                child: Image.network(
                  this.imageUrl,
                ),
              ),
            ),
            TextPlus(
              'Bulbaaa',
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: ColorsUtil.white,
              margin: const EdgeInsets.symmetric(vertical:12),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                TypeCard('Poison', cardFont: 16, cardMargin: 8),
                TypeCard('Grass', cardFont: 16),
              ]
            ),

            this._statusBarContainer(MediaQuery.of(context).size.width),
          ],
        ),
        
      ),
    );
  }

  _statusBarContainer(double size){

    return ContainerPlus(
      radius: RadiusPlus.top(20),
      color: ColorsUtil.white,
      width: size,
      height: 300,
      margin: EdgeInsets.only(top: 24),
      padding: EdgeInsets.fromLTRB(24, 0, 24, 16),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics() ,
        child: Column(
          children: [
            TextPlus(
              'Status',
              color: ColorsUtil.status,
              fontWeight: FontWeight.w500,
              fontSize: 24,
              margin: EdgeInsets.only(top:16),
              textDecorationPlus: TextDecorationPlus(
                // decorationThickness: 2,
                textDecoration: TextDecoration.underline,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 24),
              child: Column(
                children: [
                  this._statusData('HP', 80),
                  this._statusData('Attack', 10),
                  this._statusData('Defense', 50),
                  this._statusData('Special-Attack', 20),
                  this._statusData('Special-Defense', 80),
                  this._statusData('Speed', 45),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _statusData(String statusLabel, double endValue){

    return ContainerPlus(
      margin: EdgeInsets.only(bottom:8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextPlus(
            statusLabel,
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: ColorsUtil.status,
          ),
          Spacer(),
          TextPlus(
            endValue.toStringAsFixed(0),
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: ColorsUtil.status,
            margin: EdgeInsets.only(right: 16),
          ),
          ContainerPlus(
            width: 130,
            height: 10,
            radius: RadiusPlus.all(10),
            child: TweenAnimationBuilder(onEnd: (){},
              tween: Tween<double>(begin: 0.0, end: endValue/100,), 
              duration: Duration(milliseconds: 1800), 
              builder: (context, double value, _){ 
                return LinearProgressIndicator(
                  value: value,
                  valueColor: AlwaysStoppedAnimation<Color>(ColorsUtil.statusLinearProgress),
                  backgroundColor: Color(0xffFB6C6C).withOpacity(0.2),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
