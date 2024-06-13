import 'package:flutter/material.dart';

class TermConditionPage extends StatefulWidget {
  @override
  _TermConditionPageState createState() => _TermConditionPageState();
}

class _TermConditionPageState extends State<TermConditionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Terms and Conditions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Welcome to eComerse!'),
            SizedBox(height: 8),
            Text(
              'These terms and conditions outline the rules and regulations for the use of eComerse\'s Website, located at http://ecomerse.superaset.com/.',
            ),
            SizedBox(height: 8),
            Text(
              'By accessing this website we assume you accept these terms and conditions. Do not continue to use eComerse if you do not agree to take all of the terms and conditions stated on this page.',
            ),
            SizedBox(height: 8),
            Text(
              'The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: "Client", "You" and "Your" refers to you, the person log on this website and compliant to the Company’s terms and conditions. "The Company", "Ourselves", "We", "Our" and "Us", refers to our Company. "Party", "Parties", or "Us", refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client’s needs in respect of provision of the Company’s stated services, in accordance with and subject to, prevailing law of Netherlands. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same. Our Terms and Conditions were created with the help of the Terms & Conditions Generator.',
            ),
            SizedBox(height: 16),
            Text(
              'Cookies',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We employ the use of cookies. By accessing eComerse, you agreed to use cookies in agreement with the eComerse\'s Privacy Policy.',
            ),
            SizedBox(height: 8),
            Text(
              'Most interactive websites use cookies to let us retrieve the user\'s details for each visit. Cookies are used by our website to enable the functionality of certain areas to make it easier for people visiting our website. Some of our affiliate/advertising partners may also use cookies.',
            ),
            SizedBox(height: 16),
            Text(
              'License',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Unless otherwise stated, eComerse and/or its licensors own the intellectual property rights for all material on eComerse. All intellectual property rights are reserved. You may access this from eComerse for your own personal use subjected to restrictions set in these terms and conditions.',
            ),
            SizedBox(height: 8),
            SizedBox(height: 8),
            Text('This Agreement shall begin on the date hereof.'),
            SizedBox(height: 8),
            Text(
              'Parts of this website offer an opportunity for users to post and exchange opinions and information in certain areas of the website. eComerse does not filter, edit, publish or review Comments prior to their presence on the website. Comments do not reflect the views and opinions of eComerse,its agents and/or affiliates. Comments reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, eComerse shall not be liable for the Comments or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this website.',
            ),
            SizedBox(height: 8),
            Text(
              'eComerse reserves the right to monitor all Comments and to remove any Comments which can be considered inappropriate, offensive or causes breach of these Terms and Conditions.',
            ),
            SizedBox(height: 8),
            Text(
              'You hereby grant eComerse a non-exclusive license to use, reproduce, edit and authorize others to use, reproduce and edit any of your Comments in any and all forms, formats or media.',
            ),
            SizedBox(height: 16),
            Text(
              'Hyperlinking to our Content',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
                'The following organizations may link to our Website without prior written approval:'),
            SizedBox(height: 8),
          ]),
        ),
      ),
    );
  }
}
