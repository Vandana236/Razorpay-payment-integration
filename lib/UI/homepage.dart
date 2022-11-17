import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _razorpay = Razorpay();
  var amountController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print('payment sucess');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("payment unsucess");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Razorpay'),),

       body: Column(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: [
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
             child:  TextField(
               controller: amountController,
                decoration: InputDecoration(
                  hintText: "enter your amount",
                ),
             ),
           ),
           CupertinoButton(
             color: Colors.green,
               child:  Text('Pay'),
               onPressed: (){
    var options = {
    'key': 'rzp_test_1DP5mmOlF5G5ag',
    'amount':  int.parse(amountController.text)*100,
    'name': 'Acme Corp.',
    'description': 'Fine T-Shirt',
    'retry': {'enabled': true, 'max_count': 1},
    'send_sms_hash': true,
    'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
    'external': {
    'wallets': ['paytm']
    }

                 };
                 _razorpay.open(options);
           })
         ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }
}
