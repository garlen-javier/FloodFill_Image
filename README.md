# Flood Fill Image

[![Version](https://img.shields.io/pub/v/floodfill_image.svg)](https://pub.dev/packages/floodfill_image) ![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=flat) [![Support](https://img.shields.io/badge/Buy%20Me%20Coffee-Support-orange?style=flat&logo=buy-me-a-coffee)](https://www.buymeacoffee.com/garlenjavier)

## Overview

Flutter widget that can use paint bucket functionality on the provided image using Queue-Linear Flood Fill Algorithm by J. Dunlap. For more info check out my blog : [Flood Fill in Flutter](https://www.meekcode.com/blog/flood-fill-in-flutter)

Kindly like:+1: the package at [pub dev](https://pub.dev/packages/floodfill_image) or star:star: the repo in [github](https://github.com/garlen-javier/FloodFill_Image) if you find this library useful. :wink:

<p align="center">
<img src="https://user-images.githubusercontent.com/71249192/106970202-59d04780-6787-11eb-81ca-2cd000b900d7.gif" alt="demo dog gif" width=400 height=600 />
</p>

## Usage

```dart
FloodFillImage(
    imageProvider: AssetImage("assets/dog.jpg"),
    fillColor: Colors.amber,
    avoidColor: [Colors.transparent, Colors.black],
)
```

## Parameters

| Name | Type | Description |
|---|---|---|
| `imageProvider` | ImageProvider | The image to display via ImageProvider. <br>You can use `AssetImage` or `NetworkImage`. |
| `fillColor` | Color | Color use for filling the area. |
| `isFillActive` | bool | Set *false* if you want to disable on touch fill function. <br>Default value is *true*. |
| `avoidColor` | List\<Color> | List of color that determines to which `Color` is/are needed to be avoided upon touch. <br>**Note:** Nearest color shade is applied. |
| `tolerance` | int | Set fill value *tolerance* that ranges from 0 to 100. <br>Default value is 8. |
| `width` | int | Width of the image. Parent widget width will be prioritize if it's provided and less than the image width. |
| `height` | int | Height of the image. Parent widget height will be prioritize if it's provided and less than the image height. |
| `alignment` | AlignmentGeometry | Alignment of the image. |
| `loadingWidget` | Widget | Widget to show while the image is being processed on initialization. <br>It uses `CircularProgressIndicator` by default. |
| `onFloodFillStart` | Function(Offset position,Image image) | Callback function that returns the touch position and an `Image` from *dart:ui* when flood fill starts. <br>**Note:** Touch coordinate is relative to the image dimension. |
| `onFloodFillEnd` | Function(Image image) | Callback function that returns an `Image` from *dart:ui* when flood fill ended. |

## Coffee

<a href="https://www.buymeacoffee.com/garlenjavier" target="_blank" rel="noreferrer"><img src="https://www.buymeacoffee.com/assets/img/custom_images/black_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

## License

MIT License, see the [LICENSE.md](https://github.com/garlen-javier/FloodFill_Image/blob/main/LICENSE) file for details.

