import 'package:another_flushbar/flushbar.dart';
import 'package:first_app/Screens/HomePage/home.dart';
import 'package:first_app/Widget/buttomAppBar.dart';
import 'package:first_app/Widget/customRaisedButton.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:flutter/material.dart';

class NewArticlePage extends StatefulWidget {
  const NewArticlePage({super.key});

  @override
  State<NewArticlePage> createState() => _NewArticlePageState();
}

class _NewArticlePageState extends State<NewArticlePage> {
  ConstantColors constantColors = ConstantColors();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String? CustomeValidaor(String? value) {
    String? _msg;

    if (value!.isEmpty) {
      _msg = "Required";
    }
    return _msg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: constantColors.whiteColor),
        backgroundColor: constantColors.greenColor,
        title: SizedBox(
          child: Text(
            'New Article',
            overflow: TextOverflow.visible,
            style: TextStyle(
                color: constantColors.whiteColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(30, 50, 30, 0),
                  child: TextFormField(
                    // onTap: FocusScope.of(context).unfocus,
                    autofocus: false,
                    controller: titleController,
                    validator: CustomeValidaor,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Article Title'),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    // onTap: FocusScope.of(context).unfocus,
                    autofocus: false,
                    // controller: _controller,
                    controller: aboutController,

                    validator: CustomeValidaor,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "What's this article about?"),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    // onTap: FocusScope.of(context).unfocus,
                    keyboardType: TextInputType.multiline,
                    // controller: _controller,
                    controller: descController,

                    maxLines: null,
                    minLines: 5,
                    validator: CustomeValidaor,

                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Write your article '),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                // child: Tags(
                //   key: globalKey,
                //   itemCount: tags.length,
                //   columns: 6,
                //   textField: TagsTextField(
                //       width: 400,
                //       textStyle: TextStyle(fontSize: 16),
                //       onSubmitted: (string) {
                //         setState(() {
                //           tags.add(Item(title: string));
                //         });
                //       }),
                //   itemBuilder: (index) {
                //     return ItemTags(
                //       color: constantColors.greenColor,
                //       index: index,
                //       title: tags[index].title,
                //       customData: tags[index].customData,
                //       textStyle: TextStyle(fontSize: 14),
                //       onPressed: (i) => print(i),
                //       onLongPressed: (i) => print(i),
                //       removeButton: ItemTagsRemoveButton(onRemoved: () {
                //         setState(() {
                //           tags.removeAt(index);
                //         });
                //         return true;
                //       }),
                //     );
                //   },
                // ),
                child: TextFormField(
                  // onTap: FocusScope.of(context).unfocus,
                  validator: CustomeValidaor,
                  // controller: _controller,
                  controller: tagController,

                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Enter tags'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                        print('Entered');
                        Flushbar(
                          title: 'Article published',
                          message: ' ',
                          duration: Duration(seconds: 2),
                        ).show(context);
                      } else {
                        Flushbar(
                          title: 'Invalid form',
                          message: 'Please complete the form properly',
                          duration: Duration(seconds: 2),
                        ).show(context);
                      }
                    },
                    child: CustomRaisedButton(
                      buttonText: 'Publish Article',
                    )),
              ),
            ],
          )),
        ),
      ),
      bottomNavigationBar: BottomAppBarPage(),
    );
  }
}
