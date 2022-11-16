

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/': (BuildContext context)  => MyHomePage(title: 'РЕГИСТРАТУРА'),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        useMaterial3: true
      ),
      
    );
  }
}

//Состояние для основного экрана
class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();


}

class AnimatedDefaultTextStyleWidget extends StatefulWidget {
  @override
  _AnimatedDefaultTextStyleWidgetState createState() =>
      _AnimatedDefaultTextStyleWidgetState();
}

enum Gender {Man, Woman}

//класс формы
class RegistrationForm{
  String fio = '';
  bool protect = false;
  int catCount = 1;
  Gender? gender = Gender.Man;
  List<String> cats = <String>['Дебильность', 'Слабоумие', 'Кашель', 'Старость'];
  String? favoriteCat = '';

  RegistrationForm(){
    favoriteCat = cats.first;
  }

}

// body: Center(
// child:
// SlideTransition(
// position: _myAnimation,
// child: const Padding(
// padding: EdgeInsets.all(8.0),
// child: FlutterLogo(size: 150.0),
// ),
// ),
// ),
//
// AnimationController _controller;
// Animation<Offset> _myAnimation;
//
// @override
// void initState() {
//   // TODO: implement initState
//   super.initState();
//   _controller = AnimationController(
//     duration: const Duration(seconds: 2),
//     vsync: this,
//   );
//
//   _myAnimation = Tween<Offset>(
//     begin: Offset.zero,
//     end: const Offset(1.5, 0.0),
//
//   ).animate(CurvedAnimation(
//     parent: _controller,
//     curve: Curves.elasticIn,
//   ));
// }








//Второй экран
class SecondScreen extends StatelessWidget{
  const SecondScreen({super.key, required this.form});

  final RegistrationForm form;



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Подведем итоги'),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),


        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TODO: Доделать отображение данных с формы
            Text('Ваше имя ${form.fio.toString()}'),
              if (form.gender == Gender.Woman)
                const Text('Вы указали что вы женщина')
              else
                const Text('Вы указали что вы мужщина'),
              if (form.protect) ... [
                const Text('Вы подтвердили что вы больны'),
                Text('Вы хотите заплатить ${form.catCount.toString()} денег'),
                Text('Вы указали что у вас  ${form.favoriteCat.toString()}'),
                const Text('Но на самом деле у вас все вот это:'),
                ListView.builder(
                    padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: form.cats.length,
                    itemBuilder: (BuildContext context, int index){
                      return Text(form.cats[index]);
                    }
                ),
              ]
              else
                const Text('Вы сказали что не больны :(, а значит мы не получим денег'),
        ]),)
    );
  }
}




class _AnimatedDefaultTextStyleWidgetState
    extends State<AnimatedDefaultTextStyleWidget> {
  bool _first = true;

  double _fontSize = 60;
  Color _color = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 120,
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: _fontSize,
                color: _color,
                fontWeight: FontWeight.bold,
              ),
              child: Text('Flutter'),
            ),
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                _fontSize = _first ? 90 : 60;
                _color = _first ? Colors.blue : Colors.red;
                _first = !_first;
              });
            },
            child: Text(
              "CLICK ME!",
            ),
          )
        ],
      ),
    );
  }

  FlatButton({required Null Function() onPressed, required Text child}) {}
}





//Основной экран
class _MyHomePageState extends State<MyHomePage> {

  final _formKey = GlobalKey<FormState>();
  RegistrationForm formData = RegistrationForm();
  bool accessData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.bottomCenter,
            child: Text(widget.title)
        ) ,
      ),
      body: Container(
        alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        width: 500,
        child: Form(
          key: _formKey,
          onChanged: () {Form.of(primaryFocus!.context!)!.save();},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text('Ваше ФИО:', style: TextStyle(fontSize: 20.0),),
              new TextFormField(validator: (value){
                formData.fio = value!;
                if (value == "") return 'Пожалуйста введите свое ФИО';
              }),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child:Align(
                  alignment: Alignment.topLeft,
                  child: Text('Вы кто по жизни?', style: TextStyle(fontSize: 20.0),)
                )),
              RadioListTile(
                  title: const Text('Мужчина', style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xffb80de7),
                    decorationStyle: TextDecorationStyle.wavy,
                  ),),
                  value: Gender.Man,
                  groupValue: formData.gender,
                  onChanged: (Gender? value) {setState(() {formData.gender = value;});}
              ),
              RadioListTile(
                  title: const Text('Женщина', style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xffb80de7),
                    decorationStyle: TextDecorationStyle.wavy,
                  ),),
                  value: Gender.Woman,
                  groupValue: formData.gender,
                  onChanged: (Gender? value) {setState(() {formData.gender = value;});}
              ),
              Row(children: [
                const Text('Вы больны ?', style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xffb80de7),
                  decorationStyle: TextDecorationStyle.wavy,
                ),),
                Checkbox(
                    value: formData.protect,
                    onChanged: (bool? value) {setState(() {
                      if (value != null) {
                        formData.protect = value;
                      }
                    });}),
              ]),
              Row(
                children: [
                  const Text('Согласие: на обработку пдн ', style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xffb80de7),
                    decorationStyle: TextDecorationStyle.wavy,
                  ),),
                  Switch(
                      value: accessData,
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null)
                            accessData = value;
                        });
                      }
                  )
                ],
              ),
              if (true
              ) ... [
                const Text('Выберите болезнь'),
                Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: DropdownButton(
                        items: formData.cats.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: formData.favoriteCat,
                        onChanged: (String? value) {setState(() {
                          formData.favoriteCat = value;
                        });}
                    )
                ),
                const Text('Сколько денег вы нам отдадите?'),
                //  Slider(
                //   value: formData.catCount,
                //   onChanged: (double? value) {setState(() {
                //     if (value != null) {
                //       formData.catCount = value;
                //     }
                //   });},
                //   min: 1,
                //   max: 10,
                //   divisions: 5,
                //   label: formData.catCount.toInt().toString(),
                // ),
                NumberPicker(minValue: 1, maxValue: 10, value: formData.catCount, axis: Axis.horizontal, onChanged: (value) {
                  setState(() => formData.catCount = value);
                },)


              ],



              Padding(
                  padding: const EdgeInsets.fromLTRB(100, 100, 0, 0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                          BorderSide.lerp(
                              const BorderSide(
                                style: BorderStyle.solid,
                                color: Color(0xffb80de7),
                                width: 10.0,
                              ),
                              const BorderSide(
                                style: BorderStyle.solid,
                                color: Color(0xffb80de7),
                                width: 10.0,
                              ),
                              10.0),
                        )
                      ),
                      onPressed: () {
                        if (accessData){
                          if(_formKey.currentState!.validate()){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Проверка пройденна'), backgroundColor: Colors.green,));
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => SecondScreen(form: formData)));
                          }
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Вы не солгасились с соглашением'), backgroundColor: Colors.red,));
                        }
                        },
                      child: const Text('Проверить форму')
                  )
              )
            ]
          ),
        )
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('AnimatedDefaultTextStyle', AnimatedDefaultTextStyle));
  }
}



class _IntegerExample extends StatefulWidget {
  @override
  __IntegerExampleState createState() => __IntegerExampleState();
}

class __IntegerExampleState extends State<_IntegerExample> {
  int _currentIntValue = 10;
  int _currentHorizontalIntValue = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 32),
        Text('Horizontal', style: Theme.of(context).textTheme.headline6),
        NumberPicker(
          value: _currentHorizontalIntValue,
          minValue: 0,
          maxValue: 100,
          step: 10,
          itemHeight: 100,
          axis: Axis.horizontal,
          onChanged: (value) =>
              setState(() => _currentHorizontalIntValue = value),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black26),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => setState(() {
                final newValue = _currentHorizontalIntValue - 10;
                _currentHorizontalIntValue = newValue.clamp(0, 100);
              }),
            ),
            Text('Current horizontal int value: $_currentHorizontalIntValue'),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => setState(() {
                final newValue = _currentHorizontalIntValue + 20;
                _currentHorizontalIntValue = newValue.clamp(0, 100);
              }),
            ),
          ],
        ),
      ],
    );
  }
}