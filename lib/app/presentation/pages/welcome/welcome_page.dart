import 'package:acolhimento_digital/app/presentation/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late PageController pageControllerA;
  late PageController pageControllerB;
  late Animatable<Color?> background;

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  void _onPageBChange() {
    pageControllerA.jumpTo(pageControllerB.offset);
  }

  void _initialize() {
    background = TweenSequence<Color?>([
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: const Color(0xff00D1B9),
          end: const Color(0xff7870CD),
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: const Color(0xff7870CD),
          end: const Color(0xffF2CA40),
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: const Color(0xffF2CA40),
          end: const Color(0xffEF8B8F),
        ),
      ),
    ]);
    pageControllerA = PageController();
    pageControllerB = PageController()..addListener(_onPageBChange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.dark,
      ),
      body: AnimatedBuilder(
        animation: pageControllerA,
        builder: (context, child) {
          final color = pageControllerA.hasClients ? (pageControllerA.page ?? 0) / 3 : .0;

          return DecoratedBox(
            decoration: BoxDecoration(
              color: background.evaluate(AlwaysStoppedAnimation(color)),
            ),
            child: child,
          );
        },
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2.3,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    pageSnapping: false,
                    controller: pageControllerA,
                    children: [
                      for (var i = 1; i <= 4; i++)
                        Padding(
                          padding: const EdgeInsets.all(90).add(const EdgeInsets.only(bottom: 40)),
                          child: Image.asset('assets/tab-$i.png'),
                        ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.maxFinite,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Color(0xff535453),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(200)),
                    ),
                    child: Center(
                      child: AnimatedBuilder(
                        animation: pageControllerA,
                        builder: (context, child) {
                          final color = pageControllerA.hasClients ? (pageControllerA.page ?? 0) / 3 : .0;

                          return SmoothPageIndicator(
                            controller: pageControllerA,
                            count: 4,
                            effect: WormEffect(
                              dotColor: Colors.white,
                              activeDotColor: background.evaluate(AlwaysStoppedAnimation(color)) ?? Colors.black,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Container(
                color: const Color(0xff535453),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: PageView(
                        controller: pageControllerB,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Bem vindo(a) ao',
                                      style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 22)),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      'Acolhimento Digital!',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff00D1B9), fontSize: 26),
                                    ),
                                  ),
                                  const Text(
                                    'Ficamos felizes que tenha nos escolhido. Com seu suporte poderemos ajudar os lares de acolhimento nesse momento de dificuldade.',
                                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 22),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Com apenas alguns cliques',
                                      style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 22)),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      'Você poderá visualizar as instituições mais próximas de você.',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff7870CD), fontSize: 26),
                                    ),
                                  ),
                                  const Text(
                                    'Depois de consultar a localização, você poderá fazer uma visita se quiser, ou ajudar com doações.',
                                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 22),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Mas tudo bem se você não puder,',
                                      style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 22)),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      'O importante é espalhar a mensagem para que outras pessoas possam ajudar.',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffF2CA40), fontSize: 26),
                                    ),
                                  ),
                                  const Text(
                                    'E que as pessoas que mais precisam possam ser vistas.',
                                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 22),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Com tudo pronto,',
                                      style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 22)),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      'Podemos começar!',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffEF8B8F), fontSize: 26),
                                    ),
                                  ),
                                  const Text(
                                    'Para visualizar informações detalhadas de um lar, basta clicar em cima do marcador.',
                                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 22),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SafeArea(
                      top: false,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 30.0, 30.0),
                        child: AnimatedBuilder(
                          animation: pageControllerA,
                          builder: (context, child) {
                            final color = pageControllerA.hasClients ? (pageControllerA.page ?? 0) / 3 : .0;

                            return FloatingActionButton(
                              onPressed: () {
                                if (pageControllerA.page! < 2.5) {
                                  pageControllerB.nextPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                } else {
                                  context.router.replace(const MapRoute());
                                }
                              },
                              backgroundColor: background.evaluate(AlwaysStoppedAnimation(color)),
                              child: const Icon(Icons.chevron_right_outlined, size: 40),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
