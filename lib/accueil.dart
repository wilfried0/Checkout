import 'dart:collection';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:checkout/colors.dart';
import 'package:checkout/operator.dart';
import 'package:checkout/recu.dart';
import 'package:checkout/services.dart';
import 'package:checkout/validation.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {

  int indik = 0;
  List data, unfilterData;
  var _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _current, _current1, _current2, _url, url;
  var _ville=['ville non repertoriée'];
  var _quartier=['quartier non repertorié'];
  var _pharmacy=['aucune pharmacie'];
  var donnees, _data;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _url = "$baseUrl/merchants?category=PHARMACY";
    url = "$BaseUrl/merchants";
    this.getData(url);
  }

  Future<String> getData(String my_url) async {
    var _header = {
      "accept": "application/json",
      "content-type" : "application/json",
    };
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      var response = await http.get(Uri.encodeFull(my_url), headers: _header,);
      print('statuscode ${response.statusCode}');
      print('url $my_url');
      if (response.statusCode == 200) {
        if(my_url == "$_url"){
          setState(() {
            donnees = json.decode(utf8.decode(response.bodyBytes));
          });
          this.getVilles();
          print("liste: ${donnees.toString()}");
          this.ckAlert(context);
        }else{
          setState(() {
            _data = json.decode(utf8.decode(response.bodyBytes));
          });
          print("liste: ${_data.toString()}");
        }
      }else print(response.body);
    }else {
      ackAlert(context);
    }
    return "success";
  }


  searchData(str){
    var strExist = str.length>0?true:false;
    if(strExist){
      var filterData = [];
      for(var i=0; i<unfilterData.length; i++){
        String titre = unfilterData[i]['info']['titre'].toUpperCase();
        if(titre.contains(str.toUpperCase())){
          filterData.add(unfilterData[i]);
        }
      }
      setState(() {
        this.data = filterData;
      });
    }else{
      setState(() {
        this.data = this.unfilterData;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: (){
              setState(() {
                //Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Pays()));
              });
            },
            child: Icon(Icons.format_list_bulleted,size: 40,)),
        iconTheme: new IconThemeData(color: couleur_titre),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          decoration: BoxDecoration(
              color: couleur_champ,
              borderRadius: BorderRadius.circular(10)
          ),
          width: MediaQuery.of(context).size.width-40,
          height: hauteur_champ,
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Center(
              child: TextFormField(
                keyboardType: TextInputType.text,
                style: TextStyle(
                  fontSize: taille_libelle_etape,
                  color: couleur_libelle_champ,
                ),
                validator: (String value){
                  if(value.isEmpty){
                    return null;
                  }else{
                    return null;
                  }
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Recherher dans la Marketplace',
                  hintStyle: TextStyle(
                    fontSize: taille_libelle_etape-2,
                    color: couleur_libelle_champ,
                  ),
                  //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(//ici on return une column avec un text et une row
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: ListView(
            children: <Widget>[
              Text("Communication", style: TextStyle(
                  fontSize: taille_libelle_etape,
                  fontWeight: FontWeight.bold
              ),),
              Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        _stock("merchandId","5");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("m")));
                      },
                      child: Card(
                        elevation: 0.8,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            width: 90,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("images/mtn.png"),
                                )
                            ),
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        _stock("merchandId","9");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("ne")));
                      },
                      child: Card(
                        elevation: 0.8,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            width: 90,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("images/nextell.jpg"),
                                )
                            ),
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        _stock("merchandId","6");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("o")));
                      },
                      child: Card(
                        elevation: 0.8,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            width: 90,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("images/orange.jpg"),
                                )
                            ),
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        _stock("merchandId","7");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("y")));
                      },
                      child: Card(
                        elevation: 0.8,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            width: 90,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("images/yoomee.png"),
                                )
                            ),
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        _stock("merchandId","8");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("ca")));
                      },
                      child: Card(
                        elevation: 0.8,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            width: 90,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("images/camtel.jpg"),
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text("Energie & Eau", style: TextStyle(
                    fontSize: taille_libelle_etape,
                    fontWeight: FontWeight.bold
                ),),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: (){
                        _stock("merchandId","3");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("e")));
                      },
                      child: Card(
                        elevation: 0.8,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("images/eneo.jpg"),
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: (){
                        _stock("merchandId","4");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("w")));
                      },
                      child: Card(
                        elevation: 0.8,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("images/water.jpg"),
                                    fit: BoxFit.contain
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Card(
                  elevation: 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: CarouselSlider(
                      enlargeCenterPage: true,
                      autoPlay: true,
                      viewportFraction: 1.0,
                      autoPlayAnimationDuration: Duration(milliseconds: 1),
                      enableInfiniteScroll: true,
                      onPageChanged: (value){
                        setState(() {

                        });
                      },
                      height: 300.0,
                      items: [1,2,3].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return getMoyen2(i, context, indik);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text("Cable & TV", style: TextStyle(
                    fontSize: taille_libelle_etape,
                    fontWeight: FontWeight.bold
                ),),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: (){
                        _stock("merchandId","1");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("t")));
                      },
                      child: Card(
                        elevation: 0.8,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("images/tv.png"),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: (){
                        _stock("merchandId","2");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("c")));
                      },
                      child: Card(
                        elevation: 0.8,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("images/canal.png"),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text("Pharmacies", style: TextStyle(
                    fontSize: taille_libelle_etape,
                    fontWeight: FontWeight.bold
                ),),
              ),
              GestureDetector(
                onTap: (){
                  this.getData(_url);
                },
                child: Card(
                  elevation: 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/pharmacie.png"),
                          )
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )


        /*ListView(
          children: <Widget>[
            Text("Communication", style: TextStyle(
                fontSize: taille_libelle_etape,
                fontWeight: FontWeight.bold
            ),),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      _stock("merchandId","5");
                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("m")));
                    },
                    child: Card(
                      elevation: 0.8,
                     child: Padding(
                       padding: EdgeInsets.all(10),
                       child: Container(
                         height: 50,
                         decoration: BoxDecoration(
                             image: DecorationImage(
                                 image: AssetImage("images/mtn.png"),
                             )
                         ),
                       ),
                     ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      _stock("merchandId","6");
                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("o")));
                    },
                    child: Card(
                      elevation: 0.8,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/orange.jpg"),
                                  fit: BoxFit.contain
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      _stock("merchandId","7");
                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("y")));
                    },
                    child: Card(
                      elevation: 0.8,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/yoomee.png"),
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),

            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Energie & Eau", style: TextStyle(
                  fontSize: taille_libelle_etape,
                  fontWeight: FontWeight.bold
              ),),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      _stock("merchandId","3");
                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("e")));
                    },
                    child: Card(
                      elevation: 0.8,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/eneo.jpg"),
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      _stock("merchandId","4");
                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("w")));
                    },
                    child: Card(
                      elevation: 0.8,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/water.jpg"),
                                  fit: BoxFit.contain
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Card(
                elevation: 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: CarouselSlider(
                    enlargeCenterPage: true,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    autoPlayAnimationDuration: Duration(milliseconds: 1),
                    enableInfiniteScroll: true,
                    onPageChanged: (value){
                      setState(() {

                      });
                    },
                    height: 300.0,
                    items: [1,2,3].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return getMoyen2(i, context, indik);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Cable & TV", style: TextStyle(
                  fontSize: taille_libelle_etape,
                  fontWeight: FontWeight.bold
              ),),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      _stock("merchandId","1");
                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("t")));
                    },
                    child: Card(
                      elevation: 0.8,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/tv.png"),
                                fit: BoxFit.cover
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      _stock("merchandId","2");
                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("c")));
                    },
                    child: Card(
                      elevation: 0.8,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/canal.png"),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Pharmacies", style: TextStyle(
                  fontSize: taille_libelle_etape,
                  fontWeight: FontWeight.bold
              ),),
            ),
            GestureDetector(
              onTap: (){
                this.checkConnection();
              },
              child: Card(
                elevation: 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/pharmacie.png"),
                        )
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),*/
      ),
      bottomNavigationBar:BottomNavigationBar(
        elevation: 0.8,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            title: Text('Mes Reçus'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in),
            title: Text('Validation'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: orange_F,
        unselectedItemColor: orange_F,
        onTap: _onItemTapped,
      ),
    );
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _selectedIndex==1?Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Validation())):Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Recu()));
  }

  Future<void> ckAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SingleChildScrollView(
            child: MyDialogContent(ville: _ville, quartier: _quartier, pharmacy: _pharmacy, donnees: donnees,scaffoldKey: _scaffoldKey,),
          ),
        );
      },
    );
  }

  getVilles(){
    if(donnees==null){

    }else{
      _ville = [];
      for(int i=0;i<donnees.length;i++){
        _ville.add(donnees[i]['address']);
      }
    }
    return LinkedHashSet<String>.from(_ville).toList();
  }
}

void _stock(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
  print('saved $value');
}


// ignore: must_be_immutable
class MyDialogContent extends StatefulWidget {
  MyDialogContent({
    Key key, this.ville, this.quartier, this.pharmacy, this.donnees,this.scaffoldKey,
  }): super(key: key);
  final List<String> ville, quartier, pharmacy;
  var donnees;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  _MyDialogContentState createState() => new _MyDialogContentState();
}

class _MyDialogContentState extends State<MyDialogContent> {
  var _formKey = GlobalKey<FormState>();
  String _current=null, _current1=null, _current2=null, _url;
  int _id;
  //var _ville=ville;
  //var _quartier=['quartier non repertorié'];
  //var _pharmacy=['aucune pharmacie'];


  @override
  void initState(){
    super.initState();
    print(widget.donnees);
    print(widget.ville);
    print(widget.quartier);
    print("Mes pharmacies");
    print(widget.pharmacy);
  }

  getQuartiers(String ville){
    widget.quartier.clear();
    for(int i=0;i<widget.donnees.length;i++){
      if(widget.donnees[i]['address'] == "$ville")
        widget.quartier.add(widget.donnees[i]['neighborhood']);
      else ;
    }
    return LinkedHashSet<String>.from(widget.quartier).toList();
  }

  getPharmacies(String ville, String quartier){
    widget.pharmacy.clear();
    for(int i=0;i<widget.donnees.length;i++){
      if(widget.donnees[i]['address'] == "$ville" && widget.donnees[i]['neighborhood'] == "$quartier")
        widget.pharmacy.add(widget.donnees[i]['name']);
      else ;
    }
    return LinkedHashSet<String>.from(widget.pharmacy).toList();
  }

  int getId(String ville, String quartier, String pharmacy){
    for(int i=0;i<widget.donnees.length;i++){
      if(widget.donnees[i]['address'] == "$ville" && widget.donnees[i]['neighborhood']=="$quartier" && widget.donnees[i]['name']=="$pharmacy") {
        _id = widget.donnees[i]['id'];
        break;
      }else ;
    }
    return _id;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Choisissez une pharmacie!', style: TextStyle(
              color: Colors.green,
              fontSize: taille_champ+3
          ),textAlign: TextAlign.center,),
          Container(
            color: Colors.green,
            height: 2,
            width: MediaQuery.of(context).size.width,
          ),
        ],
      ),
      content: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    color: Colors.transparent,
                    border: Border.all(
                        color: couleur_bordure,
                        width: bordure
                    ),
                  ),
                  height: hauteur_champ,
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: new Icon(Icons.arrow_drop_down_circle,
                            color: Colors.green,),
                        ),
                        isDense: true,
                        elevation: 1,
                        isExpanded: true,
                        onChanged: (String selected){
                          setState(() {
                            _current = selected;
                            _current1 = null;
                            _current2 = null;
                            this.getQuartiers(selected);
                          });
                        },
                        value: null,
                        hint: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text( _current==null?"Ville":_current,
                            style: TextStyle(
                              color: couleur_libelle_champ,
                              fontSize:taille_libelle_champ,
                            ),),
                        ),
                        items: widget.ville.map((String name){
                          return DropdownMenuItem<String>(
                            value: name,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(name,
                                style: TextStyle(
                                    color: couleur_fond_bouton,
                                    fontSize:taille_libelle_champ,
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                          );
                        }).toList(),
                      )
                  ),
                ),

                Container(
                  decoration: new BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                        color: couleur_bordure,
                        width: bordure
                    ),
                  ),
                  height: hauteur_champ,
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: new Icon(Icons.arrow_drop_down_circle,
                            color: Colors.green,),
                        ),
                        isDense: true,
                        elevation: 1,
                        isExpanded: true,
                        onChanged: (String selected){
                          setState(() {
                            _current1 = selected;
                            _current2 = null;
                            this.getPharmacies(_current,_current1);
                          });
                        },
                        value: null,
                        hint: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(_current1==null?"Quartier":_current1 ,
                            style: TextStyle(
                              color: couleur_libelle_champ,
                              fontSize:taille_libelle_champ,
                            ),),
                        ),
                        items: widget.quartier.map((String name){
                          return DropdownMenuItem<String>(
                            value: name,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(name,
                                style: TextStyle(
                                    color: couleur_fond_bouton,
                                    fontSize:taille_libelle_champ,
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                          );
                        }).toList(),
                      )
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                    color: Colors.transparent,
                    border: Border.all(
                        color: couleur_bordure,
                        width: bordure
                    ),
                  ),
                  height: hauteur_champ,
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: new Icon(Icons.arrow_drop_down_circle,
                            color: Colors.green,),
                        ),
                        isDense: true,
                        elevation: 1,
                        isExpanded: true,
                        onChanged: (String selected){
                          setState(() {
                            _current2 = selected;
                          });
                        },
                        value: null,
                        hint: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(_current2==null? "Votre pharmacie":_current2,
                            style: TextStyle(
                              color: couleur_libelle_champ,
                              fontSize:taille_libelle_champ,
                            ),),
                        ),
                        items: widget.pharmacy.map((String name){
                          return DropdownMenuItem<String>(
                            value: name,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(name,
                                style: TextStyle(
                                    color: couleur_fond_bouton,
                                    fontSize:taille_libelle_champ,
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                          );
                        }).toList(),
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: new Container(
                              height: hauteur_champ,
                              width: MediaQuery.of(context).size.width - 80,
                              decoration: new BoxDecoration(
                                color: couleur_libelle_champ,
                                border: new Border.all(
                                  color: Colors.transparent,
                                  width: 0.0,
                                ),
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              child: new Center(child:Text('Annuler', style: new TextStyle(fontSize: taille_text_bouton, color: couleur_text_bouton),)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                stopSnackBar();
                                if(_current==null && _current1==null && _current2==null){
                                  showInSnackBar("Veuillez sélectionner une ville, un quartier ainsi qu'une pharmacie");
                                  stopSnackBar();
                                }else if(_current!=null && _current1==null && _current2==null){
                                  this.showInSnackBar("Veuillez sélectionner un quartier ainsi qu'une pharmacie");
                                  stopSnackBar();
                                }else if(_current!=null && _current1!=null && _current2==null){
                                  this.showInSnackBar("Veuillez sélectionner une pharmacie");
                                  stopSnackBar();
                                }else if(_current==null || _current1==null || _current2==null){
                                  this.showInSnackBar("Veuillez renseigner tous les champs");
                                  stopSnackBar();
                                }else{
                                  getId(_current, _current1, _current2);
                                  _stock("merchandId","$_id");
                                  _stock("ville","$_current");
                                  _stock("quartier","$_current1");
                                  _stock("pharmacie","$_current2");
                                  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("p")));
                                }
                              });
                            },
                            child: new Container(
                              height: hauteur_champ,
                              width: MediaQuery.of(context).size.width - 80,
                              decoration: new BoxDecoration(
                                color: Colors.green,
                                border: new Border.all(
                                  color: Colors.transparent,
                                  width: 0.0,
                                ),
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              child: new Center(child:Text('Valider', style: new TextStyle(fontSize: taille_text_bouton, color: couleur_text_bouton),)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showInSnackBar(String value) {
    widget.scaffoldKey.currentState.showSnackBar(
        new SnackBar(content: new Text(value,style:
        TextStyle(
            color: Colors.white,
            fontSize: taille_champ
        ),
          textAlign: TextAlign.center,),
          backgroundColor: couleur_fond_bouton,
          duration: Duration(seconds: 5),));
  }

  void stopSnackBar(){
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        widget.scaffoldKey.currentState.hideCurrentSnackBar();
      });
    });
  }
}
