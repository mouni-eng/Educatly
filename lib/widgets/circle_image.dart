import 'dart:io';
import 'package:educatly/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:educatly/constants.dart';
import 'package:educatly/size_config.dart';
import 'package:educatly/widgets/custom_text.dart';
import 'package:image_picker/image_picker.dart';

class CircleImage extends StatelessWidget {
  final String? imageSrc;
  final String avatarLetters;
  final double cawidth, caheight;

  const CircleImage({
    super.key,
    required this.imageSrc,
    required this.avatarLetters,
    required this.cawidth,
    required this.caheight,
  });

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return imageSrc != null && imageSrc!.isNotEmpty
        ? SizedBox(
            width: cawidth,
            height: caheight,
            child: CustomCachedImage(
              url: imageSrc!,
              imageType: ImageType.network,
              boxFit: BoxFit.cover,
              boxShape: BoxShape.circle,
            ),
          )
        : SizedBox(
            width: cawidth,
            height: caheight,
            child: CircleAvatar(
              backgroundColor: color.primaryColor,
              child: CustomText(
                text: avatarLetters,
                maxlines: 1,
                fontSize: width(12),
                fontWeight: FontWeight.bold,
                color: color.primaryColorLight,
              ),
            ),
          );
  }
}

class BorderImage extends StatelessWidget {
  final String? imageSrc;
  final String avatarLetters;
  final double cawidth, caheight, radius;

  const BorderImage({
    super.key,
    required this.imageSrc,
    required this.avatarLetters,
    required this.cawidth,
    required this.caheight,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return imageSrc != null && imageSrc!.isNotEmpty
        ? Container(
            width: cawidth,
            height: caheight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: CustomCachedImage(
                url: imageSrc!,
                imageType: ImageType.network,
                boxFit: BoxFit.cover,
              ),
            ),
          )
        : Container(
            width: cawidth,
            height: caheight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: color.primaryColor,
            ),
            child: Center(
              child: CustomText(
                text: avatarLetters,
                maxlines: 1,
                fontSize: width(12),
                fontWeight: FontWeight.bold,
                color: color.primaryColorLight,
              ),
            ),
          );
  }
}

class CustomImagePicker extends StatelessWidget {
  const CustomImagePicker(
      {super.key,
      required this.widgetBuilder,
      required this.onFilePick,
      this.showOnLongPress = false});

  final Widget Function() widgetBuilder;
  final Function(File) onFilePick;
  final bool? showOnLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => showOnLongPress! ? _showBottomSheet(context) : null,
      onTap: () => showOnLongPress! ? null : _showBottomSheet(context),
      child: widgetBuilder.call(),
    );
  }

  void _showBottomSheet(BuildContext context) {
    var color = Theme.of(context);
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext buildContext) {
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  color: color.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => _getFromCamera(context),
                              icon: const Icon(Icons.camera),
                              tooltip: 'Test',
                              color: color.primaryColor,
                            ),
                            CustomText(
                              text: 'camera',
                              fontSize: width(12),
                            )
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () => _getFromGallery(context),
                                icon: const Icon(Icons.image_sharp),
                                color: color.primaryColor),
                            CustomText(
                              text: 'gallery',
                              fontSize: width(12),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _getFromGallery(BuildContext context) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      onFilePick.call(File(pickedFile.path));
    }
    Navigator.pop(context);
  }

  /// Get from Camera
  _getFromCamera(BuildContext context) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      onFilePick.call(File(pickedFile.path));
    }
    Navigator.pop(context);
  }
}

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({
    super.key,
    required this.profileImage,
    required this.onPickImage,
    required this.profileImageUrl,
  });

  final File? profileImage;

  final String? profileImageUrl;

  final Function(File) onPickImage;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return CustomImagePicker(
      widgetBuilder: () => SizedBox(
        height: height(100),
        width: width(101),
        child: Stack(
          children: [
            Container(
              width: width(90),
              height: height(90),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: color.primaryColorDark.withOpacity(0.25),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: profileImage != null
                      ? Image(
                          image: FileImage(profileImage!),
                          fit: BoxFit.cover,
                        )
                      : CheckImageAvailable(
                          profileImageUrl: profileImageUrl,
                        )),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: width(36),
                height: height(36),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [boxShadow],
                  color: color.scaffoldBackgroundColor,
                ),
                child: SvgPicture.asset(
                  "assets/icons/Camera.svg",
                  width: width(18),
                  height: height(18),
                  color: color.primaryColor,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ],
        ),
      ),
      onFilePick: onPickImage,
    );
  }
}

class CheckImageAvailable extends StatelessWidget {
  const CheckImageAvailable({super.key, required this.profileImageUrl});

  final String? profileImageUrl;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return profileImageUrl == null || profileImageUrl!.isEmpty
        ? Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width(15),
              vertical: height(15),
            ),
            child: SvgPicture.asset(
              "assets/icons/people.svg",
              color: color.scaffoldBackgroundColor,
            ),
          )
        : CustomCachedImage(
            url: profileImageUrl!,
            boxFit: BoxFit.cover,
          );
  }
}
