import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/presentation/widgets/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../account_page/tabs/balance/methods/failed_promocode_dialog_box.dart';
import '../account_page/tabs/balance/methods/succesed_promocode_dialog_box.dart';

class PaymentWebView extends StatefulWidget {
  const PaymentWebView({
    super.key,
    required this.paymentUrl,
    required this.onSuccess,
    required this.onFail,
    // required this.orderTime,
    // required this.address,
    // required this.recipient,
    // required this.fbEvent
  });

  final Function onFail;
  final Function onSuccess;
  final String paymentUrl;

  // String? orderTime;
  // String? address;
  // String? recipient;
  // Function? fbEvent;

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  final _controller = WebViewController();

  @override
  void initState() {
    super.initState();
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('http://rayza.az/')) {
              if (request.url.contains('success_payment')) {
                Navigator.of(context).pop(context);
                succesedDialogBox(context);
                widget.onSuccess();
              } else if (request.url.contains('failed_payment')) {
                Navigator.of(context).pop(context);
                failedPromocodeDialogBox(context);
                widget.onFail();
              }
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  // Widget buildAppBar() {
  //   return AppBar(
  //     automaticallyImplyLeading: false,
  //     centerTitle: true,
  //     leading: CloseButton(
  //       color: primaryColor,
  //       onPressed: () => Navigator.of(context).of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(builder: (context) => HomeScreen()),
  //           (route) => route.isFirst),
  //     ),
  //     title: Text('online_payment'),
  //   );
  // }

  Widget buildWebView() {
    return WebViewWidget(
      controller: _controller,
      //     initialUrl: '${widget.paymentUrl}',
      //     javascriptMode: JavascriptMode.unrestricted,
      //     onWebViewCreated: (WebViewController webViewController) {
      //       _controller.complete(webViewController);
      //     },
      //     navigationDelegate: (NavigationRequest request) {
      //       print('allowing navigation to $request');
      //       if (request.url.contains("lilac.az/orderSuccess?orderId=")) {
      //         Navigator.of(context).pushReplacement(context,
      //             MaterialPageRoute(builder: (context) {
      //           return ;
      //         }));
      //         return NavigationDecision.prevent;
      //       }
      //       if (request.url.contains("systemMalfunction.aspx")) {
      //         Navigator.of(context).pop(context);
      //         print('odenish ugursuz oldu');
      //         return NavigationDecision.prevent;
      //       }
      //       return NavigationDecision.navigate;
      //     },
      //     onPageStarted: (String url) {
      //       print('-- current url $url');
      //       print('Page started loading: $url');
      //     },
      //     onPageFinished: (String url) {
      //       print('Page finished loading: $url');
      //     },
      //     gestureNavigationEnabled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight.h),
            child: customAppBar(context, 'Ödəniş')),
        body: buildWebView(),
      ),
    );
  }
}
