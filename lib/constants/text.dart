
import 'package:flutter/material.dart';

class greyText extends StatelessWidget {
  const greyText({
    Key? key,
    this.text = '',
    this.color = const Color(0xff969696),
    this.fontWeight = FontWeight.w600,
  }) : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontFamily: 'IBMPlexSans',
          color: color,
          fontWeight: fontWeight,
          fontSize: 18),
    );
  }
}

class greyValueText extends StatelessWidget {
  const greyValueText({
    Key? key,
    this.text = '',
    this.color = const Color(0xff969696),
    this.fontWeight = FontWeight.w600,
  }) : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontFamily: 'IBMPlexSans',
          fontSize: 18),
    );
  }
}

class subTitleText extends StatelessWidget {
  const subTitleText({
    Key? key,
    this.text = '',
    this.color = const Color(0xff4F4F4F),
    this.fontWeight = FontWeight.w600,
  }) : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontFamily: 'IBMPlexSans',
          fontSize: 15),
    );
  }
}

class text15Inter extends StatelessWidget {
  const text15Inter({Key? key,this.text='',this.color=Colors.white,this.fontWeight=FontWeight.w500,this.maxLines,this.textAlign}) : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final int? maxLines;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(
          fontFamily: 'Inter',
          color:color,
          fontWeight:fontWeight,
          fontSize:15),

    );
  }
}


class text15Normal extends StatelessWidget {
  const text15Normal({Key? key,this.text='',this.color=Colors.white,this.fontWeight=FontWeight.w500,this.textAlign}) : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(
          color:color,
          fontWeight:fontWeight,
          fontSize: 15),

    );
  }
}
class text14Normal extends StatelessWidget {
  const text14Normal({Key? key,this.text='',this.color=Colors.white,this.fontWeight=FontWeight.w500,this.textAlign,this.maxLines}) : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(
          color:color,
          fontWeight:fontWeight,
          fontSize: 14),

    );
  }
}
class text17Normal extends StatelessWidget {
  const text17Normal({Key? key,this.text='',this.color=Colors.white,this.fontWeight=FontWeight.w500,this.maxLines}) : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow:TextOverflow.clip,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(

          color:color,
          fontWeight:fontWeight,
          fontSize: 17),

    );
  }
}
class text16Normal extends StatelessWidget {
  const text16Normal({Key? key,this.text='',this.color=Colors.white,this.fontWeight=FontWeight.w500}) : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow:TextOverflow.clip,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(
          color:color,
          fontWeight:fontWeight,
          fontSize: 16),

    );
  }
}
class text13Normal extends StatelessWidget {
  const text13Normal({Key? key,this.text='',this.color=Colors.white,this.fontWeight=FontWeight.w500,this.maxLines}) : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(
          color:color,
          fontWeight:fontWeight,
          fontSize: 13),

    );
  }
}
class text11Normal extends StatelessWidget {
  const text11Normal({Key? key,this.text='',this.color=Colors.white,this.fontWeight=FontWeight.w500}) : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(
          color:color,
          fontWeight:fontWeight,
          fontSize: 11),

    );
  }
}
class text12Normal extends StatelessWidget {
  const text12Normal({Key? key,this.text='',this.color=Colors.white,this.fontWeight=FontWeight.w500}) : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(
          color:color,
          fontWeight:fontWeight,
          fontSize: 12),

    );
  }
}
class text10Normal extends StatelessWidget {
  const text10Normal({Key? key,this.text='',this.color=Colors.white,this.fontWeight=FontWeight.w800}) : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(
          color:color,
          fontWeight:fontWeight,
          fontSize: 10),

    );
  }
}
class text20Normal extends StatelessWidget {
  const text20Normal({Key? key,this.text='',this.color=Colors.white,this.fontWeight=FontWeight.w500,this.maxLines,this.textAlign}) : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final int? maxLines;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(
          color:color,
          fontWeight:fontWeight,
          fontSize:20),

    );
  }
}
class text25Normal extends StatelessWidget {
  const text25Normal({Key? key,this.text='',this.color=Colors.white,this.fontWeight=FontWeight.w500}) : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(
          color:color,
          fontWeight:fontWeight,
          fontSize:25),

    );
  }
}
class text23Normal extends StatelessWidget {
  const text23Normal({Key? key,this.text='',this.color=Colors.white,this.fontWeight=FontWeight.w500}) : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(
          color:color,
          fontWeight:fontWeight,
          fontSize:23),

    );
  }
}

