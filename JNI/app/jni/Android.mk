LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := videokit
LOCAL_LDLIBS := -llog -ljnigraphics -lz -landroid
LOCAL_CFLAGS := -Wdeprecated-declarations
ANDROID_LIB := -landroid
LOCAL_CFLAGS := -Iexternal/ffmpeg -Igenerated
LOCAL_SRC_FILES :=  videokit.c ffmpeg.c ffmpeg_filter.c ffmpeg_opt.c cmdutils.c
LOCAL_SHARED_LIBRARIES := libx264 libavformat libavcodec libswscale libavutil libswresample libavfilter libavdevice

$(call import-add-path,$(LOCAL_PATH))
include $(BUILD_SHARED_LIBRARY)
$(call import-module,generated/android/$(CPU))
LOCAL_LDLIBS += -lx264