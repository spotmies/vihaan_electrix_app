import 'package:flutter/material.dart';
import 'package:vihaanelectrix/views/venroute/product_overview.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';

productListCard(BuildContext context, product) {
  return InkWell(
    onTap: () {
      // log(product.toString());
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductOverview(
                    product: product,
                  )));
    },
    child: Stack(
      children: [
        Container(
            height: height(context) * 0.35,
            width: width(context) * 1,
            color: Colors.blue[50],
            alignment: Alignment.center,
            child: Container(
                height: height(context) * 0.26,
                width: width(context) * 0.85,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[50]!,
                          blurRadius: 1.0,
                          spreadRadius: 1.0)
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Row(
                  children: [
                    // SizedBox(
                    //   width: width(context) * 0.25,
                    //   // color: Colors.pink[50],
                    // ),
                    SizedBox(
                        width: width(context) * 0.60,
                        height: height(context) * 0.35,
                        // color: Colors.white,
                        // alignment: Alignment.center,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              // color: Colors.red,
                              width: width(context) * 0.60,
                              height: height(context) * 0.16,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: height(context) * 0.05,
                                    width: width(context) * 0.3,
                                    padding: EdgeInsets.only(
                                        left: width(context) * 0.04),
                                    child: Image.asset(
                                      'assets/pngs/corbett_icon.png',
                                      height: height(context) * 0.05,
                                      width: width(context) * 0.3,
                                    ),
                                    // child:Image.network(widget.product['basicDetails']
                                    //                     ['logo']
                                    //                 .toString()),
                                    //           ),
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    width: width(context) * 0.35,
                                    height: height(context) * 0.11,
                                    child: Wrap(
                                      alignment: WrapAlignment.spaceEvenly,
                                      // crossAxisAlignment:
                                      //     WrapCrossAlignment.end,
                                      children: [
                                        Image.asset(
                                          'assets/pngs/bike.png',
                                          height: height(context) * 0.04,
                                          width: width(context) * 0.15,
                                        ),
                                        Image.asset(
                                          'assets/pngs/bike.png',
                                          height: height(context) * 0.04,
                                          width: width(context) * 0.1,
                                        ),
                                        Image.asset(
                                          'assets/pngs/bike.png',
                                          height: height(context) * 0.04,
                                          width: width(context) * 0.1,
                                        ),
                                        Image.asset(
                                          'assets/pngs/bike.png',
                                          height: height(context) * 0.04,
                                          width: width(context) * 0.1,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              // color: Colors.pink,
                              width: width(context) * 0.60,
                              height: height(context) * 0.1,
                              padding: EdgeInsets.only(
                                left: width(context) * 0.05,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  TextWidget(
                                    text: 'Top Speed - 120km/h',
                                    weight: FontWeight.w600,
                                  ),
                                  TextWidget(
                                    text: 'Loading Capacity - 200kg',
                                    weight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ],
                ))),
        Positioned(
            right: 1,
            child: Image.asset(
              'assets/pngs/bike.png',
              height: height(context) * 0.26,
              width: width(context) * 0.5,
            )
            // child: Image.network(
            //   product['basicDetails']['media'][0]['mediaUrl'],
            //   height: height(context) * 0.26,
            //   width: width(context) * 0.5,
            // )
            ),
      ],
    ),
  );
}
