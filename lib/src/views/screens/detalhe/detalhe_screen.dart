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
                TypeCard(cardFont: 16, cardMargin: 8,),
                TypeCard(cardFont: 16),
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
      padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  this._statusData(.8),
                  this._statusData(.1),
                  this._statusData(.5),
                  this._statusData(.2),
                  this._statusData(.8),
                  this._statusData(.8),
                  this._statusData(1),
                  this._statusData(.2),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  _statusData(double endValue){

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextPlus(
          'HP',
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: ColorsUtil.status,
          margin: EdgeInsets.only(top:20),
        ),
        Spacer(),
        TextPlus(
          '45',
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
            tween: Tween<double>(begin: 0.0, end: endValue,), 
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
    );
  }
}
