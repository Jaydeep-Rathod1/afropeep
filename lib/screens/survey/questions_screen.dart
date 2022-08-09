
import 'package:afropeep/models/user_models/questions_model.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:afropeep/screens/survey/congratulation_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:afropeep/widgets/custom_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

// String questionTen ;
class QuestionsScreen extends StatefulWidget {
  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}
String questionOneValue ;
String questionTwoValue ;
String questionThreeValue ;
String questionFourValue ;
String questionFiveValue ;
String questionSixValue ;
String questionSevenValue ;
String questionEightValue ;
String questionNineValue ;
String questionTenValue ;
String questioneElevanValue ;
String questionTwaleValue ;
String questionThreeteenValue ;
TextEditingController _questionOneAnswer = TextEditingController() ;
TextEditingController _questionTwoAnswer = TextEditingController() ;
TextEditingController _questionThreeAnswer = TextEditingController() ;
TextEditingController _questionFourAnswer = TextEditingController() ;
TextEditingController _questionFiveAnswer = TextEditingController() ;
TextEditingController _questionSixAnswer = TextEditingController() ;
TextEditingController _questionSevenAnswer = TextEditingController() ;
TextEditingController _questionEightAnswer = TextEditingController() ;
TextEditingController _questionNineAnswer = TextEditingController() ;
TextEditingController _questionTenAnswer = TextEditingController() ;
TextEditingController _questionElevanAnswer = TextEditingController() ;
TextEditingController _questionTwaleAnswer = TextEditingController() ;
TextEditingController _questionThrteenAnswer = TextEditingController() ;
List<QuestionsModel> arrAllQuestionsList = [];
var index = 1;
PageController _pageController = PageController();
Dio _dio = Dio();
class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuestionsList();
  }
  getQuestionsList()async {
    await _dio.get(GET_QUESTIONS).then((value) {

      var varJson = value.data as List;
      print(varJson);
      if(value.statusCode == 200)
      {
        setState(() {
          arrAllQuestionsList =varJson.map((e) =>QuestionsModel.fromJson(e)).toList();
        });
        print(arrAllQuestionsList);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 47.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                    onTap: (){
                      if(index != 1)
                      {
                        print(_pageController.page.toInt() -1);
                        setState(() {
                          index--;
                        });
                        _pageController.animateToPage(_pageController.page.toInt() -1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn
                        );
                      }


                    },
                    child: Icon(Icons.arrow_back,color: ColorResources.whiteColor,)
                ),
                Expanded(child: Align(
                  alignment: Alignment.center,
                  child: CustomText(text:'${index<10 ? '${0}${index}':index}/13',fontSize: 14,color: ColorResources.whiteColor,),
                ))
              ],
            )
          ),
          const SizedBox(
            height: 32.0,
          ),
          Flexible(
            child:  Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Prevent the user from swiping
                scrollDirection: Axis.horizontal,
                children: [
                  QuestionOne(),
                  QuestionTwo(),
                  QuestionThree(),
                  QuestionFour(),
                  QuestionFive(),
                  QuestionSix(),
                  QuestionSeven(),
                  QuestionEight(),
                  QuestionNine(),
                  QuestionTen(),
                  QuestionElevan(),
                  QuestionTwale(),
                  QuestionThreteen()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class QuestionOne extends StatefulWidget {
  @override
  State<QuestionOne> createState() => _QuestionOneState();
}

class _QuestionOneState extends State<QuestionOne> {
  @override
  Widget build(BuildContext context) {
    return arrAllQuestionsList!= null && arrAllQuestionsList.length != 0? Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: arrAllQuestionsList[0].qName!= null ? arrAllQuestionsList[0].qName:'',fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        Container(
          width: MediaQuery.of(context).size.width,
          child: CustomTextField(
              controller: _questionOneAnswer,
              hintText: 'Enter Bio',
              maxLines: 5,
              fontSize: 14.0,
              textInputType: TextInputType.multiline,
              borderRadius: 29
          ),
        ),
        Expanded(child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child:  Align(
              alignment: FractionalOffset.bottomRight,
              child: CustomButton(
                height: 45,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){
                  // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChooseGenderScreen()));
                  setState(() {
                    questionOneValue = _questionOneAnswer.text.toString();
                  });
                  if(index < 13)
                  {
                    setState(() {
                      index++;
                    });
                    _pageController.animateToPage(_pageController.page.toInt() + 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn
                    );

                  }
                  else{
                    print("called");
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CongratulationScreen()));
                  }
                },
                buttonText: index ==13 ? "Finish":'Next',
                fontSize: 16.0,
                textColor: ColorResources.whiteColor,
                width:MediaQuery.of(context).size.width/3.8,
              )
          ),
        ),),
        const SizedBox(
          height: 34,
        )
      ],
    ):Container();
  }
}
class QuestionTwo extends StatefulWidget {
  @override
  State<QuestionTwo> createState() => _QuestionTwoState();
}

class _QuestionTwoState extends State<QuestionTwo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: arrAllQuestionsList[1].qName,fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        Container(
          width: MediaQuery.of(context).size.width,
          child: CustomTextField(
              controller: _questionTwoAnswer,
              hintText: 'Enter Nationality',
              fontSize: 14.0,
              textInputType: TextInputType.multiline,
              borderRadius: 29
          ),
        ),
        Expanded(child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child:  Align(
              alignment: FractionalOffset.bottomRight,
              child: CustomButton(
                height: 45,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){
                  // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChooseGenderScreen()));
                  setState(() {
                    questionTwoValue = _questionTwoAnswer.text.toString();
                  });
                  if(index < 13)
                  {
                    setState(() {
                      index++;
                    });
                    _pageController.animateToPage(_pageController.page.toInt() + 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn
                    );

                  }
                  else{
                    print("called");
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CongratulationScreen()));
                  }
                },
                buttonText: index ==13 ? "Finish":'Next',
                fontSize: 16.0,
                textColor: ColorResources.whiteColor,
                width:MediaQuery.of(context).size.width/3.8,
              )
          ),
        ),),
        const SizedBox(
          height: 34,
        )
      ],
    );
  }
}


class QuestionThree extends StatefulWidget {
  @override
  State<QuestionThree> createState() => _QuestionThreeState();
}

class _QuestionThreeState extends State<QuestionThree> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: arrAllQuestionsList[2].qName,fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        Container(
          width: MediaQuery.of(context).size.width,
          child: CustomTextField(
              controller: _questionThreeAnswer,
              hintText: 'Enter Religion',
              fontSize: 14.0,
              textInputType: TextInputType.multiline,
              borderRadius: 29
          ),
        ),
        Expanded(child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child:  Align(
              alignment: FractionalOffset.bottomRight,
              child: CustomButton(
                height: 45,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){
                  // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChooseGenderScreen()));
                  setState(() {
                    questionThreeValue = _questionThreeAnswer.text.toString();
                  });
                  if(index < 13)
                  {
                    setState(() {
                      index++;
                    });
                    _pageController.animateToPage(_pageController.page.toInt() + 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn
                    );
                  }
                  else{
                    print("called");
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CongratulationScreen()));
                  }
                },
                buttonText: index ==13 ? "Finish":'Next',
                fontSize: 16.0,
                textColor: ColorResources.whiteColor,
                width:MediaQuery.of(context).size.width/3.8,
              )
          ),
        ),),
        const SizedBox(
          height: 34,
        )
      ],
    );
  }
}

class QuestionFour extends StatefulWidget {

  @override
  State<QuestionFour> createState() => _QuestionFourState();
}

class _QuestionFourState extends State<QuestionFour> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: arrAllQuestionsList[3].qName,fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        Container(
          width: MediaQuery.of(context).size.width,
          child: CustomTextField(
              controller: _questionFourAnswer,
              hintText: 'Enter Occupation Name',
              fontSize: 14.0,
              textInputType: TextInputType.multiline,
              borderRadius: 29
          ),
        ),
        Expanded(child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child:  Align(
              alignment: FractionalOffset.bottomRight,
              child: CustomButton(
                height: 45,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){
                  // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChooseGenderScreen()));
                  setState(() {
                    questionFourValue = _questionFourAnswer.text.toString();
                  });
                  if(index < 13)
                  {
                    setState(() {
                      index++;
                    });
                    _pageController.animateToPage(_pageController.page.toInt() + 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn
                    );

                  }
                  else{
                    print("called");
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CongratulationScreen()));
                  }
                },
                buttonText: index ==13 ? "Finish":'Next',
                fontSize: 16.0,
                textColor: ColorResources.whiteColor,
                width:MediaQuery.of(context).size.width/3.8,
              )
          ),
        ),),
        const SizedBox(
          height: 34,
        )
      ],
    );
  }
}

class QuestionFive extends StatefulWidget {
  @override
  State<QuestionFive> createState() => _QuestionFiveState();
}

class _QuestionFiveState extends State<QuestionFive> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: arrAllQuestionsList[4].qName,fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        Container(
          width: MediaQuery.of(context).size.width,
          child: CustomTextField(
              controller: _questionFiveAnswer,
              hintText: 'Enter Sign',
              fontSize: 14.0,
              textInputType: TextInputType.multiline,
              borderRadius: 29
          ),
        ),
        Expanded(child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child:  Align(
              alignment: FractionalOffset.bottomRight,
              child: CustomButton(
                height: 45,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){
                  // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChooseGenderScreen()));
                  setState(() {
                    questionFiveValue = _questionFiveAnswer.text.toString();
                  });
                  if(index < 13)
                  {
                    setState(() {
                      index++;
                    });
                    _pageController.animateToPage(_pageController.page.toInt() + 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn
                    );

                  }
                  else{
                    print("called");
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CongratulationScreen()));
                  }
                },
                buttonText: index ==13 ? "Finish":'Next',
                fontSize: 16.0,
                textColor: ColorResources.whiteColor,
                width:MediaQuery.of(context).size.width/3.8,
              )
          ),
        ),),
        const SizedBox(
          height: 34,
        )
      ],
    );
  }
}


class QuestionSix extends StatefulWidget {
  @override
  State<QuestionSix> createState() => _QuestionSixState();
}

class _QuestionSixState extends State<QuestionSix> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: arrAllQuestionsList[5].qName,fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        Container(
          width: MediaQuery.of(context).size.width,
          child: CustomTextField(
              controller: _questionSixAnswer,
              hintText: 'Enter Tribe',
              fontSize: 14.0,
              textInputType: TextInputType.multiline,
              borderRadius: 29
          ),
        ),
        Expanded(child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child:  Align(
              alignment: FractionalOffset.bottomRight,
              child: CustomButton(
                height: 45,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){
                  // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChooseGenderScreen()));
                  setState(() {
                    questionSixValue = _questionSixAnswer.text.toString();
                  });
                  if(index < 13)
                  {
                    setState(() {
                      index++;
                    });
                    _pageController.animateToPage(_pageController.page.toInt() + 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn
                    );
                  }
                  else{
                    print("called");
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CongratulationScreen()));
                  }
                },
                buttonText: index ==13 ? "Finish":'Next',
                fontSize: 16.0,
                textColor: ColorResources.whiteColor,
                width:MediaQuery.of(context).size.width/3.8,
              )
          ),
        ),),
        const SizedBox(
          height: 34,
        )
      ],
    );
  }
}

class QuestionSeven extends StatefulWidget {
  @override
  State<QuestionSeven> createState() => _QuestionSevenState();
}

class _QuestionSevenState extends State<QuestionSeven> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: arrAllQuestionsList[6].qName,fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        /*Container(
          width: MediaQuery.of(context).size.width,
          child: CustomTextField(
              controller: _questionTwoAnswer,
              hintText: 'Enter Relationship Status',
              fontSize: 14.0,
              textInputType: TextInputType.multiline,
              borderRadius: 29
          ),
        ),*/

        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionSevenValue = "Single";
            });
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 61,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left:30),
              decoration: BoxDecoration(
                  color: ColorResources.whiteColor,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: ListTile(
                title: const Text('Single'),
                trailing: questionSevenValue == 'Single'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionSevenValue = "Married";
            });
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 61,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left:30),
              decoration: BoxDecoration(
                  color: ColorResources.whiteColor,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: ListTile(
                title: const Text('Married'),
                trailing: questionSevenValue == "Married"? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        Expanded(child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child:  Align(
              alignment: FractionalOffset.bottomRight,
              child: CustomButton(
                height: 45,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){
                  // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChooseGenderScreen()));
                  // setState(() {
                  //   questionSevenValue = questionSevenValue;
                  // });
                  if(index < 13)
                  {
                    setState(() {
                      index++;
                    });
                    _pageController.animateToPage(_pageController.page.toInt() + 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn
                    );

                  }
                  else{
                    print("called");
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CongratulationScreen()));
                  }
                },
                buttonText: index ==13 ? "Finish":'Next',
                fontSize: 16.0,
                textColor: ColorResources.whiteColor,
                width:MediaQuery.of(context).size.width/3.8,
              )
          ),
        ),),
        const SizedBox(
          height: 34,
        )
      ],
    );
  }
}

class QuestionEight extends StatefulWidget {
  @override
  State<QuestionEight> createState() => _QuestionEightState();
}

class _QuestionEightState extends State<QuestionEight> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: arrAllQuestionsList[7].qName,fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        Container(
          width: MediaQuery.of(context).size.width,
          child: CustomTextField(
              controller: _questionEightAnswer,
              hintText: 'Enter Height',
              fontSize: 14.0,
              textInputType: TextInputType.multiline,
              borderRadius: 29
          ),
        ),
        Expanded(child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child:  Align(
              alignment: FractionalOffset.bottomRight,
              child: CustomButton(
                height: 45,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){
                  // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChooseGenderScreen()));
                  setState(() {
                    questionEightValue = _questionEightAnswer.text.toString();
                  });
                  if(index < 13)
                  {
                    setState(() {
                      index++;
                    });
                    _pageController.animateToPage(_pageController.page.toInt() + 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn
                    );

                  }
                  else{
                    print("called");
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CongratulationScreen()));
                  }
                },
                buttonText: index ==13 ? "Finish":'Next',
                fontSize: 16.0,
                textColor: ColorResources.whiteColor,
                width:MediaQuery.of(context).size.width/3.8,
              )
          ),
        ),),
        const SizedBox(
          height: 34,
        )
      ],
    );
  }
}

class QuestionNine extends StatefulWidget {
  @override
  State<QuestionNine> createState() => _QuestionNineState();
}

class _QuestionNineState extends State<QuestionNine> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: arrAllQuestionsList[8].qName,fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        Container(
          width: MediaQuery.of(context).size.width,
          child: CustomTextField(
              controller: _questionNineAnswer,
              hintText: 'Enter Number of Childern',
              fontSize: 14.0,
              textInputType: TextInputType.multiline,
              borderRadius: 29
          ),
        ),
        Expanded(child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child:  Align(
              alignment: FractionalOffset.bottomRight,
              child: CustomButton(
                height: 45,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){
                  // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChooseGenderScreen()));
                  setState(() {
                    questionNineValue = _questionNineAnswer.text.toString();
                  });
                  if(index < 13)
                  {
                    setState(() {
                      index++;
                    });
                    _pageController.animateToPage(_pageController.page.toInt() + 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn
                    );

                  }
                  else{
                    print("called");
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CongratulationScreen()));
                  }
                },
                buttonText: index ==13 ? "Finish":'Next',
                fontSize: 16.0,
                textColor: ColorResources.whiteColor,
                width:MediaQuery.of(context).size.width/3.8,
              )
          ),
        ),),
        const SizedBox(
          height: 34,
        )
      ],
    );
  }
}

class QuestionTen extends StatefulWidget {
  const QuestionTen({Key key}) : super(key: key);

  @override
  State<QuestionTen> createState() => _QuestionTenState();
}

class _QuestionTenState extends State<QuestionTen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: arrAllQuestionsList[9].qName,fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionTenValue = "Yes";
            });
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 61,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left:30),
              decoration: BoxDecoration(
                  color: ColorResources.whiteColor,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: ListTile(
                title: const Text('Yes'),
                trailing: questionTenValue == 'Yes'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionTenValue = "No";
            });
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 61,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left:30),
              decoration: BoxDecoration(
                  color: ColorResources.whiteColor,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: ListTile(
                title: const Text('No'),
                trailing: questionTenValue == "No"? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        Expanded(child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child:  Align(
              alignment: FractionalOffset.bottomRight,
              child: CustomButton(
                height: 45,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){
                  // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChooseGenderScreen()));
                  setState(() {
                    questionNineValue = _questionNineAnswer.text.toString();
                  });
                  if(index < 13)
                  {
                    setState(() {
                      index++;
                    });
                    _pageController.animateToPage(_pageController.page.toInt() + 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn
                    );

                  }
                  else{
                    print("called");
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CongratulationScreen()));
                  }
                },
                buttonText: index ==13 ? "Finish":'Next',
                fontSize: 16.0,
                textColor: ColorResources.whiteColor,
                width:MediaQuery.of(context).size.width/3.8,
              )
          ),
        ),),
        const SizedBox(
          height: 34,
        )
      ],
    );
  }
}



class QuestionElevan extends StatefulWidget {
  const QuestionElevan({Key key}) : super(key: key);

  @override
  State<QuestionElevan> createState() => _QuestionElevanState();
}

class _QuestionElevanState extends State<QuestionElevan> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: arrAllQuestionsList[10].qName,fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questioneElevanValue = "Yes";
            });
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 61,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left:30),
              decoration: BoxDecoration(
                  color: ColorResources.whiteColor,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: ListTile(
                title: const Text('Yes'),
                trailing: questioneElevanValue == 'Yes'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questioneElevanValue = "No";
            });
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 61,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left:30),
              decoration: BoxDecoration(
                  color: ColorResources.whiteColor,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: ListTile(
                title: const Text('No'),
                trailing: questioneElevanValue == "No"? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),

        Expanded(child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child:  Align(
              alignment: FractionalOffset.bottomRight,
              child: CustomButton(
                height: 45,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){
                  // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChooseGenderScreen()));
                  setState(() {
                    questionNineValue = _questionNineAnswer.text.toString();
                  });
                  if(index < 13)
                  {
                    setState(() {
                      index++;
                    });
                    _pageController.animateToPage(_pageController.page.toInt() + 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn
                    );

                  }
                  else{
                    print("called");
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CongratulationScreen()));
                  }
                },
                buttonText: index ==13 ? "Finish":'Next',
                fontSize: 16.0,
                textColor: ColorResources.whiteColor,
                width:MediaQuery.of(context).size.width/3.8,
              )
          ),
        ),),
        const SizedBox(
          height: 34,
        )
      ],
    );
  }
}

class QuestionTwale extends StatefulWidget {
  

  @override
  State<QuestionTwale> createState() => _QuestionTwaleState();
}

class _QuestionTwaleState extends State<QuestionTwale> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: arrAllQuestionsList[11].qName,fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionTwaleValue = "Yes";
            });
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 61,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left:30),
              decoration: BoxDecoration(
                  color: ColorResources.whiteColor,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: ListTile(
                title: const Text('Yes'),
                trailing: questionTwaleValue == 'Yes'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionTwaleValue = "No";
            });
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 61,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left:30),
              decoration: BoxDecoration(
                  color: ColorResources.whiteColor,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: ListTile(
                title: const Text('No'),
                trailing: questionTwaleValue == "No"? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        Expanded(child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child:  Align(
              alignment: FractionalOffset.bottomRight,
              child: CustomButton(
                height: 45,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){
                  // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChooseGenderScreen()));
                  setState(() {
                    questionNineValue = _questionNineAnswer.text.toString();
                  });
                  if(index < 13)
                  {
                    setState(() {
                      index++;
                    });
                    _pageController.animateToPage(_pageController.page.toInt() + 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn
                    );

                  }
                  else{
                    print("called");
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CongratulationScreen()));
                  }
                },
                buttonText: index ==13 ? "Finish":'Next',
                fontSize: 16.0,
                textColor: ColorResources.whiteColor,
                width:MediaQuery.of(context).size.width/3.8,
              )
          ),
        ),),
        const SizedBox(
          height: 34,
        )
      ],
    );
  }
}

class QuestionThreteen extends StatefulWidget {

  @override
  State<QuestionThreteen> createState() => _QuestionThreteenState();
}

class _QuestionThreteenState extends State<QuestionThreteen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: arrAllQuestionsList[12].qName,fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        Container(
          width: MediaQuery.of(context).size.width,
          child: CustomTextField(
              controller: _questionThrteenAnswer,
              hintText: 'Enter Languages',
              fontSize: 14.0,
              textInputType: TextInputType.multiline,
              borderRadius: 29
          ),
        ),
        Expanded(child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child:  Align(
              alignment: FractionalOffset.bottomRight,
              child: CustomButton(
                height: 45,
                backgroundColor: ColorResources.blackColor,
                onPressed: ()async{
                  // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChooseGenderScreen()));
                  setState(() {
                    questionThreeteenValue = _questionThrteenAnswer.text.toString();
                  });
                  if(index < 13)
                  {
                    setState(() {
                      index++;
                    });
                    _pageController.animateToPage(_pageController.page.toInt() + 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn
                    );

                  }
                  else{

/*
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    var userid = prefs.getInt('userid');
                    Map<String, String> params = Map();
                    params['user_id'] = userid.toString();

                    print(params);
                    await _dio.post(SEND_OTP_REQUEST,data: params).then((value) {
                      // var varJson = value.data;
                      print("value = ${value}");
                      if(value.statusCode == 200)
                      {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CongratulationScreen()));
                      }
                    });*/
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CongratulationScreen()));
                  }
                },
                buttonText: index ==13 ? "Finish":'Next',
                fontSize: 16.0,
                textColor: ColorResources.whiteColor,
                width:MediaQuery.of(context).size.width/3.8,
              )
          ),
        ),),
        const SizedBox(
          height: 34,
        )
      ],
    );
  }
}





