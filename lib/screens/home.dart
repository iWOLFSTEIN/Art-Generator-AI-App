import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stem_ai_art_generator/provider/data_provider.dart';
import 'package:stem_ai_art_generator/screens/loading.dart';
import 'package:stem_ai_art_generator/services/save_image.dart';
import 'package:stem_ai_art_generator/widgets/custom_text_button.dart';
import '../widgets/app_branding.dart';
import '../widgets/custom_alert_dialogues.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/generated_image.dart';
import '../widgets/input_prompt.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final inputController = TextEditingController();
  List images = [
    'https://cdn.britannica.com/91/181391-050-1DA18304/cat-toes-paw-number-paws-tiger-tabby.jpg',
    'https://static01.nyt.com/images/2021/09/14/science/07CAT-STRIPES/07CAT-STRIPES-mediumSquareAt3X-v2.jpg',
    'https://th-thumbnailer.cdn-si-edu.com/bZAar59Bdm95b057iESytYmmAjI=/1400x1050/filters:focal(594x274:595x275)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/95/db/95db799b-fddf-4fde-91f3-77024442b92d/egypt_kitty_social.jpg',
    'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y3V0ZSUyMGNhdHxlbnwwfHwwfHw%3D&w=1000&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    List oddImages = [];
    List evenImages = [];
    for (var i = 0; i < images.length; i++) {
      if (i % 2 == 0) {
        evenImages.add(images[i]);
      } else {
        oddImages.add(images[i]);
      }
    }
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    inputController.text = dataProvider.prompt;
    return Scaffold(
      backgroundColor: const Color(0xFFECF7FE),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
              ),
              const AppBranding(),
              Container(
                height: 40,
              ),
              CustomTextField(inputController: inputController),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 20, right: 10),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      height: 10,
                    ),
                    InputPrompt(prompt: 'Astronaut riding horse on moon'),
                    InputPrompt(prompt: 'Dragon queen'),
                    InputPrompt(prompt: 'Unicorn sitting on mountain'),
                    InputPrompt(
                        prompt: 'A guy with mustache on a metro station'),
                    InputPrompt(prompt: 'Adorable robot in the water'),
                    InputPrompt(prompt: 'Robotic monkey'),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextButton(
                  buttonHeight: 60.0,
                  action: () {
                    generateImage();
                  },
                  title: 'Generate Image',
                  borderRadius: 15,
                  fontSize: 17.5,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xFFD8EFFD),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Generated with stem ai',
                      style: TextStyle(
                        color: const Color(0xFF1F1F1F).withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              for (var i in oddImages)
                                GeneratedImage(imageAdress: i),
                            ],
                          )),
                          const SizedBox(
                            width: 9,
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              for (var i in evenImages)
                                GeneratedImage(imageAdress: i),
                            ],
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  generateImage() {
    if (inputController.text != '') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Loading(
                    prompt: inputController.text,
                  )));
    } else {
      showGeneralAlert();
    }
  }

  showGeneralAlert() {
    var alert = CustomGeneralAlertDialogue(
      title: 'Text field cannot be empty!',
      subtitle: 'Please enter something in the text field to generate images.',
      actionTitle: 'Okay',
      action: () {
        Navigator.pop(context);
      },
    );
    showDialog(context: context, builder: (context) => alert);
  }
}
