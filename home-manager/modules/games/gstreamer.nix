{ config, pkgs, lib, ... }:

{

  # https://github.com/bottlesdevs/documentation/blob/master/faq/video-gstreamer-problems.md

  home.packages = with pkgs; [
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi
  ];

}
