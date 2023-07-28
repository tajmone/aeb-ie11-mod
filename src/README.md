# AEB IE11 Mod Source Code

![AEB IE11 Mod Version][app badge]&nbsp;
[![PureBasic Version][PB badge]][PureBasic]&nbsp;
[![Activ E-Book Compiler version][AEB badge]][Activ E-Book Compiler]&nbsp;


This folder contains the [PureBasic] source code for building the **Activ E-Book Internet Explore 11 Mod** executable file (`aeb-ie11-mod.exe`), which will be generated in the [`../demo/html/`][html dir] folder.

- [`aeb-ie11-mod.pb`][aeb-ie11-mod.pb] — PureBasic source code.
- [`aeb-ie11-mod.pbp`][aeb-ie11-mod.pbp] — PureBasic IDE project settings.

-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="only_ascii" uri_encoding="true" levels="1,2,3" -->

- [Requirements](#requirements)
- [Building](#building)

<!-- /MarkdownTOC -->

-----

# Requirements

To build the **AEB IE11 Mod** binary from source you'll need to download and install PureBasic x86 (32-bit edition) version 6.

The reason we're compiling as a 32-bit application is because Activ E-Books are 32-bit applications, so we want to ensure that even users running a 32-bit MS Windows edition will be able to open the E-Book — which, of course, won't work if we built **AEB IE11 Mod** as a 64-bit application.

PureBasic is a commercial programming language that comes with a full IDE and various developer tools.

You _probably_ might be able to build **AEB IE11 Mod** using the free demo version of PureBasic which, [according to the documentation], ships with the following limitations:

> The demo-version of PureBasic is limited as shown below:
>
> - No DLL can be created
> - you can't use the whole external Win32 API support
> - no development kit for external libraries
> - maximum number of source lines: 800

**AEB IE11 Mod** does use the Win32 API, so I'm not sure whether it can be compiled with the demo version or not, since I haven't tried it.

Also, bear in mind that only the latest release of PureBasic is available as free demo; therefore, if newer versions of the language introduced breaking changes, the source code won't compile without manual fixing. As a licensed users, on the other hand, you may download every version of PureBasic that was ever released, so you could just install the same version which I used, and ensure that it will compile out of the box.


# Building

Once you've installed PureBasic, double click on the `aeb-ie11-mod.pbp` project file, which should automatically be opened by the PureBasic IDE (editor). The project file already contains all the required compiler settings, so you only have to compile the app via the **Compiler** &gt; **Build all Targets** menu.

The binary output file (`aeb-ie11-mod.exe`) will be generated in [`../demo/html/`][html dir], instead of the current folder, because that's the HTML contents folder of the demo E-Book for testing the application:

- `../demo/html/aeb-ie11-mod.exe`

You can now copy the `aeb-ie11-mod.exe` executable and use it in your Activ E-Book projects.

> **NOTE** — You can open the project with either the 32-bit or 64-bit edition of the PureBasic IDE — it doesn't matter, as long as you've installed the 32-bit edition, since the project is set to use the 32-bit compiler, regardless of the IDE being used to open it.

<!-----------------------------------------------------------------------------
                               REFERENCE LINKS
------------------------------------------------------------------------------>

[according to the documentation]: https://www.purebasic.com/documentation/mainguide/order.html "PureBasic documentation about free demo version"

<!-- apps -->

[PureBasic]: https://www.purebasic.com "Visit PureBasic website"
[Activ E-Book Compiler]: http://www.ebookcompiler.com  "Visit Activ E-Book Compiler website"

<!-- badges -->

[app badge]: https://img.shields.io/badge/AEB_IE11_Mod-1.0.0-yellow "Current Activ E-Book Internet Explorer 11 Mod version"
[PB badge]: https://img.shields.io/badge/PureBasic-6.02_x86-yellow
[AEB badge]: https://img.shields.io/badge/Activ_E--Book_Compiler-4.22_Plus-yellow

<!-- files & folders -->

[aeb-ie11-mod.pb]: ./aeb-ie11-mod.pb "View PureBasic source file"
[aeb-ie11-mod.pbp]: ./aeb-ie11-mod.pbp "View PureBasic IDE project file"

[html dir]: ../demo/html/ "Navigate to compiler output folder"

<!-- EOF -->
