
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/survey/congratulation_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
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
var index = 1;
class _QuestionsScreenState extends State<QuestionsScreen> {
  PageController _pageController = PageController();
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
                  child: CustomText(text:'${index<10 ? '${0}${index}':index}/10',fontSize: 14,color: ColorResources.whiteColor,),
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child:  Align(
                alignment: FractionalOffset.bottomRight,
                child: CustomButton(
                  height: 45,
                  backgroundColor: ColorResources.blackColor,
                  onPressed: (){
                    // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChooseGenderScreen()));

                    if(index < 10)
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
                  buttonText: index ==10 ? "Finish":'Next',
                  fontSize: 16.0,
                  textColor: ColorResources.whiteColor,
                  width:MediaQuery.of(context).size.width/3.8,
                )
            ),
          ),
          const SizedBox(
            height: 34,
          )
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: 'Where would you most like  to visit?',fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionOneValue = "Beaches";
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
                title: const Text('Beaches'),
                trailing: questionOneValue == 'Beaches'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionOneValue = "Hills";
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
                title: const Text('Hills'),
                trailing: questionOneValue == "Hills"? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionOneValue = "Deserts";
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
                title: const Text('Deserts'),
                trailing: questionOneValue == 'Deserts'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionOneValue = "Aboveall";
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
                title: const Text('Above all'),
                trailing: questionOneValue == 'Aboveall'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
      ],
    );
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
        CustomText(text: 'Where would you most like  to visit?',fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionTwoValue = "Beaches";
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
                title: const Text('Beaches'),
                trailing: questionTwoValue == 'Beaches'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionTwoValue = "Hills";
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
                title: const Text('Hills'),
                trailing: questionTwoValue == "Hills"? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionTwoValue = "Deserts";
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
                title: const Text('Deserts'),
                trailing: questionTwoValue == 'Deserts'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionTwoValue = "Aboveall";
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
                title: const Text('Above all'),
                trailing: questionTwoValue == 'Aboveall'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
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
        CustomText(text: 'Where would you most like  to visit?',fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionThreeValue = "Beaches";
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
                title: const Text('Beaches'),
                trailing: questionThreeValue == 'Beaches'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionThreeValue = "Hills";
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
                title: const Text('Hills'),
                trailing: questionThreeValue == "Hills"? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionThreeValue = "Deserts";
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
                title: const Text('Deserts'),
                trailing: questionThreeValue == 'Deserts'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionThreeValue = "Aboveall";
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
                title: const Text('Above all'),
                trailing: questionThreeValue == 'Aboveall'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
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
        CustomText(text: 'Where would you most like  to visit?',fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionFourValue = "Beaches";
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
                title: const Text('Beaches'),
                trailing: questionFourValue == 'Beaches'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionFourValue = "Hills";
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
                title: const Text('Hills'),
                trailing: questionFourValue == "Hills"? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionFourValue = "Deserts";
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
                title: const Text('Deserts'),
                trailing: questionFourValue == 'Deserts'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionFourValue = "Aboveall";
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
                title: const Text('Above all'),
                trailing: questionFourValue == 'Aboveall'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
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
        CustomText(text: 'Where would you most like  to visit?',fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionFiveValue = "Beaches";
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
                title: const Text('Beaches'),
                trailing: questionFiveValue == 'Beaches'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionFiveValue = "Hills";
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
                title: const Text('Hills'),
                trailing: questionFiveValue == "Hills"? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionFiveValue = "Deserts";
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
                title: const Text('Deserts'),
                trailing: questionFiveValue == 'Deserts'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionFiveValue = "Aboveall";
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
                title: const Text('Above all'),
                trailing: questionFiveValue == 'Aboveall'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
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
        CustomText(text: 'Where would you most like  to visit?',fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionSixValue = "Beaches";
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
                title: const Text('Beaches'),
                trailing: questionSixValue == 'Beaches'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionSixValue = "Hills";
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
                title: const Text('Hills'),
                trailing: questionSixValue == "Hills"? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionSixValue = "Deserts";
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
                title: const Text('Deserts'),
                trailing: questionSixValue == 'Deserts'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionSixValue = "Aboveall";
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
                title: const Text('Above all'),
                trailing: questionSixValue == 'Aboveall'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
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
        CustomText(text: 'Where would you most like  to visit?',fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionSevenValue = "Beaches";
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
                title: const Text('Beaches'),
                trailing: questionSevenValue == 'Beaches'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionSevenValue = "Hills";
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
                title: const Text('Hills'),
                trailing: questionSevenValue == "Hills"? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionSevenValue = "Deserts";
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
                title: const Text('Deserts'),
                trailing: questionSevenValue == 'Deserts'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionSevenValue = "Aboveall";
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
                title: const Text('Above all'),
                trailing: questionSevenValue == 'Aboveall'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
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
        CustomText(text: 'Where would you most like  to visit?',fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionEightValue = "Beaches";
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
                title: const Text('Beaches'),
                trailing: questionEightValue == 'Beaches'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionEightValue = "Hills";
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
                title: const Text('Hills'),
                trailing: questionEightValue == "Hills"? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionEightValue = "Deserts";
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
                title: const Text('Deserts'),
                trailing: questionEightValue == 'Deserts'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionEightValue = "Aboveall";
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
                title: const Text('Above all'),
                trailing: questionEightValue == 'Aboveall'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
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
        CustomText(text: 'Where would you most like  to visit?',fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionNineValue = "Beaches";
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
                title: const Text('Beaches'),
                trailing: questionNineValue == 'Beaches'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionNineValue = "Hills";
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
                title: const Text('Hills'),
                trailing: questionNineValue == "Hills"? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionNineValue = "Deserts";
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
                title: const Text('Deserts'),
                trailing: questionNineValue == 'Deserts'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionNineValue = "Aboveall";
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
                title: const Text('Above all'),
                trailing: questionNineValue == 'Aboveall'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
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
        CustomText(text: 'Where would you most like  to visit?',fontSize: 22,color: ColorResources.whiteColor,),
        const SizedBox(height: 30.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionTenValue = "Beaches";
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
                title: const Text('Beaches'),
                trailing: questionTenValue == 'Beaches'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionTenValue = "Hills";
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
                title: const Text('Hills'),
                trailing: questionTenValue == "Hills"? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionTenValue = "Deserts";
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
                title: const Text('Deserts'),
                trailing: questionTenValue == 'Deserts'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
        const SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            setState(() {
              // isSelected = !isSelected;
              questionTenValue = "Aboveall";
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
                title: const Text('Above all'),
                trailing: questionTenValue == 'Aboveall'? const Icon(Icons.check_circle ,color: Colors.black,):const Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
              )
          ),
        ),
      ],
    );
  }
}

