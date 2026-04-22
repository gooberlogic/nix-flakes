{ config, pkgs, lib, ... }:

{

  # https://github.com/bottlesdevs/documentation/blob/master/faq/video-gstreamer-problems.md

  environment.systemPackages = with pkgs; [
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi
  ];

  environment.variables = {
    GST_PLUGIN_PATH = "/run/current-system/sw/lib/gstreamer-1.0/";
    GST_PLUGIN_SYSTEM_PATH_1_0 = "${pkgs.gst_all_1.gstreamer.out}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-base}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-good}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-bad}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-ugly}/lib/gstreamer-1.0";
  };

}
