import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';
import 'package:image_picker/image_picker.dart';

class DeliverPhotoAndConfirmDialog extends StatefulWidget {
  File? selectedPhoto;
  final double total;
  final void Function(File a) imageCallBack;
  final void Function() callApi;

  @override
  _DeliverPhotoAndConfirmDialogState createState() =>
      _DeliverPhotoAndConfirmDialogState();

  DeliverPhotoAndConfirmDialog(
      {required this.total,
      required this.imageCallBack,
      required this.callApi});
}

class _DeliverPhotoAndConfirmDialogState extends State<DeliverPhotoAndConfirmDialog> {
  final picker = ImagePicker();
  final double _iconSize = 50;
  final double _iconSizes = 30;
  final double _containerH = 100;
  final double _containerHl = 150;
  final double _containerC = 10;
  final double _containerW = 100;
  final double _containerWs = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.insetS),
            ),
            elevation: 0,
            // backgroundColor: Colors.black54,
            child: Padding(
              padding: const EdgeInsets.all(Dimens.insetM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle_outline_rounded,size: _iconSize,color: MyColors.yellow600,),
                  Padding(
                    padding: const EdgeInsets.all(Dimens.insetM),
                    child: Text(Strings.holdon,style: Styles.appTheme.textTheme.headline3?.copyWith(color: MyColors.yellow400,fontWeight: FontWeight.w500),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimens.insetS),
                    child: Text(Strings.receivedPaymentFromUser, maxLines: 2,style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: Colors.black54),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimens.insetXs),
                    child: Text(Strings.subTotal, maxLines: 2,style: Styles.appTheme.textTheme.bodyText1,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimens.insetS),
                    child: Text('${Strings.sCurrency}${widget.total}', maxLines: 2,style: Styles.appTheme.textTheme.bodyText1,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimens.insetXs),
                    child: (widget.selectedPhoto == null) ? GestureDetector(
                        onTap: ()async{
                          await openCamera();
                          setState(() {

                          });
                        },
                        child: Icon(Icons.photo_camera,size: _iconSizes,color: MyColors.yellow600,)) : Container(
                        height: _containerHl,
                        width: _containerW,
                        child: Image.file(widget.selectedPhoto!,fit: BoxFit.cover,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimens.insetS),
                    child: Text(Strings.pleaseTakeSnap, maxLines: 2,style: Styles.appTheme.textTheme.bodyText1,textAlign: TextAlign.center,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Dimens.insetM),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: (){
                          Navigator.of(context).pop();
                        },
                          child: Text(Strings.cancel,style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: MyColors.yellow400),),),
                        Builder(
                          builder: (BuildContext context){
                            return InkWell(
                              onTap: (){
                                if(widget.selectedPhoto == null){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.black,
                                    content: Text(
                                      Strings.pleaseSelectAPhoto,
                                      style: Styles.appTheme.textTheme.bodyText1!
                                          .copyWith(color: Colors.orange),
                                    ),
                                    duration: Duration(milliseconds: 2000),
                                  ));
                                }else{
                                  widget.callApi();
                                }
                              },
                              child: Container(
                                height: _containerWs,
                                width: _containerH,
                                decoration: BoxDecoration(
                                  color: MyColors.yellow400,
                                  borderRadius: BorderRadius.circular(_containerC),
                                ),
                                child: Center(child: Text(Strings.done,style: Styles.appTheme.textTheme.headline4?.copyWith(color: Colors.white),)),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> openCamera()async{
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        widget.selectedPhoto = File(pickedFile.path);
        widget.imageCallBack(widget.selectedPhoto!);
      } else {
        print('No image selected.');
      }
    });
  }
}
