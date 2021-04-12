import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';
import 'package:image_picker/image_picker.dart';

class PickPhotoAndConfirmDialog extends StatefulWidget {
  File? selectedPhoto;
  final double total;
  final void Function() func;
  final void Function(File a) photoCallBack;

  @override
  _PickPhotoAndConfirmDialogState createState() =>
      _PickPhotoAndConfirmDialogState();

  PickPhotoAndConfirmDialog(
      {required this.total, required this.func, required this.photoCallBack});
}

class _PickPhotoAndConfirmDialogState extends State<PickPhotoAndConfirmDialog> {
  final picker = ImagePicker();

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
                  Icon(Icons.check_circle_outline_rounded,size: 50,color: MyColors.yellow600,),
                  Padding(
                    padding: const EdgeInsets.all(Dimens.insetM),
                    child: Text(' HOLD ON!',style: Styles.appTheme.textTheme.headline3?.copyWith(color: MyColors.yellow400,fontWeight: FontWeight.w500),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimens.insetS),
                    child: Text('Make payment to the restaurant', maxLines: 2,style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: Colors.black54),),
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
                        child: Icon(Icons.photo_camera,size: 30,color: MyColors.yellow600,)) : Container(
                        height: 150,
                        width: 100,
                        child: Image.file(widget.selectedPhoto!,fit: BoxFit.cover,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimens.insetS),
                    child: Text('Please take a snap of the receipt provided by the restaurant', maxLines: 2,style: Styles.appTheme.textTheme.bodyText1,textAlign: TextAlign.center,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Dimens.insetM),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: (){
                          Navigator.of(context).pop();
                        },
                          child: Text('CANCEL',style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: MyColors.yellow400),),),
                        Builder(
                          builder: (BuildContext context){
                            return InkWell(
                              onTap: (){
                                if(widget.selectedPhoto == null){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.white,
                                    content: Text(
                                      Strings.pleaseSelectAPhoto,
                                      style: Styles
                                          .appTheme.textTheme.bodyText1!
                                          .copyWith(color: MyColors.yellow400),
                                    ),
                                    duration: Duration(milliseconds: 2000),
                                  ));
                                }else{
                                  //todo: proceed to the next page
                                  widget.func();
                                }
                              },
                              child: Container(
                                height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: MyColors.yellow400,
                                  borderRadius: BorderRadius.circular(10),
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
        widget.photoCallBack(widget.selectedPhoto!);
      } else {
        print('No image selected.');
      }
    });
  }
}
