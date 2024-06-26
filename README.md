=================================
 GStreamer Static Linking README
=================================
DRAFT, April 2013
   I. INTRODUCTION
It is possible to link GStreamer libraries, plugins and applications
statically, both in case of free/libre/open-source software applications
and proprietary applications. On some platforms static linking may even
be required.
However, distributing statically linked binaries using GStreamer usually
requires additional effort to stay compliant with the GNU LGPL v2.1 license.
The purpose of this document is to draw attention to this fact, and to
summarise in layman's terms what we believe is required from anyone
distributing statically linked GStreamer binaries. Most of this also
applies to dynamically linked GStreamer binaries.
   II. DISCLAIMER
This document is not legal advice, nor is it comprehensive. It may use
words in ways that do not match the definition or use in the license
text. It may even be outright wrong. Read the license text for all the
details, it is the only legally binding document in this respect.
This document is primarily concerned with the implications for the
distribution of binaries based on LGPL-licensed software as imposed by
the LGPL license, but there may be other restrictions to the distribution
of such binaries, such as terms and conditions of distribution channels
(e.g. "app stores").
   III. THE SPIRIT OF THE LGPL LICENSE
The GNU LGPL v2.1 license allows use of such-licensed software by
proprietary applications, but still aims to ensure that at least the
LGPL-licensed software parts remain free under all circumstances. This
means any changes to LGPL-licensed source code must be documented and
be made available on request to those who received binaries of the
software. It also means that it must be possible to make changes to the
LGPL-licensed software parts and make the application use those, as far
as that is possible. And that recipients of an application using
LGPL-licensed software are made aware of their rights according to the
LGPL license.
In an environment where GStreamer libraries and plugins are used as
dynamically-loaded shared objects (DLL/.so/.dyn files), this is usually
not a big problem, because it is fairly easy to compile a modified version
of the GStreamer libraries or LGPL plugins, and the application will/should
just pick up and use the modified version automatically. All that is needed
is for the original, LGPL-licensed source code and source code modifications
to be made available, and for a way to build the libraries or plugins for
the platform required (usually that will be using the build system scripts
that come with GStreamer, and using the typical build environment on the
system in question, but where that is not the case the needed build scripts
and/or tools would need to be provided as well).
   IV. THINGS YOU NEED TO DO
  * You must tell users of your application that you are using LGPL-licensed
    software, which LGPL-licensed software exactly, and you must provide them
    with a copy of the license so they know their rights under the LGPL.
  * You must provide (on request) all the source code and all the changes
    or additions you have made to the LGPL-licensed software you are using.
    For GStreamer code we would recommend that the changes be provided either
    in form of a branch in a git repository, or as a set of "git format-patch"-
    style patches against a GStreamer release or a snapshot of a GStreamer git
    repository. The patches should ideally say what was changed and why it
    was changed, and there should ideally be separate patches for independent
    changes.
  * You must provide a way for users of your application to make changes to
    the LGPL-licensed parts of the code, and re-create a full application
    binary with the changes (using the standard toolchain and tools of the
    target platform; if you are using a custom toolchain or custom tools
    you must provide these and document how to use them to create a new
    application binary).
    Note that this of course does not mean that the user is allowed to
    re-distribute the changed application. Nor does it mean that you have
    to provide your proprietary source code - it is sufficient to provide a
    ready-made compiled object file that can be relinked into an application
    binary with the re-compiled LGPL components.
   V. THINGS TO LOOK OUT FOR
While most GStreamer plugins and the libraries they depend on are licensed
under the LGPL or even more permissive licenses, that is not the case for
all plugins and libraries used, esp. those in the gst-plugins-ugly or
some of those in the gst-plugins-bad set of plugins.
When statically linking proprietary code, care must be taken not to
statically link plugins or libraries that are licensed under less permissive
terms than the LGPL, such as e.g. GPL-licensed libraries.
   VI. SPECIAL CONSIDERATIONS FOR SPECIFIC USE-CASES
   1. Proprietary GStreamer/GLib-based Application On iOS
Let's assume an individual or a company wants to distribute a proprietary
iOS application that is built on top of GStreamer and GLib through
Apple's App Store. At the time of writing the Apple iPhone developer
agreement didn’t allow the bundling of shared libraries, so distributing
a proprietary iOS application with shared libraries is only possible using
distribution mechanisms outside of the App Store and/or only to jailbroken
devices, a prospect that may not appeal to our individual or company. So the
only alternative then is to link everything statically, which means the
obligations mentioned above come into play.
   2. Example: Jabber on iOS
Tandberg (now Cisco) created a Jabber application for iOS, based on GStreamer.
On request they provided an LGPL compliance bundle in form of a zip file, with
roughly the following contents:
buildapp.sh
readme.txt
Jabber/Jabber-Info.plist
Jabber/libip.a [236MB binary with proprietary code]
Jabber/main.mm
Jabber/xcconfig/Application.xcconfig
Jabber/xcconfig/Debug.xcconfig
Jabber/xcconfig/Release.xcconfig
Jabber/xcconfig/Shared.xcconfig
Jabber/Resources/*.lproj/Localizable.strings
Jabber/Resources/{Images,Audio,Sounds,IB,Message Styles,Emoticons,Fonts}/*
Jabber/Resources/*
Jabber.xcodeproj/project.pbxproj
Jabber.xcodeproj/project.xcworkspace/contents.xcworkspacedata
opensource/build/config.site
opensource/build/m4/movi.m4
opensource/build/scripts/clean-deps.sh
opensource/build/scripts/fixup-makefile.sh
opensource/build/scripts/MoviMaker.py
opensource/build.sh
opensource/env.sh
opensource/Makefile
opensource/external/glib/*
opensource/external/gstreamer/{gstreamer,gst-plugins-*}/*
opensource/external/openssl/*
opensource/external/proxy-libintl/*
opensource/toolchain/darwin-x86/bin/{misc autotoools,m4,glib-mkenums,glib-genmarshal,libtool,pkg-config,etc.}
opensource/toolchain/darwin-x86/share/{aclocal,aclocal-1.11,autoconf,automake-1.11,libtool}/*
opensource/toolchain/darwin-x86/share/Config.pm
opensource/toolchain/darwin-x86/share/Config.pm.movi.in
patches/glib/glib.patch
patches/gst-plugins-bad/gst-plugins-bad.patch
patches/gst-plugins-base/gst-plugins-base.patch
patches/gst-plugins-good/gst-plugins-good.patch
patches/gstreamer/gstreamer.patch
patches/openssl/openssl.patch
readme.txt starts with "This Readme file describes how to build the Cisco 
Jabber for iPad application. You need to install Xcode, but the final package
is built by running buildapp.sh." and describes how to build project,
prerequisites, the procedure in detail, and a "How to Include Provisioning
Profile Manually / Alternate Code Signing Instructions" section.
   3. Random Links Which May Be Of Interest
[0] http://multinc.com/2009/08/24/compatibility-between-the-iphone-app-store-and-the-lgpl/