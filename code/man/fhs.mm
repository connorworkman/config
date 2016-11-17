.\" Process this file with
.\" groff -man -Tascii foo.1
.\"
.\" .TH FOO 1 "MARCH 1995" Linux "User Manuals"
.TH fhs 5 "2016-09-19" "2.2" "Filesystem Hierarchy Standard"
.SH NAME
FHS - Filesystem Hierarchy Standard
.\" .SH NAME
.\" foo \- frobnicate the bar library
.SH SYNOPSIS
.ND "\*[Date]"
.COVER ms
.TL
Filesystem Hierarchy Standard \(em Version 2.2 final
.AF "\fIedited by Rusty Russell and Daniel Quinlan\fP"
.AU "\fRFilesystem Hierarchy Standard Group\fP"
.COVEND
.SH DESCRIPTION
.AS 0 5
.nh
.P 1
This standard consists of a set of requirements and guidelines for file
and directory placement under \*(Ux-like operating systems.  The
guidelines are intended to support interoperability of applications,
system administration tools, development tools, and scripts as well as
greater uniformity of documentation for these systems.
.AE
.BL
.LI
.\" -------------------------------------------------------------------
.\".SH "Introduction"
.LE
.P
.\" I would like to end up with these sub-sections in the introduction:
.\" (moving some things from general to here)
.\"
.\" Statement of General purpose (or is that the abstract?)
.\"
.\" - Organization
.\" - Base Documents, if any
.\" - Background (History)
.\" - Audience
.\" - Purpose (Objectives)
.\"   - basic principles (possible to have read-only /usr, etc.)
.\"     including: broadly implementable, minimal changes to historic
.\"     implementations, minimal changes to existing implementations
.\" - Related Standards
.\" -------------------------------------------------------------------
.SS "Purpose"
.P
This standard enables
.BL
.LI
Software to predict the location of installed files and directories, and
.LI
Users to predict the location of installed files and directories.
.LE
.P
We do this by
.BL
.LI
Specifying guiding principles for each area of the filesystem,
.LI
Specifying the minimum files and directories required,
.LI
Enumerating exceptions to the principles, and
.LI
Enumerating specific cases where there has been historical conflict.
.LE
.P
The FHS document is used by
.BL
.LI
Independent software suppliers to create applications which are FHS
compliant, and work with distributions which are FHS complaint,
.LI
OS creators to provide systems which are FHS compliant, and
.LI
Users to understand and maintain the FHS compliance of a system.
.LE
.\" -------------------------------------------------------------------
.SS "Conventions"
.P
.ie t \{\
A constant-width font is used for displaying the names of files and
directories.
\}
.el \{\
We recommend that you read a typeset version of this document rather
than the plain text version.  In the typeset version, the names of files
and directories are displayed in a constant-width font.
\}
.P
Components of filenames that vary are represented by a description of
the contents enclosed in "\f(CW<\fP" and "\f(CW>\fP" characters,
\f(CW<thus>\fP.  Electronic mail addresses are also enclosed in "<" and
">" but are shown in the usual typeface.
.P
Optional components of filenames are enclosed in "\f(CW[\fP" and
"\f(CW]\fP" characters and may be combined with the "\f(CW<\fP" and
"\f(CW>\fP" convention.  For example, if a filename is allowed to occur
either with or without an extension, it might be represented by
\f(CW<filename>[.<extension>]\fP.
.P
Variable substrings of directory names and filenames are indicated by
"\f(CW*\fP".
.\" -------------------------------------------------------------------
.SS "The Filesystem"
.P
This standard assumes that the operating system underlying an
\*(Fs-compliant file system supports the same basic security features
found in most \*(Ux filesystems.
.P
It is possible to define two independent categories of files: shareable
vs. unshareable and variable vs. static.  There should be a simple and
easily understandable mapping from directories to the type of data they contain: directories
may be mount points for other filesystems with different characteristics
from the filesystem on which they are mounted.
.\" categories/categorizations and files/file-data
.P
Shareable data is that which can be shared between several different
hosts; unshareable is that which must be specific to a particular host.
For example, user home directories are shareable data, but device lock
files are not.
.P
Static data includes binaries, libraries, documentation, and anything
that does not change without system administrator intervention; variable
data is anything else that does change without system administrator
intervention.
.StartRationale
The distinction between shareable and unshareable data is needed for
several reasons:
.BL
.LI
In a networked environment (i.e., more than one host at a site), there
is a good deal of data that can be shared between different hosts to
save space and ease the task of maintenance.
.LI
In a networked environment, certain files contain information specific
to a single host.  Therefore these filesystems cannot be shared
(without taking special measures).
.LI
Historical implementations of \*(Ux-like filesystems interspersed
shareable and unshareable data in the same hierarchy, making it
difficult to share large portions of the filesystem.
.LE
.P
The "shareable" distinction can be used to support, for example:
.BL
.LI
A \f(CW/usr\fP partition (or components of \f(CW/usr\fP) mounted
(read-only) through the network (using NFS).
.LI
A \f(CW/usr\fP partition (or components of \f(CW/usr\fP) mounted from
read-only media.  A CD-ROM is one copy of many identical ones
distributed to other users by the postal mail system and other methods.
It can thus be regarded as a read-only filesystem shared with other
\*(Fs-compliant systems by some kind of "network".
.LE
.P
The "static" versus "variable" distinction affects the filesystem in two
major ways:
.BL
.LI
Since \f(CW/\fP contains both variable and static data, it needs to be mounted
read-write.
.LI
Since the traditional \f(CW/usr\fP contains both variable and static data, and
since we may want to mount it read-only (see above), it is necessary to
provide a method to have \f(CW/usr\fP mounted read-only.  This is done through
the creation of a \f(CW/var\fP hierarchy that is mounted read-write (or is a
part of another read-write partition, such as \f(CW/)\fP, taking over much of
the \f(CW/usr\fP partition's traditional functionality.
.LE
.P
Here is a summarizing chart.  This chart is only an example for a common
\*(Fs-compliant system, other chart layouts are possible within
\*(Fs-compliance.
.\" XXX - this was:
.\" Here is a summarizing chart.  Since this chart contains generalized
.\" examples, it may not apply to every possible implementation of
.\" an \*(Fs-compliant system.
.TS
box,center;
l | l | 1.
	shareable	unshareable
_
static	/usr	/etc
	/opt	/boot
_
variable	/var/mail	/var/run
	/var/spool/news	/var/lock
.TE

.EndRationale
.LE
.P
.\" -------------------------------------------------------------------
.SH "The Root Filesystem"
.LE
.P
.\" XXX - bernd says: The usage of `root' is heavily overloaded.  Maybe
.\" `root directory' and `root partition' should be replaced by `main
.\" directory', `boot partition', etc.
.SS "Purpose"
The contents of the root filesystem must be adequate to boot, restore,
recover, and/or repair the system.
.BL
.LI
To boot a system, enough must be present on the root partition to mount
other filesystems.  This includes utilities, configuration, boot loader
information, and other essential start-up data.  \f(CW/usr\fP,
\f(CW/opt\fP, and \f(CW/var\fP are designed such that they may be
located on other partitions or filesystems.
.LI
To enable recovery and/or repair of a system, those utilities needed by
an experienced maintainer to diagnose and reconstruct a damaged system
must be present on the root filesystem.
.LI
To restore a system, those utilities needed to restore from system
backups (on floppy, tape, etc.) must be present on the root
filesystem.
.LE
.\" -------------------------------------------------------------------
.StartRationale
.P
The primary concern used to balance these considerations, which favor
placing many things on the root filesystem, is the goal of keeping
root as small as reasonably possible.  For several reasons, it is
desirable to keep the root filesystem small:
.BL
.LI
It is occasionally mounted from very small media.
.LI
The root filesystem contains many system-specific configuration files.
Possible examples include a kernel that is specific to the system, a
specific hostname, etc.  This means that the root filesystem isn't
always shareable between networked systems.  Keeping it small on servers
in networked systems minimizes the amount of lost space for areas of
unshareable files.  It also allows workstations with smaller local hard
drives.
.LI
While you may have the root filesystem on a large partition, and may be
able to fill it to your heart's content, there will be people with
smaller partitions.  If you have more files installed, you may find
incompatibilities with other systems using root filesystems on smaller
partitions.  If you are a developer then you may be turning your
assumption into a problem for a large number of users.
.LI
Disk errors that corrupt data on the root filesystem are a greater
problem than errors on any other partition.  A small root filesystem is
less prone to corruption as the result of a system crash.
.LE
.P
Software must never create or require special files or subdirectories
in the root directory.  Other locations in the \*(Fs hierarchy provide
more than enough flexibility for any package.
.P
There are several reasons why introducing a new subdirectory of the root
filesystem is prohibited:
.BL
.LI
It demands space on a root partition which the system administrator may
want kept small and simple for either performance or security reasons.
.LI
It evades whatever discipline the system administrator may have set up
for distributing standard file hierarchies across mountable volumes.
.LE
.EndRationale
.\" -------------------------------------------------------------------
.SS "Requirements"
The following directories, or symbolic links to directories, are required in \f(CW/\fP.
.PS
copy "dirgraph.pic"
dir("/","the root directory")
sub("bin","Essential command binaries")
sub("boot","Static files of the boot loader")
sub("dev","Device files")
sub("etc","Host-specific system configuration")
sub("lib","Essential shared libraries and kernel modules")
sub("mnt","Mount point for mounting a filesystem temporarily")
sub("opt","Add-on application software packages")
sub("sbin","Essential system binaries")
sub("tmp","Temporary files")
sub("usr","Secondary hierarchy")
sub("var","Variable data")
.PE
.P
Each directory listed above is specified in detail in separate
subsections below.  \f(CW/usr\fP and \f(CW/var\fP each have a complete
section in this document due to the complexity of those directories.

.SS "Specific Options"
The following directories, or symbolic links to directories, must be in \f(CW/\fP, if the corresponding
subsystem is installed:
.PS
copy "dirgraph.pic"
dir("/","the root directory")
sub("home","User home directories (optional)")
sub("lib<qual>","Alternate format essential shared libraries (optional)")
sub("root","Home directory for the root user (optional)")
.PE
.P
Each directory listed above is specified in detail in separate
subsections below.

.\" -------------------------------------------------------------------
.SH "/bin : Essential user command binaries (for use by all users)"
.LI
.LE
.P
.BL
.SS "Purpose"
\f(CW/bin\fP contains commands that may be used by both the system
administrator and by users, but which are required when no other
filesystems are mounted (e.g. in single user mode).  It may also contain
commands which are used indirectly by scripts.\*F
.FS
Command binaries that are not essential enough to place into
\f(CW/bin\fP must be placed in \f(CW/usr/bin\fP, instead.  Items that
are required only by non-root users (the X Window System, \f(CWchsh\fP,
etc.) are generally not essential enough to be placed into the root
partition.
.FE
.SS "Requirements"
There must be no subdirectories in \f(CW/bin\fP.
.P
The following commands, or symbolic links to commands, are required in \f(CW/bin\fP.
.TS
tab(@);
lfCW l.
cat@Utility to concatenate files to standard output
chgrp@Utility to change file group ownership
chmod@Utility to change file access permissions
chown@Utility to change file owner and group
cp@Utility to copy files and directories
date@Utility to print or set the system data and time
dd@Utility to convert and copy a file
df@Utility to report filesystem disk space usage
dmesg@Utility to print or control the kernel message buffer
echo@Utility to display a line of text
false@Utility to do nothing, unsuccessfully
hostname@Utility to show or set the system's host name
kill@Utility to send signals to processes
ln@Utility to make links between files
login@Utility to begin a session on the system
ls@Utility to list directory contents
mkdir@Utility to make directories
mknod@Utility to make block or character special files
more@Utility to page through text
mount@Utility to mount a filesystem
mv@Utility to move/rename files
ps@Utility to report process status
pwd@Utility to print name of current working directory
rm@Utility to remove files or directories
rmdir@Utility to remove empty directories
sed@The `sed' stream editor
sh@The Bourne command shell
stty@Utility to change and print terminal line settings
su@Utility to change user ID
sync@Utility to flush filesystem buffers
true@Utility to do nothing, successfully
umount@Utility to unmount file systems
uname@Utility to print system information
.TE
.P
If \f(CW/bin/sh\fP is not a true Bourne shell, it must be a hard or
symbolic link to the real shell command.
.P
The \f(CW[\fP and \f(CWtest\fP commands must be placed together in
either \f(CW/bin\fP or \f(CW/usr/bin\fP.
.StartRationale
For example bash behaves differently when called as \f(CWsh\fP or
\f(CWbash\fP.  The use of a symbolic link also allows users to easily
see that \f(CW/bin/sh\fP is not a true Bourne shell.
.P
The requirement for the \f(CW[\fP and \f(CWtest\fP commands to be
included as binaries (even if implemented internally by the shell) is shared with the POSIX.2 standard.
.EndRationale
.SS "Specific Options"
The following programs, or symbolic links to programs, must be in \f(CW/bin\fP if the corresponding
subsystem is installed:
.TS
tab(@);
lfCW l.
csh@The C shell (optional)
ed@The `ed' editor (optional)
tar@The tar archiving utility (optional)
cpio@The cpio archiving utility (optional)
gzip@The GNU compression utility (optional)
gunzip@The GNU uncompression utility (optional)
zcat@The GNU uncompression utility (optional)
netstat@The network statistics utility (optional)
ping@The ICMP network test utility (optional)
.TE
.P
If the gunzip and zcat programs exist, they must be symbolic or hard
links to gzip. \f(CW/bin/csh\fP may be a symbolic link to
\f(CW/bin/tcsh\fP or \f(CW/usr/bin/tcsh\fP.
.StartRationale
The tar, gzip and cpio commands have been added to make restoration of a
system possible (provided that \f(CW/\fP is intact).
.P
Conversely, if no restoration from the root partition is ever expected,
then these binaries might be omitted (e.g., a ROM chip root, mounting
\f(CW/usr\fP through NFS).  If restoration of a system is planned
through the network, then \f(CWftp\fP or \f(CWtftp\fP (along with
everything necessary to get an ftp connection) must be available on
the root partition.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/boot : Static files of the boot loader"
.LI
.LE
.P
.LI
.P
.SS "Purpose"
This directory contains everything required for the boot process except
configuration files and the map installer.  Thus \f(CW/boot\fP stores
data that is used before the kernel begins executing user-mode
programs.  This may include saved master boot sectors, sector map files,
and other data that is not directly edited by hand.\*F
.FS
Programs necessary to arrange for the boot loader to be able to
boot a file must be placed in \f(CW/sbin\fP.  Configuration files for
boot loaders must be placed in \f(CW/etc\fP.
.FE
.P
.SS "Specific Options"
The operating system kernel must be located in either \f(CW/\fP or
\f(CW/boot\fP.\*F
.FS
On some i386 machines, it may be necessary for \f(CW/boot\fP to be
located on a separate partition located completely below cylinder 1024
of the boot device due to hardware constraints.
.P
Certain MIPS systems require a \f(CW/boot\fP partition that is a mounted
MS-DOS filesystem or whatever other filesystem type is accessible for
the firmware.  This may result in restrictions with respect to usable
filenames within \f(CW/boot\fP (only for affected systems).
.FE
.\" -------------------------------------------------------------------
.SH "/dev : Device files"
.LI
.LE
.P
.P
.SS "Purpose"
The \f(CW/dev\fP directory is the location of special or device files.
.P
.SS "Specific Options"
.P
If it is possible that devices in \f(CW/dev\fP will need to be manually
created, \f(CW/dev\fP must contain a command named \f(CWMAKEDEV\fP,
which can create devices as needed.  It may also contain a
\f(CWMAKEDEV.local\fP for any local devices.
.P
If required, \f(CWMAKEDEV\fP must have provisions for creating any
device that may be found on the system, not just those that a particular
implementation installs.
.\" -------------------------------------------------------------------
.SH "/etc : Host-specific system configuration"
.LI
.LE
.P
.P
.SS "Purpose"
\f(CW/etc\fP contains configuration files and directories that are
specific to the current system.\*F
.FS
The setup of command scripts invoked at boot time may resemble
System V, BSD or other models.  Further specification in this area
may be added to a future version of this standard.
.FE
.P
.SS "Requirements"
No binaries may be located under \f(CW/etc\fP.
.P
The following directories, or symbolic links to directories are required in \f(CW/etc\fP:
.PS
copy "dirgraph.pic"
dir("/etc","Host-specific system configuration")
sub("opt","Configuration for /opt")
.PE
.SS "Specific Options"
.P
The following directories, or symbolic links to directories must be in \f(CW/etc\fP, if the corresponding
subsystem is installed:
.PS
copy "dirgraph.pic"
dir("/etc","Host-specific system configuration")
sub("X11","Configuration for the X Window System (optional)")
sub("sgml","Configuration for SGML and XML (optional)")
.PE
The following files, or symbolic links to files, must be in \f(CW/etc\fP if the corresponding
subsystem is installed:\*F
.TS
tab(@);
lfCW l.
csh.login@Systemwide initialization file for C shell logins (optional)
exports@NFS filesystem access control list (optional)
fstab@Static information about filesystems (optional)
ftpusers@FTP daemon user access control list (optional)
gateways@File which lists gateways for routed (optional)
gettydefs@Speed and terminal settings used by getty (optional)
group@User group file (optional)
host.conf@Resolver configuration file (optional)
hosts@Static information about host names (optional)
hosts.allow@Host access file for TCP wrappers (optional)
hosts.deny@Host access file for TCP wrappers (optional)
hosts.equiv@List of trusted hosts for rlogin, rsh, rcp (optional)
hosts.lpd@List of trusted hosts for lpd (optional)
inetd.conf@Configuration file for inetd (optional)
inittab@Configuration file for init (optional)
issue@Pre-login message and identification file (optional)
ld.so.conf@List of extra directories to search for shared libraries (optional)
motd@Post-login message of the day file (optional)
mtab@Dynamic information about filesystems (optional)
mtools.conf@Configuration file for mtools (optional)
networks@Static information about network names (optional)
passwd@The password file (optional)
printcap@The lpd printer capability database (optional)
profile@Systemwide initialization file for sh shell logins (optional)
protocols@IP protocol listing (optional)
resolv.conf@Resolver configuration file (optional)
rpc@RPC protocol listing (optional)
securetty@TTY access control for root login (optional)
services@Port names for network services (optional)
shells@Pathnames of valid login shells (optional)
syslog.conf@Configuration file for syslogd (optional)
.TE
.FS
Systems that use the shadow password suite will have additional
configuration files in \f(CW/etc\fP (\f(CW/etc/shadow\fP and others) and
programs in \f(CW/usr/sbin\fP (\f(CWuseradd\fP, \f(CWusermod\fP, and
others).
.FE
.P
mtab does not fit the static nature of \f(CW/etc\fP: it is excepted for
historical reasons.\*F
.FS
On some Linux systems, this may be a symbolic link to
\f(CW/proc/mounts\fP, in which case this exception is not required.
.FE
.\" -------------------------------------------------------------------
.SH "/etc/opt : Configuration files for /opt"
.LI
.LE
.P
.P
.SS "Purpose"
Host-specific configuration files for add-on application software
packages must be installed within the directory
\f(CW/etc/opt/<package>\fP, where \f(CW<package>\fP is the name of the
subtree in \f(CW/opt\fP where the static data from that package is
stored.
.SS "Requirements"
No structure is imposed on the internal arrangement of
\f(CW/etc/opt/<package>\fP.
.P
If a configuration file must reside in a different location in order for
the package or system to function properly, it may be placed in a
location other than \f(CW/etc/opt/<package>\fP.
.\" -------------------------------------------------------------------
.StartRationale
Refer to the rationale for \f(CW/opt\fP.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/10000000000etc/X11 : Configuration for the X Window System (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
\f(CW/etc/X11\fP is the location for all X11 host-specific
configuration.  This directory is necessary to allow local control if
\f(CW/usr\fP is mounted read only.
.SS "Specific Options"
The following files, or symbolic links to files, must be in \f(CW/etc/X11\fP if the corresponding
subsystem is installed:
.TS
tab(@);
lfCW l.
Xconfig@The configuration file for early versions of XFree86 (optional)
XF86Config@The configuration file for XFree86 versions 3 and 4 (optional)
Xmodmap@Global X11 keyboard modification file (optional)
.TE
.P
Subdirectories of \f(CW/etc/X11\fP may include those for \f(CWxdm\fP and
for any other programs (some window managers, for example) that need
them.\*F
.FS
\f(CW/etc/X11/xdm\fP holds the configuration files for \f(CWxdm\fP.
These are most of the files previously found in \f(CW/usr/lib/X11/xdm\fP.
Some local variable data for \f(CWxdm\fP is stored in
\f(CW/var/lib/xdm\fP.
.FE
We recommend that window managers with only one configuration
file which is a default \f(CW.*wmrc\fP file must name it
\f(CWsystem.*wmrc\fP (unless there is a widely-accepted alternative
name) and not use a subdirectory.  Any window manager subdirectories
must be identically named to the actual window manager binary.
.P
.\" -------------------------------------------------------------------
.SH "/etc/sgml : Configuration files for SGML and XML (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
Generic configuration files defining high-level parameters of the SGML
or XML systems are installed here.  Files with names \f(CW*.conf\fP
indicate generic configuration files.  File with names \f(CW*.cat\fP are
the DTD-specific centralized catalogs, containing references to all
other catalogs needed to use the given DTD.  The super catalog file
\f(CWcatalog\fP references all the centralized catalogs.
.\" -------------------------------------------------------------------
.SH "/home : User home directories (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
\f(CW/home\fP is a fairly standard concept, but it is clearly a
site-specific filesystem.\*F
.FS
Different people prefer to place user accounts in a variety of places.
This section describes only a suggested placement for user home
directories; nevertheless we recommend that all \*(Fs-compliant
distributions use this as the default location for home directories.
.P
On small systems, each user's directory is typically one of the many
subdirectories of \f(CW/home\fP such as \f(CW/home/smith\fP,
\f(CW/home/torvalds\fP, \f(CW/home/operator\fP, etc.
On large systems (especially when the \f(CW/home\fP directories are
shared amongst many hosts using NFS) it is useful to subdivide user home
directories.  Subdivision may be accomplished by using subdirectories
such as \f(CW/home/staff\fP, \f(CW/home/guests\fP,
\f(CW/home/students\fP, etc.
.FE
The setup will differ from host to host.
Therefore, no program should rely on this location.\*F
.FS
If you want to find out a user's home directory, you should use the
\f(CWgetpwent(3)\fP library function rather than relying on
\f(CW/etc/passwd\fP because user information may be stored remotely
using systems such as NIS.
.FE
.\" -------------------------------------------------------------------
.SH "/lib : Essential shared libraries and kernel modules"
.LI
.LE
.P
.P
.SS "Purpose"
The \f(CW/lib\fP directory contains those shared library images needed
to boot the system and run the commands in the root filesystem, ie. by
binaries in \f(CW/bin\fP and \f(CW/sbin\fP.\*F
.FS
Shared libraries that are only necessary for binaries in \f(CW/usr\fP
(such as any X Window binaries) must not be in \f(CW/lib\fP. Only
the shared libraries required to run binaries in \f(CW/bin\fP and
\f(CW/sbin\fP may be here.  In particular, the library \f(CWlibm.so.*\fP may also
be placed in \f(CW/usr/lib\fP if it is not required by anything in
\f(CW/bin\fP or \f(CW/sbin\fP.
.FE
.SS "Requirements"
At least one of each of the following filename patterns are required
(they may be files, or symbolic links):
.TS
tab(@);
lfCW l.
libc.so.*@The dynamically-linked C library (optional)
ld*@The execution time linker/loader (optional)
.TE
.P
If a C preprocessor is installed, \f(CW/lib/cpp\fP must be a reference
to it, for historical reasons.\*F
.FS
The usual placement of this binary is
\f(CW\%/usr/lib/gcc-lib/<target>/<version>/cpp\fP.  \f(CW/lib/cpp\fP can
either point at this binary, or at any other reference to this binary
which exists in the filesystem.  (For example, \f(CW/usr/bin/cpp\fP is
also often used.)
.FE
.SS "Specific Options"
The following directories, or symbolic links to directories, must be in \f(CW/lib\fP, if the corresponding
subsystem is installed:
.PS
copy "dirgraph.pic"
dir("/lib","essential shared libraries and kernel modules")
sub("modules","Loadable kernel modules (optional)")
.PE
.P
.\" .ft I
.\" Note: The specification for \f(CW/lib/modules\fP is forthcoming.
.\" .ft P
.\" -------------------------------------------------------------------
.SH "/lib<qual> : Alternate format essential shared libraries (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
There may be one or more variants of the \f(CW/lib\fP directory on
systems which support more than one binary format requiring separate
libraries.\*F
.FS
This is commonly used for 64-bit or 32-bit support on systems which
support multiple binary formats, but require libraries of the same name.
In this case, \f(CW/lib32\fP and \f(CW/lib64\fP might be the library
directories, and \f(CW/lib\fP a symlink to one of them.
.FE
.P
.SS "Requirements"
If one or more of these directories exist, the requirements for their
contents are the same as the normal \f(CW/lib\fP directory, except that
\f(CW/lib<qual>/cpp\fP is not required.\*F
.FS
\f(CW/lib<qual>/cpp\fP is still permitted: this allows the case where
\f(CW/lib\fP and \f(CW/lib<qual>\fP are the same (one is a symbolic link
to the other).
.FE
.\" -------------------------------------------------------------------
.SH "/mnt : Mount point for a temporarily mounted filesystem"
.LI
.LE
.P
.P
.SS "Purpose"
This directory is provided so that the system administrator may
temporarily mount a filesystem as needed.  The content of this directory
is a local issue and should not affect the manner in which any program
is run.
.P
This directory must not be used by installation programs: a suitable
temporary directory not in use by the system must be used instead.
.\" -------------------------------------------------------------------
.SH "/opt : Add-on application software packages"
.LI
.LE
.P
.SS "Purpose"
\f(CW/opt\fP is reserved for the installation of add-on application
software packages.
.P
A package to be installed in \f(CW/opt\fP must locate its static files
in a separate \f(CW/opt/<package>\fP directory tree, where
\f(CW<package>\fP is a name that describes the software package.
.P
.SS "Requirements"
.PS
copy "dirgraph.pic"
dir("/opt","Add-on application software packages")
sub("<package>","Static package objects")
.PE
The directories \f(CW/opt/bin\fP, \f(CW/opt/doc\fP,
\f(CW/opt/include\fP, \f(CW/opt/info\fP, \f(CW/opt/lib\fP, and
\f(CW/opt/man\fP are reserved for local system administrator use.
Packages may provide "front-end" files intended to be placed in (by
linking or copying) these reserved directories by the local system
administrator, but must function normally in the absence of these
reserved directories.
.P
Programs to be invoked by users must be located in the directory
\f(CW/opt/<package>/bin\fP. If the package includes \*(Ux manual pages,
they must be located in \f(CW/opt/<package>/man\fP and the same
substructure as \f(CW/usr/share/man\fP must be used.
.P
Package files that are variable (change in normal operation) must be
installed in \f(CW/var/opt\fP.  See the section on \f(CW/var/opt\fP for
more information.
.P
Host-specific configuration files must be installed in
\f(CW/etc/opt\fP.  See the section on \f(CW/etc\fP for more information.
.P
No other package files may exist outside the \f(CW/opt\fP,
\f(CW/var/opt\fP, and \f(CW/etc/opt\fP hierarchies except for those
package files that must reside in specific locations within the
filesystem tree in order to function properly.  For example, device lock
files must be placed in \f(CW/var/lock\fP and devices must be located in
\f(CW/dev\fP.
.P
Distributions may install software in \f(CW/opt\fP, but must not
modify or delete software installed by the local system administrator
without the assent of the local system administrator.
.\" -------------------------------------------------------------------
.StartRationale
The use of \f(CW/opt\fP for add-on software is a well-established
practice in the \*(Ux community.  The System V Application Binary
Interface [AT&T 1990], based on the System V Interface Definition (Third
Edition), provides for an \f(CW/opt\fP structure very similar to the one
defined here.
.P
The Intel Binary Compatibility Standard v. 2 (iBCS2) also provides a
similar structure for \f(CW/opt\fP.
.P
Generally, all data required to support a package on a system must be
present within \f(CW/opt/<package>\fP, including files intended to be
copied into \f(CW/etc/opt/<package>\fP and \f(CW/var/opt/<package>\fP as
well as reserved directories in \f(CW/opt\fP.
.P
The minor restrictions on distributions using \f(CW/opt\fP are necessary
because conflicts are possible between distribution-installed and
locally-installed software, especially in the case of fixed pathnames
found in some binary software.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/root : Home directory for the root user (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
The root account's home directory may be determined by developer or
local preference, but this is the recommended default location.\*F
.FS
If the home directory of the root account is not stored on the root
partition it will be necessary to make certain it will default to
\f(CW/\fP if it can not be located.
.P
We recommend against using the root account for tasks that can be
performed as an unprivileged user, and that it be used solely for system
administration.  For this reason, we recommend that subdirectories for
mail and other applications not appear in the root account's home
directory, and that mail for administration roles such as root,
postmaster, and webmaster be forwarded to an appropriate user.
.FE
.\" -------------------------------------------------------------------
.SH "/sbin : System binaries"
.LI
.LE
.P
.P
.SS "Purpose"
Utilities used for system administration (and other root-only commands)
are stored in \f(CW/sbin\fP, \f(CW/usr/sbin\fP, and
\f(CW/usr/local/sbin\fP.  \f(CW/sbin\fP contains binaries essential for
booting, restoring, recovering, and/or repairing the system in addition
to the binaries in \f(CW/bin\fP.\*F
.FS
Originally, \f(CW/sbin\fP binaries were kept in \f(CW/etc\fP.
.FE
Programs executed after \f(CW/usr\fP is known to be mounted (when there
are no problems) are generally placed into \f(CW/usr/sbin\fP.
Locally-installed system administration programs should be placed into
\f(CW/usr/local/sbin\fP.\*F
.FS
Deciding what things go into \f(CW"sbin"\fP directories is simple: if a
normal (not a system administrator) user will ever run it directly, then
it must be placed in one of the \f(CW"bin"\fP directories.  Ordinary
users should not have to place any of the \f(CWsbin\fP directories in
their path.
.P
For example, files such as \f(CWchfn\fP which users only
occasionally use must still be placed in \f(CW/usr/bin\fP.
\f(CWping\fP, although it is absolutely necessary for root (network
recovery and diagnosis) is often used by users and must live in
\f(CW/bin\fP for that reason.
.P
We recommend that users have read and execute permission for everything
in \f(CW/sbin\fP except, perhaps, certain setuid and setgid programs.
The division between \f(CW/bin\fP and \f(CW/sbin\fP was not created for
security reasons or to prevent users from seeing the operating system,
but to provide a good partition between binaries that everyone uses and
ones that are primarily used for administration tasks.  There is no
inherent security advantage in making \f(CW/sbin\fP off-limits for
users.
.FE
.\" -------------------------------------------------------------------
.SS "Requirements"
The following commands, or symbolic links to commands, are required in \f(CW/sbin\fP.
.TS
tab(@);
lfCW l.
shutdown@Command to bring the system down.
.TE
.SS "Specific Options"
The following files, or symbolic links to files, must be in \f(CW/sbin\fP if the corresponding
subsystem is installed:
.TS
tab(@);
lfCW l.
fastboot@Reboot the system without checking the disks (optional)
fasthalt@Stop the system without checking the disks (optional)
fdisk@Partition table manipulator (optional)
fsck@File system check and repair utility (optional)
fsck.*@File system check and repair utility for a specific filesystem (optional)
getty@The getty program (optional)
halt@Command to stop the system (optional)
ifconfig@Configure a network interface (optional)
init@Initial process (optional)
mkfs@Command to build a filesystem (optional)
mkfs.*@Command to build a specific filesystem (optional)
mkswap@Command to set up a swap area (optional)
reboot@Command to reboot the system (optional)
route@IP routing table utility (optional)
swapon@Enable paging and swapping (optional)
swapoff@Disable paging and swapping (optional)
update@Daemon to periodically flush filesystem buffers (optional)
.TE
.\" -------------------------------------------------------------------
.SH "/tmp : Temporary files"
.LI
.LE
.P
.P
.SS "Purpose"
The \f(CW/tmp\fP directory must be made available for programs that
require temporary files.
.P
Programs must not assume that any files or directories in \f(CW/tmp\fP
are preserved between invocations of the program.
.\" -------------------------------------------------------------------
.StartRationale
IEEE standard P1003.2 (POSIX, part 2) makes requirements that are
similar to the above section.
.P
Although data stored in \f(CW/tmp\fP may be deleted in a site-specific
manner, it is recommended that files and directories located in
\f(CW/tmp\fP be deleted whenever the system is booted.
.P
\*(Fs added this recommendation
on the basis of historical precedent and common practice, but did not
make it a requirement because system administration is not within the
scope of this standard.
.EndRationale
.\" -------------------------------------------------------------------
.SS "The /usr Hierarchy"
.P
.SS "Purpose"
\f(CW/usr\fP is the second major section of the filesystem.
\f(CW/usr\fP is shareable, read-only data.  That means that \f(CW/usr\fP
should be shareable between various \*(Fs-compliant hosts and
must not be written to.  Any information that is host-specific or
varies with time is stored elsewhere.
.P
Large software packages must not use a direct subdirectory under the
\f(CW/usr\fP hierarchy.
.P
.SS "Requirements"
The following directories, or symbolic links to directories, are required in \f(CW/usr\fP.
.PS
copy "dirgraph.pic"
dir("/usr","Secondary Hierarchy")
sub("bin","Most user commands")
sub("include","Header files included by C programs")
sub("lib","Libraries")
sub("local","Local hierarchy (empty after main installation)")
sub("sbin","Non-vital system binaries")
sub("share","Architecture-independent data")
.PE
.SS "Specific Options"
.PS
copy "dirgraph.pic"
dir("/usr","Secondary Hierarchy")
sub("X11R6","X Window System, version 11 release 6 (optional)")
sub("games","Games and educational binaries (optional)")
sub("lib<qual>","Alternate Format Libraries (optional)")
sub("src","Source code (optional)")
.PE
An exception is made for the X Window System because of considerable
precedent and widely-accepted practice.
.P
The following symbolic links to directories may be present. This
possibility is based on the need to preserve compatibility with older
systems until all implementations can be assumed to use the \f(CW/var\fP
hierarchy.
.P
.nf
.ft CW
    /usr/spool -> /var/spool
    /usr/tmp -> /var/tmp
    /usr/spool/locks -> /var/lock
.ft P
.fi
.P
Once a system no longer requires any one of the above symbolic links,
the link may be removed, if desired.
.\" -------------------------------------------------------------------
.SH "/usr/X11R6 : X Window System, Version 11 Release 6 (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
This hierarchy is reserved for the X Window System, version 11 release
6, and related files.
.P
To simplify matters and make XFree86 more compatible with the X Window
System on other systems, the following symbolic links must be present if
\f(CW/usr/X11R6\fP exists:
.P
.nf
.ft CW
    /usr/bin/X11 -> /usr/X11R6/bin
    /usr/lib/X11 -> /usr/X11R6/lib/X11
    /usr/include/X11 -> /usr/X11R6/include/X11
.ft P
.fi
.P
In general, software must not be installed or managed via the above
symbolic links.  They are intended for utilization by users only.  The
difficulty is related to the release version of the X Window System \(em
in transitional periods, it is impossible to know what release of X11 is
in use.
.SS "Specific Options"
Host-specific data in \f(CW/usr/X11R6/lib/X11\fP should be interpreted
as a demonstration file.  Applications requiring information about the
current host must reference a configuration file in \f(CW/etc/X11\fP,
which may be linked to a file in \f(CW/usr/X11R6/lib\fP.\*F
.FS
Examples of such configuration files include \f(CWXconfig\fP,
\f(CWXF86Config\fP, or \f(CWsystem.twmrc\fP)
.FE
.P
.\" -------------------------------------------------------------------
.SH "/usr/bin : Most user commands"
.LI
.LE
.P
.P
.SS "Purpose"
This is the primary directory of executable commands on the system.
.SS "Specific Options"
The following directories, or symbolic links to directories, must be in \f(CW/usr/bin\fP, if the corresponding
subsystem is installed:
.PS
copy "dirgraph.pic"
dir("/usr/bin","Binaries that are not needed in single-user mode")
sub("mh","Commands for the MH mail handling system (optional)")
.PE
\f(CW/usr/bin/X11\fP must be a symlink to \f(CW/usr/X11R6/bin\fP if the
latter exists.
.P
The following files, or symbolic links to files, must be in \f(CW/usr/bin\fP, if the corresponding
subsystem is installed:
.TS
tab(@);
lfCW l.
perl@The Practical Extraction and Report Language (optional)
python@The Python interpreted language (optional)
tclsh@Simple shell containing Tcl interpreter (optional)
wish@Simple Tcl/Tk windowing shell (optional)
expect@Program for interactive dialog (optional)
.TE
.StartRationale
Because shell script interpreters (invoked with \f(CW#!<path>\fP on the
first line of a shell script) cannot rely on a path, it is advantageous
to standardize their locations.  The Bourne shell and C-shell
interpreters are already fixed in \f(CW/bin\fP, but Perl, Python, and
Tcl are often found in many different places.  They may be symlinks to
the physical location of the shell interpreters.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/usr/include : Directory for standard include files."
.LI
.LE
.P
.P
.SS "Purpose"
This is where all of the system's general-use include files for the C
programming language should be placed.
.SS "Specific Options"
The following directories, or symbolic links to directories, must be in \f(CW/usr/include\fP, if the corresponding
subsystem is installed:
.PS
copy "dirgraph.pic"
dir("/usr/include","Include files")
sub("bsd","BSD compatibility include files (optional)")
.PE
The symbolic link \f(CW/usr/include/X11\fP must link to
\f(CW/usr/X11R6/include/X11\fP if the latter exists.
.\" -------------------------------------------------------------------
.SH "/usr/lib : Libraries for programming and packages"
.LI
.LE
.P
.P
.SS "Purpose"
\f(CW/usr/lib\fP includes object files, libraries, and internal binaries
that are not intended to be executed directly by users or shell scripts.\*F
.FS
Miscellaneous architecture-independent application-specific static files
and subdirectories must be placed in \f(CW/usr/share\fP.
.FE
.P
Applications may use a single subdirectory under \f(CW/usr/lib\fP.  If
an application uses a subdirectory, all architecture-dependent data
exclusively used by the application must be placed within that
subdirectory.\*F
.FS
For example, the \f(CWperl5\fP subdirectory for Perl 5 modules and
libraries.
.FE
.P
.SS "Specific Options"
.P
For historical reasons, \f(CW/usr/lib/sendmail\fP must be a symbolic
link to \f(CW/usr/sbin/sendmail\fP if the latter exists.\*F
.FS
Some executable commands such as \f(CWmakewhatis\fP and \f(CWsendmail\fP
have also been traditionally placed in \f(CW/usr/lib\fP.
\f(CWmakewhatis\fP is an internal binary and must be placed in a
binary directory; users access only \f(CWcatman\fP.  Newer
\f(CWsendmail\fP binaries are now placed by default in
\f(CW/usr/sbin\fP.  Additionally, systems using a
\f(CWsendmail\fP-compatible mail transfer agent must provide
\f(CW/usr/sbin/sendmail\fP as a symbolic link to the appropriate
executable.
.FE
.P
If \f(CW/lib/X11\fP exists, \f(CW/usr/lib/X11\fP must be a symbolic link
to \f(CW/lib/X11\fP, or to whatever \f(CW/lib/X11\fP is a symbolic link
to.\*F
.\" XXX - Chris deleted this.  Maybe pare it down to a sentence???
.\"
.FS
Host-specific data for the X Window System must not be stored in
\f(CW/usr/lib/X11\fP.  Host-specific configuration files such as
\f(CWXconfig\fP or \f(CWXF86Config\fP must be stored in
\f(CW/etc/X11\fP.  This includes configuration data such as
\f(CWsystem.twmrc\fP even if it is only made a symbolic link to a more
global configuration file (probably in \f(CW/usr/X11R6/lib/X11\fP).
.\" we might want to specify locations for fonts and font information
.FE
.\" -------------------------------------------------------------------
.SH "/usr/lib<qual> : Alternate format libraries (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
\f(CW/usr/lib<qual>\fP performs the same role as \f(CW/usr/lib\fP for an
alternate binary format, except that the symbolic links
\f(CW/usr/lib<qual>/sendmail\fP and \f(CW/usr/lib<qual>/X11\fP are not required.\*F
.FS
The case where \f(CW/usr/lib\fP and \f(CW/usr/lib<qual>\fP are the
same (one is a symbolic link to the other) these files and the
per-application subdirectories will exist.
.FE
.\" -------------------------------------------------------------------
.SH "/usr/local : Local hierarchy"
.LI
.LE
.P
.P
.SS "Purpose"
The \f(CW/usr/local\fP hierarchy is for use by the system administrator
when installing software locally.  It needs to be safe from being
overwritten when the system software is updated.  It may be used for
programs and data that are shareable amongst a group of hosts, but not
found in \f(CW/usr\fP.
.P
Locally installed software must be placed within \f(CW/usr/local\fP
rather than \f(CW/usr\fP unless it is being installed to replace or
upgrade software in \f(CW/usr\fP.\*F
.FS
Software placed in \f(CW/\fP or \f(CW/usr\fP may be
overwritten by system upgrades (though we recommend that distributions
do not overwrite data in \f(CW/etc\fP under these circumstances).  For
this reason, local software must not be placed outside of
\f(CW/usr/local\fP without good reason.
.FE
.SS "Requirements"
The following directories, or symbolic links to directories, must be in \f(CW/usr/local\fP
.PS
copy "dirgraph.pic"
dir("/usr/local","Local hierarchy")
sub("bin","Local binaries")
sub("games","Local game binaries")
sub("include","Local C header files")
sub("lib","Local libraries")
sub("man","Local online manuals")
sub("sbin","Local system binaries")
sub("share","Local architecture-independent hierarchy")
sub("src","Local source code")
.PE
.P
No other directories, except those listed below, may be in
\f(CW/usr/local\fP after first installing a \*(Fs-compliant system.
.SS "Specific Options"
If directories \f(CW/lib<qual>\fP or \f(CW/usr/lib<qual>\fP exist, the
equivalent directories must also exist in \f(CW/usr/local\fP.
.\" -------------------------------------------------------------------
.SH "/usr/sbin : Non-essential standard system binaries"
.LI
.LE
.P
.P
.SS "Purpose"
This directory contains any non-essential binaries used exclusively by
the system administrator.  System administration programs that are
required for system repair, system recovery, mounting \f(CW/usr\fP, or
other essential functions must be placed in \f(CW/sbin\fP instead.\*F
.FS
Locally installed system administration programs should be placed in
\f(CW/usr/local/sbin\fP.
.FE
.\" -------------------------------------------------------------------
.SH "/usr/share : Architecture-independent data"
.LI
.LE
.P
.SS "Purpose"
The \f(CW/usr/share\fP hierarchy is for all read-only architecture
independent data files.\*F
.FS
Much of this data originally lived in \f(CW/usr\fP (\f(CWman\fP,
\f(CWdoc\fP) or \f(CW/usr/lib\fP (\f(CWdict\fP, \f(CWterminfo\fP,
\f(CWzoneinfo\fP).
.FE
.P
This hierarchy is intended to be shareable among all architecture
platforms of a given OS; thus, for example, a site with i386, Alpha, and
PPC platforms might maintain a single \f(CW/usr/share\fP directory that
is centrally-mounted.  Note, however, that \f(CW/usr/share\fP is
generally not intended to be shared by different OSes or by different
releases of the same OS.
.P
Any program or package which contains or requires data that doesn't need
to be modified should store that data in \f(CW/usr/share\fP (or
\f(CW/usr/local/share\fP, if installed locally).  It is recommended that a
subdirectory be used in \f(CW/usr/share\fP for this purpose.
.P
Game data stored in \f(CW/usr/share/games\fP must be purely static data.
Any modifiable files, such as score files, game play logs, and so forth,
should be placed in \f(CW/var/games\fP.
.P
.SS "Requirements"
The following directories, or symbolic links to directories, must be in \f(CW/usr/share\fP
.PS
copy "dirgraph.pic"
dir("/usr/share","Architecture-independent data")
sub("man","Online manuals")
sub("misc","Miscellaneous architecture-independent data")
.PE
.SS "Specific Options"
The following directories, or symbolic links to directories, must be in \f(CW/usr/share\fP, if the corresponding
subsystem is installed:
.PS
copy "dirgraph.pic"
dir("/usr/share","Architecture-independent data")
sub("dict","Word lists (optional)")
sub("doc","Miscellaneous documentation (optional)")
sub("games","Static data files for \f(CW/usr/games\fP (optional)")
sub("info","GNU Info system's primary directory (optional)")
sub("locale","Locale information (optional)")
sub("nls","Message catalogs for Native language support (optional)")
sub("sgml","SGML and XML data (optional)")
sub("terminfo","Directories for terminfo database (optional)")
sub("tmac","troff macros not distributed with groff (optional)")
sub("zoneinfo","Timezone information and configuration (optional)")
.PE
.P
It is recommended that application-specific, architecture-independent
directories be placed here.  Such directories include \f(CWgroff\fP,
\f(CWperl\fP, \f(CWghostscript\fP, \f(CWtexmf\fP, and
\f(CWkbd\fP (Linux) or \f(CWsyscons\fP (BSD).  They may, however, be
placed in \f(CW/usr/lib\fP for backwards compatibility, at the
distributor's discretion.  Similarly, a \f(CW/usr/lib/games\fP
hierarchy may be used in addition to the \f(CW/usr/share/games\fP
hierarchy if the distributor wishes to place some game data there.
.\"
.\" Note: groff support files should be installed in /usr/share/groff
.\" to simplify groff upgrading on Linux systems, rather than the
.\" distribution of groff files found on current BSD systems.
.\" -------------------------------------------------------------------
.SH "/usr/share/dict : Word lists (optional)"
.LI
.LE
.P
.\" -------------------------------------------------------------------
.SS "Purpose"
This directory is the home for word lists on the system;
Traditionally this directory contains only the English \f(CWwords\fP
file, which is used by \f(CWlook(1)\fP and various spelling programs.
\f(CWwords\fP may use either American or British spelling.
.\" -------------------------------------------------------------------
.StartRationale
The reason that only word lists are located here is that they are the
only files common to all spell checkers.
.EndRationale
.\" -------------------------------------------------------------------
.SS "Specific Options"
The following files, or symbolic links to files, must be in \f(CW/usr/share/dict\fP, if the corresponding
subsystem is installed:
.TS
tab(@);
lfCW l.
words@List of English words (optional)
.TE
.P
Sites that require both American and British spelling may link
\f(CWwords\fP to \f(CW\%/usr/share/dict/american-english\fP or
\f(CW\%/usr/share/dict/british-english\fP.
.P
Word lists for other languages may be added using the English name for
that language, e.g., \f(CW/usr/share/dict/french\fP,
\f(CW/usr/share/dict/danish\fP, etc.  These should, if possible, use an
ISO 8859 character set which is appropriate for the language in
question; if possible the Latin1 (ISO 8859-1) character set should be
used (this is often not possible).
.P
Other word lists must be included here, if present.
.\" -------------------------------------------------------------------
.SH "/usr/share/man : Manual pages"
.LI
.LE
.P
.P
.SS "Purpose"
This section details the organization for manual pages throughout the
system, including \f(CW/usr/share/man\fP.  Also refer to the section on
\f(CW/var/cache/man\fP.
.P
The primary \f(CW<mandir>\fP of the system is \f(CW/usr/share/man\fP.
\f(CW/usr/share/man\fP contains manual information for commands and data under
the \f(CW/\fP and \f(CW/usr\fP filesystems.\*F
.FS
Obviously, there are no manual pages in \f(CW/\fP because they are
not required at boot time nor are they required in emergencies.\*F
.FE
.FS
Really.
.FE
.P
Manual pages are stored in \f(CW<mandir>/<locale>/man<section>/<arch>\fP.
An explanation of \f(CW<mandir>\fP, \f(CW<locale>\fP, \f(CW<section>\fP,
and \f(CW<arch>\fP is given below.
.P
A description of each section follows:
.BL
.LI
\f(CWman1\fP: User programs
.br
Manual pages that describe publicly accessible commands are contained in
this chapter.  Most program documentation that a user will need to use
is located here.
.LI
\f(CWman2\fP: System calls
.br
This section describes all of the system calls (requests for the
kernel to perform operations).
.\" delete parenthesized remark?  assume technical background?
.LI
\f(CWman3\fP: Library functions and subroutines
.br
Section 3 describes program library routines that are not direct calls
to kernel services.  This and chapter 2 are only really of interest to
programmers.
.LI
\f(CWman4\fP: Special files
.br
Section 4 describes the special files, related driver functions, and
networking support available in the system.  Typically, this includes
the device files found in \f(CW/dev\fP and the kernel interface to
networking protocol support.
.LI
\f(CWman5\fP: File formats
.br
The formats for many data files are documented in the
section 5.  This includes various include files, program output files,
and system files.
.LI
\f(CWman6\fP: Games
.br
This chapter documents games, demos, and generally trivial programs.
Different people have various notions about how essential this is.
.LI
\f(CWman7\fP: Miscellaneous
.br
Manual pages that are difficult to classify are designated as being
section 7.  The troff and other text processing macro packages are found
here.
.LI
\f(CWman8\fP: System administration
.br
Programs used by system administrators for system operation and
maintenance are documented here.  Some of these programs are also
occasionally useful for normal users.
.LE
.SS "Specific Options"
The following directories, or symbolic links to directories, must be in
\f(CW/usr/share/<mandir>/<locale>\fP, unless they are empty:\*F
.FS
For example, if \f(CW/usr/local/man\fP has no manual pages in
section 4 (Devices), then \f(CW/usr/local/man/man4\fP may be
omitted.
.FE
.PS
copy "dirgraph.pic"
dir("<mandir>/<locale>","A manual page hierarchy")
sub("man1","User programs (optional)")
sub("man2","System calls (optional)")
sub("man3","Library calls (optional)")
sub("man4","Special files (optional)")
sub("man5","File formats (optional)")
sub("man6","Games (optional)")
sub("man7","Miscellaneous (optional)")
sub("man8","System administration (optional)")
.PE
.P
The component \f(CW<section>\fP describes the manual section.
.P
Provisions must be made in the structure of \f(CW/usr/share/man\fP to support
manual pages which are written in different (or multiple) languages.
These provisions must take into account the storage and reference of
these manual pages.  Relevant factors include language (including
geographical-based differences), and character code set.
.P
This naming of language subdirectories of \f(CW/usr/share/man\fP is based on
Appendix E of the POSIX 1003.1 standard which describes the locale
identification string \(em the most well-accepted method to describe a
cultural environment.  The \f(CW<locale>\fP string is:
.P 1
\f(CW<language>[_<territory>][.<character-set>][,<version>]\fP
.P
The \f(CW<language>\fP field must be taken from ISO 639 (a code for the
representation of names of languages).  It must be two characters wide
and specified with lowercase letters only.
.P
The \f(CW<territory>\fP field must be the two-letter code of ISO 3166
(a specification of representations of countries), if possible.  (Most
people are familiar with the two-letter codes used for the country codes
in email addresses.\*F) It must be two characters wide and specified
with uppercase letters only.
.FS
A major exception to this rule is the United Kingdom, which is `GB' in
the ISO 3166, but `UK' for most email addresses.
.FE
.P
The \f(CW<character-set>\fP field must represent the standard
describing the character set.  If the \f(CW\%<character-set>\fP field is
just a numeric specification, the number represents the number of the
international standard describing the character set.  It is recommended
that this be a numeric representation if possible (ISO standards,
especially), not include additional punctuation symbols, and that any
letters be in lowercase.
.P
A parameter specifying a \f(CW<version>\fP of the profile may be placed
after the \f(CW\%<character-set>\fP field, delimited by a comma.  This
may be used to discriminate between different cultural needs; for
instance, dictionary order versus a more systems-oriented collating
order.  This standard recommends not using the \f(CW<version>\fP field,
unless it is necessary.
.P
Systems which use a unique language and code set for all manual pages
may omit the \f(CW<locale>\fP substring and store all manual pages in
\f(CW<mandir>\fP.  For example, systems which only have English manual
pages coded with ASCII, may store manual pages (the
\f(CWman<section>\fP directories) directly in \f(CW/usr/share/man\fP.
(That is the traditional circumstance and arrangement, in fact.)
.P
Countries for which there is a well-accepted standard character code set
may omit the \f(CW\%<character-set>\fP field, but it is strongly
recommended that it be included, especially for countries with several
competing standards.
.P
Various examples:
.TS
l l l l
l l l lfCW.
Language	Territory	Character Set	Directory
_
English	\(em	ASCII	/usr/share/man/en
English	United Kingdom	ASCII	/usr/share/man/en_GB
English	United States	ASCII	/usr/share/man/en_US
French	Canada	ISO 8859-1	/usr/share/man/fr_CA
French	France	ISO 8859-1	/usr/share/man/fr_FR
German	Germany	ISO 646	/usr/share/man/de_DE.646
German	Germany	ISO 6937	/usr/share/man/de_DE.6937
German	Germany	ISO 8859-1	/usr/share/man/de_DE.88591
German	Switzerland	ISO 646	/usr/share/man/de_CH.646
Japanese	Japan	JIS	/usr/share/man/ja_JP.jis
Japanese	Japan	SJIS	/usr/share/man/ja_JP.sjis
Japanese	Japan	UJIS (or EUC-J)	/usr/share/man/ja_JP.ujis
.TE
.P
Similarly, provision must be made for manual pages which are
architecture-dependent, such as documentation on device-drivers or
low-level system administration commands.  These must be placed under an
\f(CW<arch>\fP directory in the appropriate \f(CWman<section>\fP directory;
for example, a man page for the i386 ctrlaltdel(8) command might be
placed in \f(CW/usr/share/man/<locale>/man8/i386/ctrlaltdel.8\fP.
.P
Manual pages for commands and data under \f(CW/usr/local\fP are stored
in \f(CW/usr/local/man\fP.  Manual pages for X11R6 are
stored in \f(CW/usr/X11R6/man\fP.  It follows that all manual page
hierarchies in the system must have the same structure as
\f(CW/usr/share/man\fP.
.\" -------------------------------------------------------------------
.P
The cat page sections (\f(CWcat<section>\fP) containing formatted manual
page entries are also found within subdirectories of
\f(CW<mandir>/<locale>\fP, but are not required nor may they be
distributed in lieu of nroff source manual pages.
.\" other subdirectories, ps<section>, dvi<section>, html<section> may
.\" be here eventually
.\" revise
.P
The numbered sections "1" through "8" are traditionally defined.  In
general, the file name for manual pages located within a particular
section end with \f(CW.<section>\fP.
.P
In addition, some large sets of application-specific manual pages have
an additional suffix appended to the manual page filename.  For example,
the MH mail handling system manual pages must have \f(CWmh\fP appended
to all MH manuals.  All X Window System manual pages must have an
\f(CWx\fP appended to the filename.
.P
The practice of placing various language manual pages in appropriate
subdirectories of \f(CW/usr/share/man\fP also applies to the other manual page
hierarchies, such as \f(CW/usr/local/man\fP and \f(CW/usr/X11R6/man\fP.
(This portion of the standard also applies later in the section on the
optional \f(CW/var/cache/man\fP structure.)
.P
.\" -------------------------------------------------------------------
.SH "/usr/share/misc : Miscellaneous architecture-independent data"
.LI
.LE
.P
.P
This directory contains miscellaneous architecture-independent files
which don't require a separate subdirectory under \f(CW/usr/share\fP.
.P
.SS "Specific Options"
The following files, or symbolic links to files, must be in \f(CW/usr/share/misc\fP, if the corresponding
subsystem is installed:
.TS
tab(@);
lfCW l.
ascii@ASCII character set table (optional)
magic@Default list of magic numbers for the file command (optional)
termcap@Terminal capability database (optional)
termcap.db@Terminal capability database (optional)
.TE
.P
Other (application-specific) files may appear here,\*F but a distributor
may place them in \f(CW/usr/lib\fP at their discretion.
.FS
Some such files include:
.VL 2
.LI "\f(CW{"
airport, birthtoken, eqnchar, getopt, gprof.callg, gprof.flat,
inter.phone, ipfw.samp.filters, ipfw.samp.scripts, keycap.pcvt, mail.help,
mail.tildehelp, man.template, map3270, mdoc.template, more.help, na.phone,
nslookup.help, operator, scsi_modes, sendmail.hf, style, units.lib,
vgrindefs, vgrindefs.db, zipcodes }\fP
.LE
.FE
.\" -------------------------------------------------------------------
.SH "/usr/share/sgml : SGML and XML data (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
\f(CW/usr/share/sgml\fP contains architecture-independent files used by
SGML or XML applications, such as ordinary catalogs (not the centralized
ones, see \f(CW/etc/sgml\fP), DTDs, entities, or style sheets.
.SS "Specific Options"
The following directories, or symbolic links to directories, must be in \f(CW/usr/share/sgml\fP, if the
corresponding subsystem is installed:
.PS
copy "dirgraph.pic"
dir("/usr/share/sgml","SGML and XML data")
sub("docbook","docbook DTD (optional)")
sub("tei","tei DTD (optional)")
sub("html","html DTD (optional)")
sub("mathml","mathml DTD (optional)")
.PE
Other files that are not specific to a given DTD may reside in their own
subdirectory.
.\" -------------------------------------------------------------------
.SH "/usr/src : Source code (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
Any non-local source code should be placed in this subdirectory.
.\" -------------------------------------------------------------------
.SS "The /var Hierarchy"
.SS "Purpose"
.P
\f(CW/var\fP contains variable data files.  This includes spool
directories and files, administrative and logging data, and transient
and temporary files.
.P
Some portions of \f(CW/var\fP are not shareable between different
systems.  For instance, \f(CW/var/log\fP, \f(CW/var/lock\fP, and
\f(CW/var/run\fP.  Other portions may be shared, notably
\f(CW/var/mail\fP, \f(CW/var/cache/man\fP, \f(CW/var/cache/fonts\fP,
and \f(CW/var/spool/news\fP.
.P
\f(CW/var\fP is specified here in order to make it possible to mount
\f(CW/usr\fP read-only.  Everything that once went into \f(CW/usr\fP
that is written to during system operation (as opposed to installation
and software maintenance) must be in \f(CW/var\fP.
.P
If \f(CW/var\fP cannot be made a separate partition, it is often
preferable to move \f(CW/var\fP out of the root partition and into the
\f(CW/usr\fP partition.  (This is sometimes done to reduce the size of
the root partition or when space runs low in the root partition.)
However, \f(CW/var\fP must not be linked to \f(CW/usr\fP because this
makes separation of \f(CW/usr\fP and \f(CW/var\fP more difficult and is
likely to create a naming conflict.  Instead, link \f(CW/var\fP to
\f(CW/usr/var\fP.
.P
Applications must generally not add directories to the top level of
\f(CW/var\fP.  Such directories should only be added if they have some
system-wide implication, and in consultation with the \*(Fs mailing list.
.SS "Requirements"
The following directories, or symbolic links to directories, are required in \f(CW/var\fP.
.PS
copy "dirgraph.pic"
dir("/var","Variable data")
sub("cache","Application cache data")
sub("lib","Variable state information")
sub("local","Variable data for /usr/local")
sub("lock","Lock files")
sub("log","Log files and directories")
sub("opt","Variable data for /opt")
sub("run","Data relevant to running processes")
sub("spool","Application spool data")
sub("tmp","Temporary files preserved between system reboots")
.PE
.P
Several directories are `reserved' in the sense that they must not be
used arbitrarily by some new application, since they would conflict
with historical and/or local practice.  They are:
.P
.nf
.ft CW
    /var/backups
    /var/cron
    /var/msgs
    /var/preserve
.ft P
.fi
.P
.SS "Specific Options"
The following directories, or symbolic links to directories, must be in \f(CW/var\fP, if the
corresponding subsystem is installed:
.PS
copy "dirgraph.pic"
dir("/var","Variable data")
sub("account","Process accounting logs (optional)")
sub("crash","System crash dumps (optional)")
sub("games","Variable game data (optional)")
sub("mail","User mailbox files (optional)")
sub("yp","Network Information Service (NIS) database files (optional)")
.PE
.\" -------------------------------------------------------------------
.SH "/var/account : Process accounting logs (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
This directory holds the current active process accounting log and the
composite process usage data (as used in some \*(Ux-like systems by
\f(CWlastcomm\fP and \f(CWsa\fP).
.\" -------------------------------------------------------------------
.SH "/var/cache : Application cache data"
.LI
.LE
.P
.SS "Purpose"
\f(CW/var/cache\fP is intended for cached data from applications.  Such
data is locally generated as a result of time-consuming I/O or
calculation.  The application must be able to regenerate or restore the
data.  Unlike \f(CW/var/spool\fP, the cached files can be deleted
without data loss.  The data must remain valid between invocations of
the application and rebooting the system.
.P
Files located under \f(CW/var/cache\fP may be expired in an application
specific manner, by the system administrator, or both.  The application
must always be able to recover from manual deletion of these files
(generally because of a disk space shortage).  No other requirements are
made on the data format of the cache directories.
.P
.\" -------------------------------------------------------------------
.StartRationale
The existence of a separate directory for cached data allows system
administrators to set different disk and backup policies from other
directories in \f(CW/var\fP.
.EndRationale
.\" -------------------------------------------------------------------
.P
.SS "Specific Options"
.PS
copy "dirgraph.pic"
dir("/var/cache","Cache directories")
sub("fonts","Locally-generated fonts (optional)")
sub("man","Locally-formatted manual pages (optional)")
sub("www","WWW proxy or cache data (optional)")
sub("<package>","Package specific cache data (optional)")
.PE
.P
.SH "/var/cache/fonts : Locally-generated fonts (optional)"
.LI
.LE
.P
.SS "Purpose"
.P
The directory \f(CW/var/cache/fonts\fP should be used to store any
dynamically-created fonts.  In particular, all of the fonts which are
automatically generated by \f(CWmktexpk\fP must be located in
appropriately-named subdirectories of \f(CW/var/cache/fonts\fP.\*F
.FS
This standard does not currently incorporate the \*(Tx Directory
Structure (a document that describes the layout \*(Tx files and
directories), but it may be useful reading.  It is located at
\f(CWftp://ctan.tug.org/tex/\fP.
.FE
.SS "Specific Options"
Other dynamically created fonts may also be placed in this tree, under
appropriately-named subdirectories of \f(CW/var/cache/fonts\fP.
.\" -------------------------------------------------------------------
.SH "/var/cache/man : Locally-formatted manual pages (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
This directory provides a standard location for sites that provide a
read-only \f(CW/usr\fP partition, but wish to allow caching of
locally-formatted man pages.  Sites that mount \f(CW/usr\fP as writable
(e.g., single-user installations) may choose not to use
\f(CW/var/cache/man\fP and may write formatted man pages into the
\f(CWcat<section>\fP directories in \f(CW/usr/share/man\fP directly.  We
recommend that most sites use one of the following options instead:
.BL
.LI
Preformat all manual pages alongside the unformatted versions.
.LI
Allow no caching of formatted man pages, and require formatting to be
done each time a man page is brought up.
.LI
Allow local caching of formatted man pages in \f(CW/var/cache/man\fP.
.LE
.P
The structure of \f(CW/var/cache/man\fP needs to reflect both the fact of
multiple man page hierarchies and the possibility of multiple language
support.
.P
Given an unformatted manual page that normally appears in
\f(CW<path>/man/<locale>/man<section>\fP, the directory to place formatted
man pages in is \f(CW/var/cache/man/<catpath>/<locale>/cat<section>\fP,
where \f(CW<catpath>\fP is derived from \f(CW<path>\fP by removing any
leading \f(CWusr\fP and/or trailing \f(CWshare\fP pathname components.\*F
(Note that the \f(CW<locale>\fP component may be missing.)
.\" Note that /usr/local/man and /local/man will conflict, if some
.\" system administrator is flakey enough to use both for different things.
.FS
For example, \f(CW/usr/share/man/man1/ls.1\fP is
formatted into \f(CW/var/cache/man/cat1/ls.1\fP, and
\f(CW/usr/X11R6/man/<locale>/man3/XtClass.3x\fP into
\f(CW/var/cache/man/X11R6/<locale>/cat3/XtClass.3x\fP.
.FE
.P
Man pages written to \f(CW/var/cache/man\fP may eventually be
transferred to the appropriate preformatted directories in the source
\f(CWman\fP hierarchy or expired; likewise
formatted man pages in the source \f(CWman\fP hierarchy may be expired if
they are not accessed for a period of time.
.P
If preformatted manual pages come with a system on read-only media
(a CD-ROM, for instance), they must be installed in the source
\f(CWman\fP hierarchy (e.g. \f(CW/usr/share/man/cat<section>\fP).
\f(CW/var/cache/man\fP is reserved as a writable cache for formatted
manual pages.
.\" -------------------------------------------------------------------
.StartRationale
Release 1.2 of the standard specified \f(CW/var/catman\fP for this
hierarchy.  The path has been moved under \f(CW/var/cache\fP to better
reflect the dynamic nature of the formatted man pages.  The directory
name has been changed to \f(CWman\fP to allow for enhancing the hierarchy
to include post-processed formats other than "cat", such as PostScript,
HTML, or DVI.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/var/crash : System crash dumps (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
This directory holds system crash dumps.  As of the date of this release
of the standard, system crash dumps were not supported under Linux.
.\" -------------------------------------------------------------------
.SH "/var/games : Variable game data (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
Any variable data relating to games in \f(CW/usr\fP should be placed
here.  \f(CW/var/games\fP should hold the variable data previously found
in \f(CW/usr\fP; static data, such as help text, level descriptions, and
so on, must remain elsewhere, such as \f(CW/usr/share/games\fP.
.\" XXX: deprecate /var/games in favor of /var/lib
.\" -------------------------------------------------------------------
.StartRationale
\f(CW/var/games\fP has been given a hierarchy of its own, rather
than leaving it merged in with the old \f(CW/var/lib\fP as in release
1.2.  The separation allows local control of backup strategies,
permissions, and disk usage, as well as allowing inter-host sharing
and reducing clutter in \f(CW/var/lib\fP.  Additionally, \f(CW/var/games\fP
is the path traditionally used by BSD.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/var/lib : Variable state information"
.LI
.LE
.P
.SS "Purpose"
.P
This hierarchy holds state information pertaining to an application or
the system.  State information is data that programs modify while they
run, and that pertains to one specific host.  Users must never need
to modify files in \f(CW/var/lib\fP to configure a package's operation.
.P
State information is generally used to preserve the condition of an
application (or a group of inter-related applications) between
invocations and between different instances of the same application.
State information should generally remain valid after a reboot,
.\" (but note that emacs/lock is an exception to this),
should not be logging output, and should not be spooled data.
.P
An application (or a group of inter-related applications) must
use a subdirectory of \f(CW/var/lib\fP for its data.\*F  There is one
required subdirectory, \f(CW/var/lib/misc\fP, which is intended for
state files that don't need a subdirectory; the other subdirectories
should only be present if the application in question is included in
the distribution.
.FS
An important difference between this version of this standard and
previous ones is that applications are now required to use a
subdirectory of \f(CW/var/lib\fP.
.FE
.P
\f(CW/var/lib/<name>\fP is the location that must be used for all
distribution packaging support.  Different distributions may use
different names, of course.
.P
.SS "Requirements"
The following directories, or symbolic links to directories, are required in \f(CW/var/lib\fP:
.PS
copy "dirgraph.pic"
dir("/var/lib","Variable state information")
sub("misc","Miscellaneous state data")
.PE
.SS "Specific Options"
The following directories, or symbolic links to directories, must be in \f(CW/var/lib\fP, if the
corresponding subsystem is installed:
.PS
copy "dirgraph.pic"
dir("/var/lib","Variable state information")
sub("<editor>","Editor backup files and state (optional)")
sub("<pkgtool>","Packaging support files (optional)")
sub("<package>","State data for packages and subsystems (optional)")
sub("hwclock","State directory for hwclock (optional)")
sub("xdm","X display manager variable data (optional)")
.PE
.\" -------------------------------------------------------------------
.SH "/var/lib/<editor> : Editor backup files and state (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
These directories contain saved files generated by any unexpected
termination of an editor (e.g., elvis, jove, nvi).
.P
Other editors may not require a directory for crash-recovery files, but
may require a well-defined place to store other information while the
editor is running.  This information should be stored in a subdirectory
under \f(CW/var/lib\fP (for example, GNU Emacs would place lock files
in \f(CW/var/lib/emacs/lock\fP).
.P
Future editors may require additional state information beyond
crash-recovery files and lock files \(em this information should also be
placed under \f(CW/var/lib/<editor>\fP.
.\" -------------------------------------------------------------------
.StartRationale
Previous Linux releases, as well as all commercial vendors, use
\f(CW/var/preserve\fP for vi or its clones.  However, each editor uses
its own format for these crash-recovery files, so a separate directory
is needed for each editor.
.P
Editor-specific lock files are usually quite different from the device
or resource lock files that are stored in \f(CW/var/lock\fP and, hence,
are stored under \f(CW/var/lib\fP.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/var/lib/hwclock : State directory for hwclock (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
This directory contains the file \f(CW/var/lib/hwclock/adjtime\fP.
.\" -------------------------------------------------------------------
.StartRationale
In \*(Fs 2.1, this file was \f(CW/etc/adjtime\fP, but as \f(CWhwclock\fP
updates it, that was obviously incorrect.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/var/lib/misc : Miscellaneous variable data"
.LI
.LE
.P
.P
.SS "Purpose"
This directory contains variable data not placed in a subdirectory in
\f(CW/var/lib\fP.  An attempt should be made to use relatively unique
names in this directory to avoid namespace conflicts.\*F
.FS
This hierarchy should contain files stored in \f(CW/var/db\fP
in current BSD releases.  These include \f(CWlocate.database\fP and
\f(CWmountdtab\fP, and the kernel symbol database(s).
.FE
.\" -------------------------------------------------------------------
.SH "/var/lock : Lock files"
.LI
.LE
.P
.P
.SS "Purpose"
Lock files should be stored within the \f(CW/var/lock\fP directory structure.
.P
Lock files for devices and other resources shared by multiple applications, such as the serial device lock files that were
originally found in either \f(CW/usr/spool/locks\fP or
\f(CW/usr/spool/uucp\fP, must now be stored in \f(CW/var/lock\fP.  The
naming convention which must be used is
.ie t \{\
\f(CWLCK..\fP followed by the base name of the device file.  For example, to
lock \f(CW/dev/ttyS0\fP the file \f(CWLCK..ttyS0\fP would be created.
\}
.el \{\
"LCK.." followed by the base name of the device.  For example, to lock
/dev/ttyS0 the file "LCK..ttyS0" would be created.
\}
\*F
.FS
Then, anything wishing to use \f(CW/dev/ttyS0\fP can read the lock file
and act accordingly (all locks in \f(CW/var/lock\fP should be
world-readable).
.FE
.P
The format used for the contents of such lock files must be the HDB UUCP lock
file format.  The HDB format is to store the process identifier (PID) as
a ten byte ASCII decimal number, with a trailing newline.  For
example, if process 1230 holds a lock file, it would contain the eleven
characters: space, space, space, space, space, space, one, two, three,
zero, and newline.
.\" Some versions of UUCP add a second line indicating which program created
.\" the lock (uucp, cu, or getty).
.\" -------------------------------------------------------------------
.SH "/var/log : Log files and directories"
.LI
.LE
.P
.P
.SS "Purpose"
This directory contains miscellaneous log files.  Most logs must be
written to this directory or an appropriate subdirectory.
.SS "Specific Options"
The following files, or symbolic links to files, must be in \f(CW/var/log\fP, if the
corresponding subsystem is installed:
.TS
tab(@);
lfCW l.
lastlog@record of last login of each user
messages@system messages from \f(CWsyslogd\fP
wtmp@record of all logins and logouts
.TE
.\" -------------------------------------------------------------------
.SH "/var/mail : User mailbox files (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
The mail spool must be accessible through \f(CW/var/mail\fP and the mail
spool files must take the form \f(CW<username>\fP.\*F
.FS
Note that \f(CW/var/mail\fP
may be a symbolic link to another directory.
.FE
.P
User mailbox files in this location must be stored in the standard
\*(Ux mailbox format.
.\" -------------------------------------------------------------------
.StartRationale
The logical location for this directory was changed from
\f(CW/var/spool/mail\fP in order to bring \*(Fs in-line with nearly
every \*(Ux implementation.  This change is important for
inter-operability since a single \f(CW/var/mail\fP is often shared
between multiple hosts and multiple \*(Ux implementations (despite NFS
locking issues).
.P
It is important to note that there is no requirement to physically move
the mail spool to this location.  However, programs and header files
must be changed to use \f(CW/var/mail\fP.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/var/opt : Variable data for /opt"
.LI
.LE
.P
.P
.SS "Purpose"
Variable data of the packages in \f(CW/opt\fP must be installed in
\f(CW/var/opt/<package>\fP, where \f(CW<package>\fP is the name of the
subtree in \f(CW/opt\fP where the static data from an add-on software
package is stored, except where superseded by another file in
\f(CW/etc\fP.  No structure is imposed on the internal arrangement of
\f(CW/var/opt/<package>\fP.
.\" -------------------------------------------------------------------
.StartRationale
Refer to the rationale for \f(CW/opt\fP.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/var/run : Run-time variable data"
.LI
.LE
.P
.P
.SS "Purpose"
This directory contains system information data describing the system
since it was booted.  Files under this directory must be cleared
(removed or truncated as appropriate) at the beginning of the boot
process.  Programs may have a subdirectory of \f(CW/var/run\fP; this is
encouraged for programs that use more than one run-time file.\*F
.FS
\f(CW/var/run\fP should be unwritable for unprivileged users (root or
users running daemons); it is a major security problem if any user can
write in this directory.
.FE
Process identifier (PID) files, which were originally placed in
\f(CW/etc\fP, must be placed in \f(CW/var/run\fP.  The naming
convention for PID files is \f(CW<program-name>.pid\fP.  For example,
the \f(CWcrond\fP PID file is named \f(CW/var/run/crond.pid\fP.
.P
.SS "Requirements"
.P
The internal format of PID files remains unchanged.  The file must
consist of the process identifier in ASCII-encoded decimal,
followed by a newline character.  For example, if \f(CWcrond\fP was
process number 25, \f(CW/var/run/crond.pid\fP would contain three
characters: two, five, and newline.
.P
Programs that read PID files should be somewhat flexible in what they
accept; i.e., they should ignore extra whitespace, leading zeroes,
absence of the trailing newline, or additional lines in the PID file.
Programs that create PID files should use the simple specification
located in the above paragraph.
.P
The \f(CWutmp\fP file, which stores information about who is currently
using the system, is located in this directory.
.P
Programs that maintain transient \*(Ux-domain sockets must place them
in this directory.
.\" -------------------------------------------------------------------
.SH "/var/spool : Application spool data"
.LI
.LE
.P
.SS "Purpose"
\f(CW/var/spool\fP contains data which is awaiting some kind of later
processing.  Data in \f(CW/var/spool\fP represents work to be done in
the future (by a program, user, or administrator); often data is deleted
after it has been processed.\*F
.ig
\f(CW/var/spool\fP is intended for `spooled' data from applications.
Such data remains valid even if the application that created it aborts
and restarts.  Some time after being created, the data is automatically
removed, in an application-specific manner; this is typically when some
event occurs (e.g., lpd prints the file, or sendmail sends it) or a time
limit expires (e.g. a news article).  Data in \f(CW/var/spool\fP is
generally of interest to the user in and of itself, unlike data in
\f(CW/var/lib\fP, which is generally of interest only indirectly.
..
.FS
UUCP lock files must be placed in \f(CW/var/lock\fP.  See the above
section on \f(CW/var/lock\fP.
.FE
.SS "Specific Options"
The following directories, or symbolic links to directories, must be in \f(CW/var/spool\fP, if the
corresponding subsystem is installed:
.PS
copy "dirgraph.pic"
dir("/var/spool","Spool directories")
sub("lpd","Printer spool directory (optional)")
sub("mqueue","Outgoing mail queue (optional)")
sub("news","News spool directory (optional)")
sub("rwho","Rwhod files (optional)")
sub("uucp","Spool directory for UUCP (optional)")
.PE
.P
.\" -------------------------------------------------------------------
.SH "/var/spool/lpd : Line-printer daemon print queues (optional)"
.LI
.LE
.P
.SS "Purpose"
.P
The lock file for \f(CWlpd\fP, \f(CWlpd.lock\fP, must be placed in
\f(CW/var/spool/lpd\fP.  It is suggested that the lock file for each
printer be placed in the spool directory for that specific printer and
named \f(CWlock\fP.
.SS "Specific Options"
.PS
copy "dirgraph.pic"
dir("/var/spool/lpd","Printer spool directory")
sub("<printer>","Spools for a specific printer (optional)")
.PE
.\" -------------------------------------------------------------------
.SH "/var/spool/rwho : Rwhod files (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
This directory holds the \f(CWrwhod\fP information for other systems on
the local net.
.\" -------------------------------------------------------------------
.StartRationale
Some BSD releases use \f(CW/var/rwho\fP for this data; given its
historical location in \f(CW/var/spool\fP on other systems and its
approximate fit to the definition of `spooled' data, this location was
deemed more appropriate.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/var/tmp : Temporary files preserved between system reboots"
.LI
.LE
.P
.P
.SS "Purpose"
The \f(CW/var/tmp\fP directory is made available for programs that require
temporary files or directories that are preserved between system reboots.
Therefore, data stored in \f(CW/var/tmp\fP is more persistent than data
in \f(CW/tmp\fP.
.P
Files and directories located in \f(CW/var/tmp\fP must not be deleted
when the system is booted.  Although data stored in \f(CW/var/tmp\fP
is typically deleted in a site-specific manner, it is recommended that
deletions occur at a less frequent interval than \f(CW/tmp\fP.
.ig
A symbolic link \f(CW/var/tmp/vi.recover\fP to \f(CW/var/lib/nvi\fP
is allowed to support versions of nvi compiled without the path name
suggested in the standard.

Programs must not assume that any files or directories are preserved
between invocations of the program.
..
.\" XXX - Why did the second paragraph get commented out?
.\" -------------------------------------------------------------------
.SH "/var/yp : Network Information Service (NIS) database files (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
Variable data for the Network Information Service (NIS), formerly known
as the Sun Yellow Pages (YP), must be placed in this directory.
.\" -------------------------------------------------------------------
.StartRationale
\f(CW/var/yp\fP is the standard directory for NIS (YP) data and is
almost exclusively used in NIS documentation and systems.\*F
.EndRationale
.FS
NIS should not be confused with Sun NIS+, which uses a different
directory, \f(CW/var/nis\fP.
.FE
.\" -------------------------------------------------------------------
.SS "Operating System Specific Annex"
.P
This section is for additional requirements and recommendations that
only apply to a specific operating system.  The material in this section
should never conflict with the base standard.
.\" -------------------------------------------------------------------
.SS "Linux"
.P
This is the annex for the Linux operating system.
.\" -------------------------------------------------------------------
.SH "/ : Root directory"
.LI
.LE
.P
.P
On Linux systems, if the kernel is located in \f(CW/\fP, we recommend
using the names \f(CWvmlinux\fP or \f(CWvmlinuz\fP, which have been used
in recent Linux kernel source packages.
.\" -------------------------------------------------------------------
.SH "/bin : Essential user command binaries (for use by all users)"
.LI
.LE
.P
.P
Linux systems which require them place these additional files into
\f(CW/bin\fP.
.VL 2
.LI "\f(CW{"
setserial }\fP
.LE
.P
.\" -------------------------------------------------------------------
.SH "/dev : Devices and special files"
.LI
.LE
.P
.P
All devices and special files in \f(CW/dev\fP should adhere to the
\fILinux Allocated Devices\fP document, which is available with the
Linux kernel source.  It is maintained by H. Peter Anvin
<hpa@zytor.com>.
.P
Symbolic links in \f(CW/dev\fP should not be distributed with Linux
systems except as provided in the \fILinux Allocated Devices\fP
document.
.\" -------------------------------------------------------------------
.StartRationale
The requirement not to make symlinks promiscuously is made because local
setups will often differ from that on the distributor's development
machine.  Also, if a distribution install script configures the symbolic
links at install time, these symlinks will often not get updated if
local changes are made in hardware.  When used responsibly at a local
level, however, they can be put to good use.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/etc : Host-specific system configuration"
.LI
.LE
.P
.P
Linux systems which require them place these additional files into
\f(CW/etc\fP.
.VL 2
.LI "\f(CW{"
lilo.conf }\fP
.LE
.P
\" -------------------------------------------------------------------
.SH "/proc : Kernel and process information virtual filesystem"
.LI
.LE
.P
.P
The \f(CWproc\fP filesystem is the de-facto standard Linux method for
handling process and system information, rather than \f(CW/dev/kmem\fP
and other similar methods.  We strongly encourage this for the storage
and retrieval of process information as well as other kernel and memory
information.
.\" -------------------------------------------------------------------
.SH "/sbin : Essential system binaries"
.LI
.LE
.P
.P
Linux systems place these additional files into \f(CW/sbin\fP.
.BL
.LI
Second extended filesystem commands (optional):
.VL 2
.LI "\f(CW{"
badblocks, dumpe2fs, e2fsck, mke2fs, mklost+found, tune2fs }\fP
.LE
.LI
Boot-loader map installer (optional):
.VL 2
.LI "\f(CW{"
lilo }\fP
.LE
.\" -------------------------------------------------------------------
.SH "Optional files for /sbin:"
.LI
.LE
.P
.BL
.LI
Static binaries:
.SP
.VL 2
.LI "\f(CW{"
ldconfig, sln, ssync }\fP
.LE
.P
Static \f(CWln\fP (\f(CWsln\fP) and static \f(CWsync\fP (\f(CWssync\fP)
are useful when things go wrong.  The primary use of \f(CWsln\fP (to
repair incorrect symlinks in \f(CW/lib\fP after a poorly orchestrated
upgrade) is no longer a major concern now that the \f(CWldconfig\fP
program (usually located in \f(CW/usr/sbin\fP) exists and can act as a
guiding hand in upgrading the dynamic libraries.  Static \f(CWsync\fP is
useful in some emergency situations.  Note that these need not be
statically linked versions of the standard \f(CWln\fP and \f(CWsync\fP,
but may be.
.P
The \f(CWldconfig\fP binary is optional for \f(CW/sbin\fP since a site
may choose to run \f(CWldconfig\fP at boot time, rather than only when
upgrading the shared libraries.  (It's not clear whether or not it is
advantageous to run \f(CWldconfig\fP on each boot.)  Even so, some
people like \f(CWldconfig\fP around for the following (all too common)
situation:
.LB 8 4 " " 3
.LI
I've just removed \f(CW/lib/<file>\fP.
.LI
I can't find out the name of the library because \f(CWls\fP is
dynamically linked, I'm using a shell that doesn't have \f(CWls\fP
built-in, and I don't know about using "\f(CWecho *\fP" as a
replacement.
.LI
I have a static \f(CWsln\fP, but I don't know what to call the link.
.LE
.LI
Miscellaneous:
.SP
.VL 2
.LI "\f(CW{"
ctrlaltdel, kbdrate }\fP
.LE
.P
So as to cope with the fact that some keyboards come up with such a high
repeat rate as to be unusable, \f(CWkbdrate\fP may be installed in
\f(CW/sbin\fP on some systems.
.\" should we advise installing this?
.P
Since the default action in the kernel for the Ctrl-Alt-Del key
combination is an instant hard reboot, it is generally advisable to
disable the behavior before mounting the root filesystem in read-write
mode.  Some \f(CWinit\fP suites are able to disable Ctrl-Alt-Del, but
others may require the \f(CWctrlaltdel\fP program, which may be
installed in \f(CW/sbin\fP on those systems.
.LE
.\" -------------------------------------------------------------------
.SH "/usr/include : Header files included by C programs"
.LI
.LE
.P
.P
These symbolic links are required if a C or C++ compiler is installed
and only for systems not based on glibc.
.P
.nf
.ft CW
    /usr/include/asm -> /usr/src/linux/include/asm-<arch>
    /usr/include/linux -> /usr/src/linux/include/linux
.ft P
.fi
.\" -------------------------------------------------------------------
.SH "/usr/src : Source code"
.LI
.LE
.P
.P
For systems based on glibc, there are no specific guidelines for this
directory.  For systems based on Linux libc revisions prior to glibc,
the following guidelines and rationale apply:
.P
The only source code that should be placed in a specific location is the
Linux kernel source code.  It is located in \f(CW/usr/src/linux\fP.
.P
If a C or C++ compiler is installed, but the complete Linux kernel
source code is not installed, then the include files from the kernel
source code must be located in these directories:
.P
.nf
.ft CW
    /usr/src/linux/include/asm-<arch>
    /usr/src/linux/include/linux
.ft P
.fi
.P
\f(CW<arch>\fP is the name of the system architecture.
.P
.ft I
Note: \f(CW/usr/src/linux\fP may be a symbolic link to a kernel source
code tree.
.ft P
.\" -------------------------------------------------------------------
.StartRationale
It is important that the kernel include files be located in
\f(CW/usr/src/linux\fP and not in \f(CW/usr/include\fP so there are no
problems when system administrators upgrade their kernel version for the
first time.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/var/spool/cron : cron and at jobs"
.LI
.LE
.P
.P
This directory contains the variable data for the \f(CWcron\fP and
\f(CWat\fP programs.
.SK
.\" -------------------------------------------------------------------
.\" Trailing stuff
.\" -------------------------------------------------------------------
.nr Hu 3
.SH "APPENDIX"
.LI
.LE
.P
.SS "The \*(Fs mailing list"
.P
The \*(Fs mailing list is located at <fhs-discuss@ucsd.edu>.  To
subscribe to the list send mail to <listserv@ucsd.edu> with body
"\f(CWADD fhs-discuss\fP".
.P
Thanks to Network Operations at the University of California at San
Diego who allowed us to use their excellent mailing list server.
.P
As noted in the introduction, please do not send mail to the mailing
list without first contacting the \*(Fs editor or a listed contributor.
.\" -------------------------------------------------------------------
.SS "Background of the \*(Fs"
.P
The process of developing a standard filesystem hierarchy began in
August 1993 with an effort to restructure the file and directory
structure of Linux.  The FSSTND, a filesystem hierarchy standard
specific to the Linux operating system, was released on February 14,
1994.  Subsequent revisions were released on October 9, 1994 and March
28, 1995.
.P
In early 1995, the goal of developing a more comprehensive version of
FSSTND to address not only Linux, but other \*(Ux-like systems was
adopted with the help of members of the BSD development community.
As a result, a concerted effort was made to focus on issues that were
general to \*(Ux-like systems.  In recognition of this widening of
scope, the name of the standard was changed to Filesystem Hierarchy
Standard or \*(Fs for short.
.P
Volunteers who have contributed extensively to this standard are listed
at the end of this document.  This standard represents a consensus view
of those and other contributors.
.\" -------------------------------------------------------------------
.SS "General Guidelines"
.P
Here are some of the guidelines that have been used in the development
of this standard:
.BL
.LI
Solve technical problems while limiting transitional difficulties.
.LI
Make the specification reasonably stable.
.LI
Gain the approval of distributors, developers, and other decision-makers
in relevant development groups and encourage their participation.
.LI
Provide a standard that is attractive to the implementors of different
\*(Ux-like systems.
.LE
.\" -------------------------------------------------------------------
.\" -------------------------------------------------------------------
.SS "Scope"
.P
This document specifies a standard filesystem hierarchy for \*(Fs
filesystems by specifying the location of files and directories, and the
contents of some system files.
.P
This standard has been designed to be used by system integrators,
package developers, and system administrators in the construction and
maintenance of \*(Fs compliant filesystems.  It is primarily intended to
be a reference and is not a tutorial on how to manage a conforming
filesystem hierarchy.
.P
The \*(Fs grew out of earlier work on FSSTND, a filesystem organization
standard for the Linux operating system.  It builds on FSSTND to address
interoperability issues not just in the Linux community but in a wider
arena including 4.4BSD-based operating systems.  It incorporates lessons
learned in the BSD world and elsewhere about multi-architecture support
and the demands of heterogeneous networking.
.P
Although this standard is more comprehensive than previous attempts at
filesystem hierarchy standardization, periodic updates may become
necessary as requirements change in relation to emerging technology.  It
is also possible that better solutions to the problems addressed here
will be discovered so that our solutions will no longer be the best
possible solutions.  Supplementary drafts may be released in addition to
periodic updates to this document.  However, a specific goal is
backwards compatibility from one release of this document to the next.
.P
Comments related to this standard are welcome.  Any comments or
.\" Filesystem Hierarchy Standard	-*- nroff -*-
.ig

Time-stamp: <01/05/23 15:56:36 quinlan>

Copyright (C) 1994-2001 Daniel Quinlan
Copyright (C) 2001 Paul `Rusty' Russell

See below (under "Legal stuff") for complete copying terms.

.\" ; This paragraph applies to translations only. If applicable fill
.\" ; in, modify, translate and uncomment as is suitable:
\"Translated into <language> by <name> (<email address>)
\"Date of translation: <date>
\"This translation is based on FHS <version>

This document is typeset using GNU groff 1.15 with mm macros and
preprocessed with pic and tbl.  The FHS web site is located at
<URL:http://www.pathname.com/fhs/>.

Notes on writing troff for this document:

 * Use any strings defined with a ".ds" request in the section
   "Predefined Strings".
 * Filenames should be typeset in constant width font, but don't encase
   punctuation, e.g. \f(CWfile\fP.
 * Filenames containing dashes should be proceeded with \%, e.g.
   \f(CW\%/pub/device-list\fP.
 * Use the language described in the "Conformance" section.
 * Use mm macros rather than plain troff whenever possible because
   vertical spacing is handled automatically to a large degree.  Avoid
   empty or blank lines except in ignored sections; you can replace
   most of them by a .P request or a structuring comment.

..
.\" -------------------------------------------------------------------
.\" Predefined strings - XXX FOR RELEASE: check date
.\" -------------------------------------------------------------------
.ds Date May 23, 2001
.ds Fs FHS
.ds Ux UNIX
.ie t \{\
.ds Tx T\h'-.2m'\v'+.3m'E\h'-.0m'\v'-.3m'X
\}
.el \{\
.ds Tx TeX
\}
.\" Definitions for rationale sections
.de StartRationale
.nr @ldHu \\n[Hu]
.\" Pseudo-level 5 is set up for vertical space before and a line-break
.\" after the heading.
.nr Hu 5
.SH "BEGIN RATIONALE"
.LI
.LE
.P
.SP 0.2v
.nr Hu \\n[@ldHu]
.rr @ldHu
..
.de EndRationale
.nr @ldHu \\n[Hu]
.\" Level 7 is setup for no vertical spacing around the header
.nr Hu 7
.SP 0.3v
.SH "END RATIONALE"
.LI
.LE
.P
.nr Hu \\n[@ldHu]
.rr @ldHu
.SP
..
.\" -------------------------------------------------------------------
.\" String definitions for translations only
.\" -------------------------------------------------------------------
.\" Some sections have English default names defined in the system
.\" files.  These must be changed in translations.  So uncomment and
.\" translate the following definitions.  groff_mm defines more such
.\" default strings, but they are not yet used in this document.
.\"
.\" Set the title for the abstract section on the cover page
\".AST ABSTRACT
.\"
.\" -------------------------------------------------------------------
.\" Legal stuff
.\" -------------------------------------------------------------------
.nh
.\" .nr % 2
.\" .af P i
.PF "''- \\\\nP -''"
All trademarks and copyrights are owned by their owners, unless specifically
noted otherwise.  Use of a term in this document should not be regarded
as affecting the validity of any trademark or service mark.
.BS
Copyright \(co 1995-2001 Daniel Quinlan
.P
Copyright \(co 2002 Paul `Rusty' Russell
.\" Template for translations only, uncomment and modify as suitable.
.\".P
.\"Translated into <language> by <name> <<email address>>
.P
Permission is granted to make and distribute verbatim copies of this
standard provided the copyright and this permission notice are preserved
on all copies.
.ig

Permission is granted to process this file through a typesetter (such as
troff) and print the results, provided the printed document carries a
permission notice identical to this one except for the removal of this
paragraph (this paragraph not being relevant to the printed document).
..
.P
Permission is granted to copy and distribute modified versions of this
standard under the conditions for verbatim copying, provided also that
the title page is labeled as modified including a reference to the
original standard, provided that information on retrieving the original
standard is included, and provided that the entire resulting derived
work is distributed under the terms of a permission notice identical to
this one.
.P
Permission is granted to copy and distribute translations of this
standard into another language, under the above conditions for modified
versions, except that this permission notice may be stated in a
translation approved by the copyright holder.
.BE
.SK
.\" -------------------------------------------------------------------
.\" Document body
.\" -------------------------------------------------------------------
.BS
.BE
.\" .nr % 1
.\" .af P 1
.nr Hu 4
.\" -------------------------------------------------------------------
.SS "Introduction"
.P
.\" I would like to end up with these sub-sections in the introduction:
.\" (moving some things from general to here)
.\"
.\" Statement of General purpose (or is that the abstract?)
.\"
.\" - Organization
.\" - Base Documents, if any
.\" - Background (History)
.\" - Audience
.\" - Purpose (Objectives)
.\"   - basic principles (possible to have read-only /usr, etc.)
.\"     including: broadly implementable, minimal changes to historic
.\"     implementations, minimal changes to existing implementations
.\" - Related Standards
.\" -------------------------------------------------------------------
.SS "Purpose"
.P
This standard enables
.BL
.LI
Software to predict the location of installed files and directories, and
.LI
Users to predict the location of installed files and directories.
.LE
.P
We do this by
.BL
.LI
Specifying guiding principles for each area of the filesystem,
.LI
Specifying the minimum files and directories required,
.LI
Enumerating exceptions to the principles, and
.LI
Enumerating specific cases where there has been historical conflict.
.LE
.P
The FHS document is used by
.BL
.LI
Independent software suppliers to create applications which are FHS
compliant, and work with distributions which are FHS complaint,
.LI
OS creators to provide systems which are FHS compliant, and
.LI
Users to understand and maintain the FHS compliance of a system.
.LE
.\" -------------------------------------------------------------------
.SS "Conventions"
.P
.ie t \{\
A constant-width font is used for displaying the names of files and
directories.
\}
.el \{\
We recommend that you read a typeset version of this document rather
than the plain text version.  In the typeset version, the names of files
and directories are displayed in a constant-width font.
\}
.P
Components of filenames that vary are represented by a description of
the contents enclosed in "\f(CW<\fP" and "\f(CW>\fP" characters,
\f(CW<thus>\fP.  Electronic mail addresses are also enclosed in "<" and
">" but are shown in the usual typeface.
.P
Optional components of filenames are enclosed in "\f(CW[\fP" and
"\f(CW]\fP" characters and may be combined with the "\f(CW<\fP" and
"\f(CW>\fP" convention.  For example, if a filename is allowed to occur
either with or without an extension, it might be represented by
\f(CW<filename>[.<extension>]\fP.
.P
Variable substrings of directory names and filenames are indicated by
"\f(CW*\fP".
.\" -------------------------------------------------------------------
.SS "The Filesystem"
.P
This standard assumes that the operating system underlying an
\*(Fs-compliant file system supports the same basic security features
found in most \*(Ux filesystems.
.P
It is possible to define two independent categories of files: shareable
vs. unshareable and variable vs. static.  There should be a simple and
easily understandable mapping from directories to the type of data they contain: directories
may be mount points for other filesystems with different characteristics
from the filesystem on which they are mounted.
.\" categories/categorizations and files/file-data
.P
Shareable data is that which can be shared between several different
hosts; unshareable is that which must be specific to a particular host.
For example, user home directories are shareable data, but device lock
files are not.
.P
Static data includes binaries, libraries, documentation, and anything
that does not change without system administrator intervention; variable
data is anything else that does change without system administrator
intervention.
.StartRationale
The distinction between shareable and unshareable data is needed for
several reasons:
.BL
.LI
In a networked environment (i.e., more than one host at a site), there
is a good deal of data that can be shared between different hosts to
save space and ease the task of maintenance.
.LI
In a networked environment, certain files contain information specific
to a single host.  Therefore these filesystems cannot be shared
(without taking special measures).
.LI
Historical implementations of \*(Ux-like filesystems interspersed
shareable and unshareable data in the same hierarchy, making it
difficult to share large portions of the filesystem.
.LE
.P
The "shareable" distinction can be used to support, for example:
.BL
.LI
A \f(CW/usr\fP partition (or components of \f(CW/usr\fP) mounted
(read-only) through the network (using NFS).
.LI
A \f(CW/usr\fP partition (or components of \f(CW/usr\fP) mounted from
read-only media.  A CD-ROM is one copy of many identical ones
distributed to other users by the postal mail system and other methods.
It can thus be regarded as a read-only filesystem shared with other
\*(Fs-compliant systems by some kind of "network".
.LE
.P
The "static" versus "variable" distinction affects the filesystem in two
major ways:
.BL
.LI
Since \f(CW/\fP contains both variable and static data, it needs to be mounted
read-write.
.LI
Since the traditional \f(CW/usr\fP contains both variable and static data, and
since we may want to mount it read-only (see above), it is necessary to
provide a method to have \f(CW/usr\fP mounted read-only.  This is done through
the creation of a \f(CW/var\fP hierarchy that is mounted read-write (or is a
part of another read-write partition, such as \f(CW/)\fP, taking over much of
the \f(CW/usr\fP partition's traditional functionality.
.LE
.P
Here is a summarizing chart.  This chart is only an example for a common
\*(Fs-compliant system, other chart layouts are possible within
\*(Fs-compliance.
.\" XXX - this was:
.\" Here is a summarizing chart.  Since this chart contains generalized
.\" examples, it may not apply to every possible implementation of
.\" an \*(Fs-compliant system.
.TS
box,center;
l | l | l.
	shareable	unshareable
_
static	/usr	/etc
	/opt	/boot
_
variable	/var/mail	/var/run
	/var/spool/news	/var/lock
.TE
.EndRationale
.\" -------------------------------------------------------------------
.SS "The Root Filesystem"
.\" XXX - bernd says: The usage of `root' is heavily overloaded.  Maybe
.\" `root directory' and `root partition' should be replaced by `main
.\" directory', `boot partition', etc.
.SS "Purpose"
The contents of the root filesystem must be adequate to boot, restore,
recover, and/or repair the system.
.BL
.LI
To boot a system, enough must be present on the root partition to mount
other filesystems.  This includes utilities, configuration, boot loader
information, and other essential start-up data.  \f(CW/usr\fP,
\f(CW/opt\fP, and \f(CW/var\fP are designed such that they may be
located on other partitions or filesystems.
.LI
To enable recovery and/or repair of a system, those utilities needed by
an experienced maintainer to diagnose and reconstruct a damaged system
must be present on the root filesystem.
.LI
To restore a system, those utilities needed to restore from system
backups (on floppy, tape, etc.) must be present on the root
filesystem.
.LE
.\" -------------------------------------------------------------------
.StartRationale
.P
The primary concern used to balance these considerations, which favor
placing many things on the root filesystem, is the goal of keeping
root as small as reasonably possible.  For several reasons, it is
desirable to keep the root filesystem small:
.BL
.LI
It is occasionally mounted from very small media.
.LI
The root filesystem contains many system-specific configuration files.
Possible examples include a kernel that is specific to the system, a
specific hostname, etc.  This means that the root filesystem isn't
always shareable between networked systems.  Keeping it small on servers
in networked systems minimizes the amount of lost space for areas of
unshareable files.  It also allows workstations with smaller local hard
drives.
.LI
While you may have the root filesystem on a large partition, and may be
able to fill it to your heart's content, there will be people with
smaller partitions.  If you have more files installed, you may find
incompatibilities with other systems using root filesystems on smaller
partitions.  If you are a developer then you may be turning your
assumption into a problem for a large number of users.
.LI
Disk errors that corrupt data on the root filesystem are a greater
problem than errors on any other partition.  A small root filesystem is
less prone to corruption as the result of a system crash.
.LE
.P
Software must never create or require special files or subdirectories
in the root directory.  Other locations in the \*(Fs hierarchy provide
more than enough flexibility for any package.
.P
There are several reasons why introducing a new subdirectory of the root
filesystem is prohibited:
.BL
.LI
It demands space on a root partition which the system administrator may
want kept small and simple for either performance or security reasons.
.LI
It evades whatever discipline the system administrator may have set up
for distributing standard file hierarchies across mountable volumes.
.LE
.EndRationale
.\" -------------------------------------------------------------------
.SS "Requirements"
The following directories, or symbolic links to directories, are required in \f(CW/\fP.
.PS
copy "dirgraph.pic"
dir("/","the root directory")
sub("bin","Essential command binaries")
sub("boot","Static files of the boot loader")
sub("dev","Device files")
sub("etc","Host-specific system configuration")
sub("lib","Essential shared libraries and kernel modules")
sub("mnt","Mount point for mounting a filesystem temporarily")
sub("opt","Add-on application software packages")
sub("sbin","Essential system binaries")
sub("tmp","Temporary files")
sub("usr","Secondary hierarchy")
sub("var","Variable data")
.PE
.P
Each directory listed above is specified in detail in separate
subsections below.  \f(CW/usr\fP and \f(CW/var\fP each have a complete
section in this document due to the complexity of those directories.

.SS "Specific Options"
The following directories, or symbolic links to directories, must be in \f(CW/\fP, if the corresponding
subsystem is installed:
.PS
copy "dirgraph.pic"
dir("/","the root directory")
sub("home","User home directories (optional)")
sub("lib<qual>","Alternate format essential shared libraries (optional)")
sub("root","Home directory for the root user (optional)")
.PE
.P
Each directory listed above is specified in detail in separate
subsections below.

.\" -------------------------------------------------------------------
.SH "/bin : Essential user command binaries (for use by all users)"
.LI
.LE
.P
.SS "Purpose"
\f(CW/bin\fP contains commands that may be used by both the system
administrator and by users, but which are required when no other
filesystems are mounted (e.g. in single user mode).  It may also contain
commands which are used indirectly by scripts.\*F
.FS
Command binaries that are not essential enough to place into
\f(CW/bin\fP must be placed in \f(CW/usr/bin\fP, instead.  Items that
are required only by non-root users (the X Window System, \f(CWchsh\fP,
etc.) are generally not essential enough to be placed into the root
partition.
.FE
.SS "Requirements"
There must be no subdirectories in \f(CW/bin\fP.
.P
The following commands, or symbolic links to commands, are required in \f(CW/bin\fP.
.TS
tab(@);
lfCW l.
cat@Utility to concatenate files to standard output
chgrp@Utility to change file group ownership
chmod@Utility to change file access permissions
chown@Utility to change file owner and group
cp@Utility to copy files and directories
date@Utility to print or set the system data and time
dd@Utility to convert and copy a file
df@Utility to report filesystem disk space usage
dmesg@Utility to print or control the kernel message buffer
echo@Utility to display a line of text
false@Utility to do nothing, unsuccessfully
hostname@Utility to show or set the system's host name
kill@Utility to send signals to processes
ln@Utility to make links between files
login@Utility to begin a session on the system
ls@Utility to list directory contents
mkdir@Utility to make directories
mknod@Utility to make block or character special files
more@Utility to page through text
mount@Utility to mount a filesystem
mv@Utility to move/rename files
ps@Utility to report process status
pwd@Utility to print name of current working directory
rm@Utility to remove files or directories
rmdir@Utility to remove empty directories
sed@The `sed' stream editor
sh@The Bourne command shell
stty@Utility to change and print terminal line settings
su@Utility to change user ID
sync@Utility to flush filesystem buffers
true@Utility to do nothing, successfully
umount@Utility to unmount file systems
uname@Utility to print system information
.TE
.P
If \f(CW/bin/sh\fP is not a true Bourne shell, it must be a hard or
symbolic link to the real shell command.
.P
The \f(CW[\fP and \f(CWtest\fP commands must be placed together in
either \f(CW/bin\fP or \f(CW/usr/bin\fP.
.StartRationale
For example bash behaves differently when called as \f(CWsh\fP or
\f(CWbash\fP.  The use of a symbolic link also allows users to easily
see that \f(CW/bin/sh\fP is not a true Bourne shell.
.P
The requirement for the \f(CW[\fP and \f(CWtest\fP commands to be
included as binaries (even if implemented internally by the shell) is shared with the POSIX.2 standard.
.EndRationale
.SS "Specific Options"
The following programs, or symbolic links to programs, must be in \f(CW/bin\fP if the corresponding
subsystem is installed:
.TS
tab(@);
lfCW l.
csh@The C shell (optional)
ed@The `ed' editor (optional)
tar@The tar archiving utility (optional)
cpio@The cpio archiving utility (optional)
gzip@The GNU compression utility (optional)
gunzip@The GNU uncompression utility (optional)
zcat@The GNU uncompression utility (optional)
netstat@The network statistics utility (optional)
ping@The ICMP network test utility (optional)
.TE
.P
If the gunzip and zcat programs exist, they must be symbolic or hard
links to gzip. \f(CW/bin/csh\fP may be a symbolic link to
\f(CW/bin/tcsh\fP or \f(CW/usr/bin/tcsh\fP.
.StartRationale
The tar, gzip and cpio commands have been added to make restoration of a
system possible (provided that \f(CW/\fP is intact).
.P
Conversely, if no restoration from the root partition is ever expected,
then these binaries might be omitted (e.g., a ROM chip root, mounting
\f(CW/usr\fP through NFS).  If restoration of a system is planned
through the network, then \f(CWftp\fP or \f(CWtftp\fP (along with
everything necessary to get an ftp connection) must be available on
the root partition.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/boot : Static files of the boot loader"
.LI
.LE
.P
.P
.SS "Purpose"
This directory contains everything required for the boot process except
configuration files and the map installer.  Thus \f(CW/boot\fP stores
data that is used before the kernel begins executing user-mode
programs.  This may include saved master boot sectors, sector map files,
and other data that is not directly edited by hand.\*F
.FS
Programs necessary to arrange for the boot loader to be able to
boot a file must be placed in \f(CW/sbin\fP.  Configuration files for
boot loaders must be placed in \f(CW/etc\fP.
.FE
.P
.SS "Specific Options"
The operating system kernel must be located in either \f(CW/\fP or
\f(CW/boot\fP.\*F
.FS
On some i386 machines, it may be necessary for \f(CW/boot\fP to be
located on a separate partition located completely below cylinder 1024
of the boot device due to hardware constraints.
.P
Certain MIPS systems require a \f(CW/boot\fP partition that is a mounted
MS-DOS filesystem or whatever other filesystem type is accessible for
the firmware.  This may result in restrictions with respect to usable
filenames within \f(CW/boot\fP (only for affected systems).
.FE
.\" -------------------------------------------------------------------
.SH "/dev : Device files"
.LI
.LE
.P
.P
.SS "Purpose"
The \f(CW/dev\fP directory is the location of special or device files.
.P
.SS "Specific Options"
.P
If it is possible that devices in \f(CW/dev\fP will need to be manually
created, \f(CW/dev\fP must contain a command named \f(CWMAKEDEV\fP,
which can create devices as needed.  It may also contain a
\f(CWMAKEDEV.local\fP for any local devices.
.P
If required, \f(CWMAKEDEV\fP must have provisions for creating any
device that may be found on the system, not just those that a particular
implementation installs.
.\" -------------------------------------------------------------------
.SH "/etc : Host-specific system configuration"
.LI
.LE
.P
.P
.SS "Purpose"
\f(CW/etc\fP contains configuration files and directories that are
specific to the current system.\*F
.FS
The setup of command scripts invoked at boot time may resemble
System V, BSD or other models.  Further specification in this area
may be added to a future version of this standard.
.FE
.P
.SS "Requirements"
No binaries may be located under \f(CW/etc\fP.
.P
The following directories, or symbolic links to directories are required in \f(CW/etc\fP:
.PS
copy "dirgraph.pic"
dir("/etc","Host-specific system configuration")
sub("opt","Configuration for /opt")
.PE
.SS "Specific Options"
.P
The following directories, or symbolic links to directories must be in \f(CW/etc\fP, if the corresponding
subsystem is installed:
.PS
copy "dirgraph.pic"
dir("/etc","Host-specific system configuration")
sub("X11","Configuration for the X Window System (optional)")
sub("sgml","Configuration for SGML and XML (optional)")
.PE
The following files, or symbolic links to files, must be in \f(CW/etc\fP if the corresponding
subsystem is installed:\*F
.TS
tab(@);
lfCW l.
csh.login@Systemwide initialization file for C shell logins (optional)
exports@NFS filesystem access control list (optional)
fstab@Static information about filesystems (optional)
ftpusers@FTP daemon user access control list (optional)
gateways@File which lists gateways for routed (optional)
gettydefs@Speed and terminal settings used by getty (optional)
group@User group file (optional)
host.conf@Resolver configuration file (optional)
hosts@Static information about host names (optional)
hosts.allow@Host access file for TCP wrappers (optional)
hosts.deny@Host access file for TCP wrappers (optional)
hosts.equiv@List of trusted hosts for rlogin, rsh, rcp (optional)
hosts.lpd@List of trusted hosts for lpd (optional)
inetd.conf@Configuration file for inetd (optional)
inittab@Configuration file for init (optional)
issue@Pre-login message and identification file (optional)
ld.so.conf@List of extra directories to search for shared libraries (optional)
motd@Post-login message of the day file (optional)
mtab@Dynamic information about filesystems (optional)
mtools.conf@Configuration file for mtools (optional)
networks@Static information about network names (optional)
passwd@The password file (optional)
printcap@The lpd printer capability database (optional)
profile@Systemwide initialization file for sh shell logins (optional)
protocols@IP protocol listing (optional)
resolv.conf@Resolver configuration file (optional)
rpc@RPC protocol listing (optional)
securetty@TTY access control for root login (optional)
services@Port names for network services (optional)
shells@Pathnames of valid login shells (optional)
syslog.conf@Configuration file for syslogd (optional)
.TE
.FS
Systems that use the shadow password suite will have additional
configuration files in \f(CW/etc\fP (\f(CW/etc/shadow\fP and others) and
programs in \f(CW/usr/sbin\fP (\f(CWuseradd\fP, \f(CWusermod\fP, and
others).
.FE
.P
mtab does not fit the static nature of \f(CW/etc\fP: it is excepted for
historical reasons.\*F
.FS
On some Linux systems, this may be a symbolic link to
\f(CW/proc/mounts\fP, in which case this exception is not required.
.FE
.\" -------------------------------------------------------------------
.SH "/etc/opt : Configuration files for /opt"
.LI
.LE
.P
.P
.SS "Purpose"
Host-specific configuration files for add-on application software
packages must be installed within the directory
\f(CW/etc/opt/<package>\fP, where \f(CW<package>\fP is the name of the
subtree in \f(CW/opt\fP where the static data from that package is
stored.
.SS "Requirements"
No structure is imposed on the internal arrangement of
\f(CW/etc/opt/<package>\fP.
.P
If a configuration file must reside in a different location in order for
the package or system to function properly, it may be placed in a
location other than \f(CW/etc/opt/<package>\fP.
.\" -------------------------------------------------------------------
.StartRationale
Refer to the rationale for \f(CW/opt\fP.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/etc/X11 : Configuration for the X Window System (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
\f(CW/etc/X11\fP is the location for all X11 host-specific
configuration.  This directory is necessary to allow local control if
\f(CW/usr\fP is mounted read only.
.SS "Specific Options"
The following files, or symbolic links to files, must be in \f(CW/etc/X11\fP if the corresponding
subsystem is installed:
.TS
tab(@);
lfCW l.
Xconfig@The configuration file for early versions of XFree86 (optional)
XF86Config@The configuration file for XFree86 versions 3 and 4 (optional)
Xmodmap@Global X11 keyboard modification file (optional)
.TE
.P
Subdirectories of \f(CW/etc/X11\fP may include those for \f(CWxdm\fP and
for any other programs (some window managers, for example) that need
them.\*F
.FS
\f(CW/etc/X11/xdm\fP holds the configuration files for \f(CWxdm\fP.
These are most of the files previously found in \f(CW/usr/lib/X11/xdm\fP.
Some local variable data for \f(CWxdm\fP is stored in
\f(CW/var/lib/xdm\fP.
.FE
We recommend that window managers with only one configuration
file which is a default \f(CW.*wmrc\fP file must name it
\f(CWsystem.*wmrc\fP (unless there is a widely-accepted alternative
name) and not use a subdirectory.  Any window manager subdirectories
must be identically named to the actual window manager binary.
.P
.\" -------------------------------------------------------------------
.SH "/etc/sgml : Configuration files for SGML and XML (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
Generic configuration files defining high-level parameters of the SGML
or XML systems are installed here.  Files with names \f(CW*.conf\fP
indicate generic configuration files.  File with names \f(CW*.cat\fP are
the DTD-specific centralized catalogs, containing references to all
other catalogs needed to use the given DTD.  The super catalog file
\f(CWcatalog\fP references all the centralized catalogs.
.\" -------------------------------------------------------------------
.SH "/home : User home directories (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
\f(CW/home\fP is a fairly standard concept, but it is clearly a
site-specific filesystem.\*F
.FS
Different people prefer to place user accounts in a variety of places.
This section describes only a suggested placement for user home
directories; nevertheless we recommend that all \*(Fs-compliant
distributions use this as the default location for home directories.
.P
On small systems, each user's directory is typically one of the many
subdirectories of \f(CW/home\fP such as \f(CW/home/smith\fP,
\f(CW/home/torvalds\fP, \f(CW/home/operator\fP, etc.
On large systems (especially when the \f(CW/home\fP directories are
shared amongst many hosts using NFS) it is useful to subdivide user home
directories.  Subdivision may be accomplished by using subdirectories
such as \f(CW/home/staff\fP, \f(CW/home/guests\fP,
\f(CW/home/students\fP, etc.
.FE
The setup will differ from host to host.
Therefore, no program should rely on this location.\*F
.FS
If you want to find out a user's home directory, you should use the
\f(CWgetpwent(3)\fP library function rather than relying on
\f(CW/etc/passwd\fP because user information may be stored remotely
using systems such as NIS.
.FE
.\" -------------------------------------------------------------------
.SH "/lib : Essential shared libraries and kernel modules"
.LI
.LE
.P
.P
.SS "Purpose"
The \f(CW/lib\fP directory contains those shared library images needed
to boot the system and run the commands in the root filesystem, ie. by
binaries in \f(CW/bin\fP and \f(CW/sbin\fP.\*F
.FS
Shared libraries that are only necessary for binaries in \f(CW/usr\fP
(such as any X Window binaries) must not be in \f(CW/lib\fP. Only
the shared libraries required to run binaries in \f(CW/bin\fP and
\f(CW/sbin\fP may be here.  In particular, the library \f(CWlibm.so.*\fP may also
be placed in \f(CW/usr/lib\fP if it is not required by anything in
\f(CW/bin\fP or \f(CW/sbin\fP.
.FE
.SS "Requirements"
At least one of each of the following filename patterns are required
(they may be files, or symbolic links):
.TS
tab(@);
lfCW l.
libc.so.*@The dynamically-linked C library (optional)
ld*@The execution time linker/loader (optional)
.TE
.P
If a C preprocessor is installed, \f(CW/lib/cpp\fP must be a reference
to it, for historical reasons.\*F
.FS
The usual placement of this binary is
\f(CW\%/usr/lib/gcc-lib/<target>/<version>/cpp\fP.  \f(CW/lib/cpp\fP can
either point at this binary, or at any other reference to this binary
which exists in the filesystem.  (For example, \f(CW/usr/bin/cpp\fP is
also often used.)
.FE
.SS "Specific Options"
The following directories, or symbolic links to directories, must be in \f(CW/lib\fP, if the corresponding
subsystem is installed:
.PS
copy "dirgraph.pic"
dir("/lib","essential shared libraries and kernel modules")
sub("modules","Loadable kernel modules (optional)")
.PE
.P
.\" .ft I
.\" Note: The specification for \f(CW/lib/modules\fP is forthcoming.
.\" .ft P
.\" -------------------------------------------------------------------
.SH "/lib<qual> : Alternate format essential shared libraries (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
There may be one or more variants of the \f(CW/lib\fP directory on
systems which support more than one binary format requiring separate
libraries.\*F
.FS
This is commonly used for 64-bit or 32-bit support on systems which
support multiple binary formats, but require libraries of the same name.
In this case, \f(CW/lib32\fP and \f(CW/lib64\fP might be the library
directories, and \f(CW/lib\fP a symlink to one of them.
.FE
.P
.SS "Requirements"
If one or more of these directories exist, the requirements for their
contents are the same as the normal \f(CW/lib\fP directory, except that
\f(CW/lib<qual>/cpp\fP is not required.\*F
.FS
\f(CW/lib<qual>/cpp\fP is still permitted: this allows the case where
\f(CW/lib\fP and \f(CW/lib<qual>\fP are the same (one is a symbolic link
to the other).
.FE
.\" -------------------------------------------------------------------
.SH "/mnt : Mount point for a temporarily mounted filesystem"
.LI
.LE
.P
.P
.SS "Purpose"
This directory is provided so that the system administrator may
temporarily mount a filesystem as needed.  The content of this directory
is a local issue and should not affect the manner in which any program
is run.
.P
This directory must not be used by installation programs: a suitable
temporary directory not in use by the system must be used instead.
.\" -------------------------------------------------------------------
.SH "/opt : Add-on application software packages"
.LI
.LE
.P
.SS "Purpose"
\f(CW/opt\fP is reserved for the installation of add-on application
software packages.
.P
A package to be installed in \f(CW/opt\fP must locate its static files
in a separate \f(CW/opt/<package>\fP directory tree, where
\f(CW<package>\fP is a name that describes the software package.
.P
.SS "Requirements"
.PS
copy "dirgraph.pic"
dir("/opt","Add-on application software packages")
sub("<package>","Static package objects")
.PE
The directories \f(CW/opt/bin\fP, \f(CW/opt/doc\fP,
\f(CW/opt/include\fP, \f(CW/opt/info\fP, \f(CW/opt/lib\fP, and
\f(CW/opt/man\fP are reserved for local system administrator use.
Packages may provide "front-end" files intended to be placed in (by
linking or copying) these reserved directories by the local system
administrator, but must function normally in the absence of these
reserved directories.
.P
Programs to be invoked by users must be located in the directory
\f(CW/opt/<package>/bin\fP. If the package includes \*(Ux manual pages,
they must be located in \f(CW/opt/<package>/man\fP and the same
substructure as \f(CW/usr/share/man\fP must be used.
.P
Package files that are variable (change in normal operation) must be
installed in \f(CW/var/opt\fP.  See the section on \f(CW/var/opt\fP for
more information.
.P
Host-specific configuration files must be installed in
\f(CW/etc/opt\fP.  See the section on \f(CW/etc\fP for more information.
.P
No other package files may exist outside the \f(CW/opt\fP,
\f(CW/var/opt\fP, and \f(CW/etc/opt\fP hierarchies except for those
package files that must reside in specific locations within the
filesystem tree in order to function properly.  For example, device lock
files must be placed in \f(CW/var/lock\fP and devices must be located in
\f(CW/dev\fP.
.P
Distributions may install software in \f(CW/opt\fP, but must not
modify or delete software installed by the local system administrator
without the assent of the local system administrator.
.\" -------------------------------------------------------------------
.StartRationale
The use of \f(CW/opt\fP for add-on software is a well-established
practice in the \*(Ux community.  The System V Application Binary
Interface [AT&T 1990], based on the System V Interface Definition (Third
Edition), provides for an \f(CW/opt\fP structure very similar to the one
defined here.
.P
The Intel Binary Compatibility Standard v. 2 (iBCS2) also provides a
similar structure for \f(CW/opt\fP.
.P
Generally, all data required to support a package on a system must be
present within \f(CW/opt/<package>\fP, including files intended to be
copied into \f(CW/etc/opt/<package>\fP and \f(CW/var/opt/<package>\fP as
well as reserved directories in \f(CW/opt\fP.
.P
The minor restrictions on distributions using \f(CW/opt\fP are necessary
because conflicts are possible between distribution-installed and
locally-installed software, especially in the case of fixed pathnames
found in some binary software.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/root : Home directory for the root user (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
The root account's home directory may be determined by developer or
local preference, but this is the recommended default location.\*F
.FS
If the home directory of the root account is not stored on the root
partition it will be necessary to make certain it will default to
\f(CW/\fP if it can not be located.
.P
We recommend against using the root account for tasks that can be
performed as an unprivileged user, and that it be used solely for system
administration.  For this reason, we recommend that subdirectories for
mail and other applications not appear in the root account's home
directory, and that mail for administration roles such as root,
postmaster, and webmaster be forwarded to an appropriate user.
.FE
.\" -------------------------------------------------------------------
.SH "/sbin : System binaries"
.LI
.LE
.P
.P
.SS "Purpose"
Utilities used for system administration (and other root-only commands)
are stored in \f(CW/sbin\fP, \f(CW/usr/sbin\fP, and
\f(CW/usr/local/sbin\fP.  \f(CW/sbin\fP contains binaries essential for
booting, restoring, recovering, and/or repairing the system in addition
to the binaries in \f(CW/bin\fP.\*F
.FS
Originally, \f(CW/sbin\fP binaries were kept in \f(CW/etc\fP.
.FE
Programs executed after \f(CW/usr\fP is known to be mounted (when there
are no problems) are generally placed into \f(CW/usr/sbin\fP.
Locally-installed system administration programs should be placed into
\f(CW/usr/local/sbin\fP.\*F
.FS
Deciding what things go into \f(CW"sbin"\fP directories is simple: if a
normal (not a system administrator) user will ever run it directly, then
it must be placed in one of the \f(CW"bin"\fP directories.  Ordinary
users should not have to place any of the \f(CWsbin\fP directories in
their path.
.P
For example, files such as \f(CWchfn\fP which users only
occasionally use must still be placed in \f(CW/usr/bin\fP.
\f(CWping\fP, although it is absolutely necessary for root (network
recovery and diagnosis) is often used by users and must live in
\f(CW/bin\fP for that reason.
.P
We recommend that users have read and execute permission for everything
in \f(CW/sbin\fP except, perhaps, certain setuid and setgid programs.
The division between \f(CW/bin\fP and \f(CW/sbin\fP was not created for
security reasons or to prevent users from seeing the operating system,
but to provide a good partition between binaries that everyone uses and
ones that are primarily used for administration tasks.  There is no
inherent security advantage in making \f(CW/sbin\fP off-limits for
users.
.FE
.\" -------------------------------------------------------------------
.SS "Requirements"
The following commands, or symbolic links to commands, are required in \f(CW/sbin\fP.
.TS
tab(@);
lfCW l.
shutdown@Command to bring the system down.
.TE
.SS "Specific Options"
The following files, or symbolic links to files, must be in \f(CW/sbin\fP if the corresponding
subsystem is installed:
.TS
tab(@);
lfCW l.
fastboot@Reboot the system without checking the disks (optional)
fasthalt@Stop the system without checking the disks (optional)
fdisk@Partition table manipulator (optional)
fsck@File system check and repair utility (optional)
fsck.*@File system check and repair utility for a specific filesystem (optional)
getty@The getty program (optional)
halt@Command to stop the system (optional)
ifconfig@Configure a network interface (optional)
init@Initial process (optional)
mkfs@Command to build a filesystem (optional)
mkfs.*@Command to build a specific filesystem (optional)
mkswap@Command to set up a swap area (optional)
reboot@Command to reboot the system (optional)
route@IP routing table utility (optional)
swapon@Enable paging and swapping (optional)
swapoff@Disable paging and swapping (optional)
update@Daemon to periodically flush filesystem buffers (optional)
.TE
.\" -------------------------------------------------------------------
.SH "/tmp : Temporary files"
.LI
.LE
.P
.P
.SS "Purpose"
The \f(CW/tmp\fP directory must be made available for programs that
require temporary files.
.P
Programs must not assume that any files or directories in \f(CW/tmp\fP
are preserved between invocations of the program.
.\" -------------------------------------------------------------------
.StartRationale
IEEE standard P1003.2 (POSIX, part 2) makes requirements that are
similar to the above section.
.P
Although data stored in \f(CW/tmp\fP may be deleted in a site-specific
manner, it is recommended that files and directories located in
\f(CW/tmp\fP be deleted whenever the system is booted.
.P
\*(Fs added this recommendation
on the basis of historical precedent and common practice, but did not
make it a requirement because system administration is not within the
scope of this standard.
.EndRationale
.\" -------------------------------------------------------------------
.SS "The /usr Hierarchy"
.P
.SS "Purpose"
\f(CW/usr\fP is the second major section of the filesystem.
\f(CW/usr\fP is shareable, read-only data.  That means that \f(CW/usr\fP
should be shareable between various \*(Fs-compliant hosts and
must not be written to.  Any information that is host-specific or
varies with time is stored elsewhere.
.P
Large software packages must not use a direct subdirectory under the
\f(CW/usr\fP hierarchy.
.P
.SS "Requirements"
The following directories, or symbolic links to directories, are required in \f(CW/usr\fP.
.PS
copy "dirgraph.pic"
dir("/usr","Secondary Hierarchy")
sub("bin","Most user commands")
sub("include","Header files included by C programs")
sub("lib","Libraries")
sub("local","Local hierarchy (empty after main installation)")
sub("sbin","Non-vital system binaries")
sub("share","Architecture-independent data")
.PE
.SS "Specific Options"
.PS
copy "dirgraph.pic"
dir("/usr","Secondary Hierarchy")
sub("X11R6","X Window System, version 11 release 6 (optional)")
sub("games","Games and educational binaries (optional)")
sub("lib<qual>","Alternate Format Libraries (optional)")
sub("src","Source code (optional)")
.PE
An exception is made for the X Window System because of considerable
precedent and widely-accepted practice.
.P
The following symbolic links to directories may be present. This
possibility is based on the need to preserve compatibility with older
systems until all implementations can be assumed to use the \f(CW/var\fP
hierarchy.
.P
.nf
.ft CW
    /usr/spool -> /var/spool
    /usr/tmp -> /var/tmp
    /usr/spool/locks -> /var/lock
.ft P
.fi
.P
Once a system no longer requires any one of the above symbolic links,
the link may be removed, if desired.
.\" -------------------------------------------------------------------
.SH "/usr/X11R6 : X Window System, Version 11 Release 6 (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
This hierarchy is reserved for the X Window System, version 11 release
6, and related files.
.P
To simplify matters and make XFree86 more compatible with the X Window
System on other systems, the following symbolic links must be present if
\f(CW/usr/X11R6\fP exists:
.P
.nf
.ft CW
    /usr/bin/X11 -> /usr/X11R6/bin
    /usr/lib/X11 -> /usr/X11R6/lib/X11
    /usr/include/X11 -> /usr/X11R6/include/X11
.ft P
.fi
.P
In general, software must not be installed or managed via the above
symbolic links.  They are intended for utilization by users only.  The
difficulty is related to the release version of the X Window System \(em
in transitional periods, it is impossible to know what release of X11 is
in use.
.SS "Specific Options"
Host-specific data in \f(CW/usr/X11R6/lib/X11\fP should be interpreted
as a demonstration file.  Applications requiring information about the
current host must reference a configuration file in \f(CW/etc/X11\fP,
which may be linked to a file in \f(CW/usr/X11R6/lib\fP.\*F
.FS
Examples of such configuration files include \f(CWXconfig\fP,
\f(CWXF86Config\fP, or \f(CWsystem.twmrc\fP)
.FE
.P
.\" -------------------------------------------------------------------
.SH "/usr/bin : Most user commands"
.LI
.LE
.P
.P
.SS "Purpose"
This is the primary directory of executable commands on the system.
.SS "Specific Options"
The following directories, or symbolic links to directories, must be in \f(CW/usr/bin\fP, if the corresponding
subsystem is installed:
.PS
copy "dirgraph.pic"
dir("/usr/bin","Binaries that are not needed in single-user mode")
sub("mh","Commands for the MH mail handling system (optional)")
.PE
\f(CW/usr/bin/X11\fP must be a symlink to \f(CW/usr/X11R6/bin\fP if the
latter exists.
.P
The following files, or symbolic links to files, must be in \f(CW/usr/bin\fP, if the corresponding
subsystem is installed:
.TS
tab(@);
lfCW l.
perl@The Practical Extraction and Report Language (optional)
python@The Python interpreted language (optional)
tclsh@Simple shell containing Tcl interpreter (optional)
wish@Simple Tcl/Tk windowing shell (optional)
expect@Program for interactive dialog (optional)
.TE
.StartRationale
Because shell script interpreters (invoked with \f(CW#!<path>\fP on the
first line of a shell script) cannot rely on a path, it is advantageous
to standardize their locations.  The Bourne shell and C-shell
interpreters are already fixed in \f(CW/bin\fP, but Perl, Python, and
Tcl are often found in many different places.  They may be symlinks to
the physical location of the shell interpreters.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/usr/include : Directory for standard include files."
.LI
.LE
.P
.P
.SS "Purpose"
This is where all of the system's general-use include files for the C
programming language should be placed.
.SS "Specific Options"
The following directories, or symbolic links to directories, must be in \f(CW/usr/include\fP, if the corresponding
subsystem is installed:
.PS
copy "dirgraph.pic"
dir("/usr/include","Include files")
sub("bsd","BSD compatibility include files (optional)")
.PE
The symbolic link \f(CW/usr/include/X11\fP must link to
\f(CW/usr/X11R6/include/X11\fP if the latter exists.
.\" -------------------------------------------------------------------
.SH "/usr/lib : Libraries for programming and packages"
.LI
.LE
.P
.P
.SS "Purpose"
\f(CW/usr/lib\fP includes object files, libraries, and internal binaries
that are not intended to be executed directly by users or shell scripts.\*F
.FS
Miscellaneous architecture-independent application-specific static files
and subdirectories must be placed in \f(CW/usr/share\fP.
.FE
.P
Applications may use a single subdirectory under \f(CW/usr/lib\fP.  If
an application uses a subdirectory, all architecture-dependent data
exclusively used by the application must be placed within that
subdirectory.\*F
.FS
For example, the \f(CWperl5\fP subdirectory for Perl 5 modules and
libraries.
.FE
.P
.SS "Specific Options"
.P
For historical reasons, \f(CW/usr/lib/sendmail\fP must be a symbolic
link to \f(CW/usr/sbin/sendmail\fP if the latter exists.\*F
.FS
Some executable commands such as \f(CWmakewhatis\fP and \f(CWsendmail\fP
have also been traditionally placed in \f(CW/usr/lib\fP.
\f(CWmakewhatis\fP is an internal binary and must be placed in a
binary directory; users access only \f(CWcatman\fP.  Newer
\f(CWsendmail\fP binaries are now placed by default in
\f(CW/usr/sbin\fP.  Additionally, systems using a
\f(CWsendmail\fP-compatible mail transfer agent must provide
\f(CW/usr/sbin/sendmail\fP as a symbolic link to the appropriate
executable.
.FE
.P
If \f(CW/lib/X11\fP exists, \f(CW/usr/lib/X11\fP must be a symbolic link
to \f(CW/lib/X11\fP, or to whatever \f(CW/lib/X11\fP is a symbolic link
to.\*F
.\" XXX - Chris deleted this.  Maybe pare it down to a sentence???
.\"
.FS
Host-specific data for the X Window System must not be stored in
\f(CW/usr/lib/X11\fP.  Host-specific configuration files such as
\f(CWXconfig\fP or \f(CWXF86Config\fP must be stored in
\f(CW/etc/X11\fP.  This includes configuration data such as
\f(CWsystem.twmrc\fP even if it is only made a symbolic link to a more
global configuration file (probably in \f(CW/usr/X11R6/lib/X11\fP).
.\" we might want to specify locations for fonts and font information
.FE
.\" -------------------------------------------------------------------
.SH "/usr/lib<qual> : Alternate format libraries (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
\f(CW/usr/lib<qual>\fP performs the same role as \f(CW/usr/lib\fP for an
alternate binary format, except that the symbolic links
\f(CW/usr/lib<qual>/sendmail\fP and \f(CW/usr/lib<qual>/X11\fP are not required.\*F
.FS
The case where \f(CW/usr/lib\fP and \f(CW/usr/lib<qual>\fP are the
same (one is a symbolic link to the other) these files and the
per-application subdirectories will exist.
.FE
.\" -------------------------------------------------------------------
.SH "/usr/local : Local hierarchy"
.LI
.LE
.P
.P
.SS "Purpose"
The \f(CW/usr/local\fP hierarchy is for use by the system administrator
when installing software locally.  It needs to be safe from being
overwritten when the system software is updated.  It may be used for
programs and data that are shareable amongst a group of hosts, but not
found in \f(CW/usr\fP.
.P
Locally installed software must be placed within \f(CW/usr/local\fP
rather than \f(CW/usr\fP unless it is being installed to replace or
upgrade software in \f(CW/usr\fP.\*F
.FS
Software placed in \f(CW/\fP or \f(CW/usr\fP may be
overwritten by system upgrades (though we recommend that distributions
do not overwrite data in \f(CW/etc\fP under these circumstances).  For
this reason, local software must not be placed outside of
\f(CW/usr/local\fP without good reason.
.FE
.SS "Requirements"
The following directories, or symbolic links to directories, must be in \f(CW/usr/local\fP
.PS
copy "dirgraph.pic"
dir("/usr/local","Local hierarchy")
sub("bin","Local binaries")
sub("games","Local game binaries")
sub("include","Local C header files")
sub("lib","Local libraries")
sub("man","Local online manuals")
sub("sbin","Local system binaries")
sub("share","Local architecture-independent hierarchy")
sub("src","Local source code")
.PE
.P
No other directories, except those listed below, may be in
\f(CW/usr/local\fP after first installing a \*(Fs-compliant system.
.SS "Specific Options"
If directories \f(CW/lib<qual>\fP or \f(CW/usr/lib<qual>\fP exist, the
equivalent directories must also exist in \f(CW/usr/local\fP.
.\" -------------------------------------------------------------------
.SH "/usr/sbin : Non-essential standard system binaries"
.LI
.LE
.P
.P
.SS "Purpose"
This directory contains any non-essential binaries used exclusively by
the system administrator.  System administration programs that are
required for system repair, system recovery, mounting \f(CW/usr\fP, or
other essential functions must be placed in \f(CW/sbin\fP instead.\*F
.FS
Locally installed system administration programs should be placed in
\f(CW/usr/local/sbin\fP.
.FE
.\" -------------------------------------------------------------------
.SH "/usr/share : Architecture-independent data"
.LI
.LE
.P
.SS "Purpose"
The \f(CW/usr/share\fP hierarchy is for all read-only architecture
independent data files.\*F
.FS
Much of this data originally lived in \f(CW/usr\fP (\f(CWman\fP,
\f(CWdoc\fP) or \f(CW/usr/lib\fP (\f(CWdict\fP, \f(CWterminfo\fP,
\f(CWzoneinfo\fP).
.FE
.P
This hierarchy is intended to be shareable among all architecture
platforms of a given OS; thus, for example, a site with i386, Alpha, and
PPC platforms might maintain a single \f(CW/usr/share\fP directory that
is centrally-mounted.  Note, however, that \f(CW/usr/share\fP is
generally not intended to be shared by different OSes or by different
releases of the same OS.
.P
Any program or package which contains or requires data that doesn't need
to be modified should store that data in \f(CW/usr/share\fP (or
\f(CW/usr/local/share\fP, if installed locally).  It is recommended that a
subdirectory be used in \f(CW/usr/share\fP for this purpose.
.P
Game data stored in \f(CW/usr/share/games\fP must be purely static data.
Any modifiable files, such as score files, game play logs, and so forth,
should be placed in \f(CW/var/games\fP.
.P
.SS "Requirements"
The following directories, or symbolic links to directories, must be in \f(CW/usr/share\fP
.PS
copy "dirgraph.pic"
dir("/usr/share","Architecture-independent data")
sub("man","Online manuals")
sub("misc","Miscellaneous architecture-independent data")
.PE
.SS "Specific Options"
The following directories, or symbolic links to directories, must be in \f(CW/usr/share\fP, if the corresponding
subsystem is installed:
.PS
copy "dirgraph.pic"
dir("/usr/share","Architecture-independent data")
sub("dict","Word lists (optional)")
sub("doc","Miscellaneous documentation (optional)")
sub("games","Static data files for \f(CW/usr/games\fP (optional)")
sub("info","GNU Info system's primary directory (optional)")
sub("locale","Locale information (optional)")
sub("nls","Message catalogs for Native language support (optional)")
sub("sgml","SGML and XML data (optional)")
sub("terminfo","Directories for terminfo database (optional)")
sub("tmac","troff macros not distributed with groff (optional)")
sub("zoneinfo","Timezone information and configuration (optional)")
.PE
.P
It is recommended that application-specific, architecture-independent
directories be placed here.  Such directories include \f(CWgroff\fP,
\f(CWperl\fP, \f(CWghostscript\fP, \f(CWtexmf\fP, and
\f(CWkbd\fP (Linux) or \f(CWsyscons\fP (BSD).  They may, however, be
placed in \f(CW/usr/lib\fP for backwards compatibility, at the
distributor's discretion.  Similarly, a \f(CW/usr/lib/games\fP
hierarchy may be used in addition to the \f(CW/usr/share/games\fP
hierarchy if the distributor wishes to place some game data there.
.\"
.\" Note: groff support files should be installed in /usr/share/groff
.\" to simplify groff upgrading on Linux systems, rather than the
.\" distribution of groff files found on current BSD systems.
.\" -------------------------------------------------------------------
.SH "/usr/share/dict : Word lists (optional)"
.LI
.LE
.P
.\" -------------------------------------------------------------------
.SS "Purpose"
This directory is the home for word lists on the system;
Traditionally this directory contains only the English \f(CWwords\fP
file, which is used by \f(CWlook(1)\fP and various spelling programs.
\f(CWwords\fP may use either American or British spelling.
.\" -------------------------------------------------------------------
.StartRationale
The reason that only word lists are located here is that they are the
only files common to all spell checkers.
.EndRationale
.\" -------------------------------------------------------------------
.SS "Specific Options"
The following files, or symbolic links to files, must be in \f(CW/usr/share/dict\fP, if the corresponding
subsystem is installed:
.TS
tab(@);
lfCW l.
words@List of English words (optional)
.TE
.P
Sites that require both American and British spelling may link
\f(CWwords\fP to \f(CW\%/usr/share/dict/american-english\fP or
\f(CW\%/usr/share/dict/british-english\fP.
.P
Word lists for other languages may be added using the English name for
that language, e.g., \f(CW/usr/share/dict/french\fP,
\f(CW/usr/share/dict/danish\fP, etc.  These should, if possible, use an
ISO 8859 character set which is appropriate for the language in
question; if possible the Latin1 (ISO 8859-1) character set should be
used (this is often not possible).
.P
Other word lists must be included here, if present.
.\" -------------------------------------------------------------------
.SH "/usr/share/man : Manual pages"
.LI
.LE
.P
.P
.SS "Purpose"
This section details the organization for manual pages throughout the
system, including \f(CW/usr/share/man\fP.  Also refer to the section on
\f(CW/var/cache/man\fP.
.P
The primary \f(CW<mandir>\fP of the system is \f(CW/usr/share/man\fP.
\f(CW/usr/share/man\fP contains manual information for commands and data under
the \f(CW/\fP and \f(CW/usr\fP filesystems.\*F
.FS
Obviously, there are no manual pages in \f(CW/\fP because they are
not required at boot time nor are they required in emergencies.\*F
.FE
.FS
Really.
.FE
.P
Manual pages are stored in \f(CW<mandir>/<locale>/man<section>/<arch>\fP.
An explanation of \f(CW<mandir>\fP, \f(CW<locale>\fP, \f(CW<section>\fP,
and \f(CW<arch>\fP is given below.
.P
A description of each section follows:
.BL
.LI
\f(CWman1\fP: User programs
.br
Manual pages that describe publicly accessible commands are contained in
this chapter.  Most program documentation that a user will need to use
is located here.
.LI
\f(CWman2\fP: System calls
.br
This section describes all of the system calls (requests for the
kernel to perform operations).
.\" delete parenthesized remark?  assume technical background?
.LI
\f(CWman3\fP: Library functions and subroutines
.br
Section 3 describes program library routines that are not direct calls
to kernel services.  This and chapter 2 are only really of interest to
programmers.
.LI
\f(CWman4\fP: Special files
.br
Section 4 describes the special files, related driver functions, and
networking support available in the system.  Typically, this includes
the device files found in \f(CW/dev\fP and the kernel interface to
networking protocol support.
.LI
\f(CWman5\fP: File formats
.br
The formats for many data files are documented in the
section 5.  This includes various include files, program output files,
and system files.
.LI
\f(CWman6\fP: Games
.br
This chapter documents games, demos, and generally trivial programs.
Different people have various notions about how essential this is.
.LI
\f(CWman7\fP: Miscellaneous
.br
Manual pages that are difficult to classify are designated as being
section 7.  The troff and other text processing macro packages are found
here.
.LI
\f(CWman8\fP: System administration
.br
Programs used by system administrators for system operation and
maintenance are documented here.  Some of these programs are also
occasionally useful for normal users.
.LE
.SS "Specific Options"
The following directories, or symbolic links to directories, must be in
\f(CW/usr/share/<mandir>/<locale>\fP, unless they are empty:\*F
.FS
For example, if \f(CW/usr/local/man\fP has no manual pages in
section 4 (Devices), then \f(CW/usr/local/man/man4\fP may be
omitted.
.FE
.PS
copy "dirgraph.pic"
dir("<mandir>/<locale>","A manual page hierarchy")
sub("man1","User programs (optional)")
sub("man2","System calls (optional)")
sub("man3","Library calls (optional)")
sub("man4","Special files (optional)")
sub("man5","File formats (optional)")
sub("man6","Games (optional)")
sub("man7","Miscellaneous (optional)")
sub("man8","System administration (optional)")
.PE
.P
The component \f(CW<section>\fP describes the manual section.
.P
Provisions must be made in the structure of \f(CW/usr/share/man\fP to support
manual pages which are written in different (or multiple) languages.
These provisions must take into account the storage and reference of
these manual pages.  Relevant factors include language (including
geographical-based differences), and character code set.
.P
This naming of language subdirectories of \f(CW/usr/share/man\fP is based on
Appendix E of the POSIX 1003.1 standard which describes the locale
identification string \(em the most well-accepted method to describe a
cultural environment.  The \f(CW<locale>\fP string is:
.P 1
\f(CW<language>[_<territory>][.<character-set>][,<version>]\fP
.P
The \f(CW<language>\fP field must be taken from ISO 639 (a code for the
representation of names of languages).  It must be two characters wide
and specified with lowercase letters only.
.P
The \f(CW<territory>\fP field must be the two-letter code of ISO 3166
(a specification of representations of countries), if possible.  (Most
people are familiar with the two-letter codes used for the country codes
in email addresses.\*F) It must be two characters wide and specified
with uppercase letters only.
.FS
A major exception to this rule is the United Kingdom, which is `GB' in
the ISO 3166, but `UK' for most email addresses.
.FE
.P
The \f(CW<character-set>\fP field must represent the standard
describing the character set.  If the \f(CW\%<character-set>\fP field is
just a numeric specification, the number represents the number of the
international standard describing the character set.  It is recommended
that this be a numeric representation if possible (ISO standards,
especially), not include additional punctuation symbols, and that any
letters be in lowercase.
.P
A parameter specifying a \f(CW<version>\fP of the profile may be placed
after the \f(CW\%<character-set>\fP field, delimited by a comma.  This
may be used to discriminate between different cultural needs; for
instance, dictionary order versus a more systems-oriented collating
order.  This standard recommends not using the \f(CW<version>\fP field,
unless it is necessary.
.P
Systems which use a unique language and code set for all manual pages
may omit the \f(CW<locale>\fP substring and store all manual pages in
\f(CW<mandir>\fP.  For example, systems which only have English manual
pages coded with ASCII, may store manual pages (the
\f(CWman<section>\fP directories) directly in \f(CW/usr/share/man\fP.
(That is the traditional circumstance and arrangement, in fact.)
.P
Countries for which there is a well-accepted standard character code set
may omit the \f(CW\%<character-set>\fP field, but it is strongly
recommended that it be included, especially for countries with several
competing standards.
.P
Various examples:
.TS
l l l l
l l l lfCW.
Language	Territory	Character Set	Directory
_
English	\(em	ASCII	/usr/share/man/en
English	United Kingdom	ASCII	/usr/share/man/en_GB
English	United States	ASCII	/usr/share/man/en_US
French	Canada	ISO 8859-1	/usr/share/man/fr_CA
French	France	ISO 8859-1	/usr/share/man/fr_FR
German	Germany	ISO 646	/usr/share/man/de_DE.646
German	Germany	ISO 6937	/usr/share/man/de_DE.6937
German	Germany	ISO 8859-1	/usr/share/man/de_DE.88591
German	Switzerland	ISO 646	/usr/share/man/de_CH.646
Japanese	Japan	JIS	/usr/share/man/ja_JP.jis
Japanese	Japan	SJIS	/usr/share/man/ja_JP.sjis
Japanese	Japan	UJIS (or EUC-J)	/usr/share/man/ja_JP.ujis
.TE
.P
Similarly, provision must be made for manual pages which are
architecture-dependent, such as documentation on device-drivers or
low-level system administration commands.  These must be placed under an
\f(CW<arch>\fP directory in the appropriate \f(CWman<section>\fP directory;
for example, a man page for the i386 ctrlaltdel(8) command might be
placed in \f(CW/usr/share/man/<locale>/man8/i386/ctrlaltdel.8\fP.
.P
Manual pages for commands and data under \f(CW/usr/local\fP are stored
in \f(CW/usr/local/man\fP.  Manual pages for X11R6 are
stored in \f(CW/usr/X11R6/man\fP.  It follows that all manual page
hierarchies in the system must have the same structure as
\f(CW/usr/share/man\fP.
.\" -------------------------------------------------------------------
.P
The cat page sections (\f(CWcat<section>\fP) containing formatted manual
page entries are also found within subdirectories of
\f(CW<mandir>/<locale>\fP, but are not required nor may they be
distributed in lieu of nroff source manual pages.
.\" other subdirectories, ps<section>, dvi<section>, html<section> may
.\" be here eventually
.\" revise
.P
The numbered sections "1" through "8" are traditionally defined.  In
general, the file name for manual pages located within a particular
section end with \f(CW.<section>\fP.
.P
In addition, some large sets of application-specific manual pages have
an additional suffix appended to the manual page filename.  For example,
the MH mail handling system manual pages must have \f(CWmh\fP appended
to all MH manuals.  All X Window System manual pages must have an
\f(CWx\fP appended to the filename.
.P
The practice of placing various language manual pages in appropriate
subdirectories of \f(CW/usr/share/man\fP also applies to the other manual page
hierarchies, such as \f(CW/usr/local/man\fP and \f(CW/usr/X11R6/man\fP.
(This portion of the standard also applies later in the section on the
optional \f(CW/var/cache/man\fP structure.)
.P
.\" -------------------------------------------------------------------
.SH "/usr/share/misc : Miscellaneous architecture-independent data"
.LI
.LE
.P
.P
This directory contains miscellaneous architecture-independent files
which don't require a separate subdirectory under \f(CW/usr/share\fP.
.P
.SS "Specific Options"
The following files, or symbolic links to files, must be in \f(CW/usr/share/misc\fP, if the corresponding
subsystem is installed:
.TS
tab(@);
lfCW l.
ascii@ASCII character set table (optional)
magic@Default list of magic numbers for the file command (optional)
termcap@Terminal capability database (optional)
termcap.db@Terminal capability database (optional)
.TE
.P
Other (application-specific) files may appear here,\*F but a distributor
may place them in \f(CW/usr/lib\fP at their discretion.
.FS
Some such files include:
.VL 2
.LI "\f(CW{"
airport, birthtoken, eqnchar, getopt, gprof.callg, gprof.flat,
inter.phone, ipfw.samp.filters, ipfw.samp.scripts, keycap.pcvt, mail.help,
mail.tildehelp, man.template, map3270, mdoc.template, more.help, na.phone,
nslookup.help, operator, scsi_modes, sendmail.hf, style, units.lib,
vgrindefs, vgrindefs.db, zipcodes }\fP
.LE
.FE
.\" -------------------------------------------------------------------
.SH "/usr/share/sgml : SGML and XML data (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
\f(CW/usr/share/sgml\fP contains architecture-independent files used by
SGML or XML applications, such as ordinary catalogs (not the centralized
ones, see \f(CW/etc/sgml\fP), DTDs, entities, or style sheets.
.SS "Specific Options"
The following directories, or symbolic links to directories, must be in \f(CW/usr/share/sgml\fP, if the
corresponding subsystem is installed:
.PS
copy "dirgraph.pic"
dir("/usr/share/sgml","SGML and XML data")
sub("docbook","docbook DTD (optional)")
sub("tei","tei DTD (optional)")
sub("html","html DTD (optional)")
sub("mathml","mathml DTD (optional)")
.PE
Other files that are not specific to a given DTD may reside in their own
subdirectory.
.\" -------------------------------------------------------------------
.SH "/usr/src : Source code (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
Any non-local source code should be placed in this subdirectory.
.\" -------------------------------------------------------------------
.SS "The /var Hierarchy"
.SS "Purpose"
.P
\f(CW/var\fP contains variable data files.  This includes spool
directories and files, administrative and logging data, and transient
and temporary files.
.P
Some portions of \f(CW/var\fP are not shareable between different
systems.  For instance, \f(CW/var/log\fP, \f(CW/var/lock\fP, and
\f(CW/var/run\fP.  Other portions may be shared, notably
\f(CW/var/mail\fP, \f(CW/var/cache/man\fP, \f(CW/var/cache/fonts\fP,
and \f(CW/var/spool/news\fP.
.P
\f(CW/var\fP is specified here in order to make it possible to mount
\f(CW/usr\fP read-only.  Everything that once went into \f(CW/usr\fP
that is written to during system operation (as opposed to installation
and software maintenance) must be in \f(CW/var\fP.
.P
If \f(CW/var\fP cannot be made a separate partition, it is often
preferable to move \f(CW/var\fP out of the root partition and into the
\f(CW/usr\fP partition.  (This is sometimes done to reduce the size of
the root partition or when space runs low in the root partition.)
However, \f(CW/var\fP must not be linked to \f(CW/usr\fP because this
makes separation of \f(CW/usr\fP and \f(CW/var\fP more difficult and is
likely to create a naming conflict.  Instead, link \f(CW/var\fP to
\f(CW/usr/var\fP.
.P
Applications must generally not add directories to the top level of
\f(CW/var\fP.  Such directories should only be added if they have some
system-wide implication, and in consultation with the \*(Fs mailing list.
.SS "Requirements"
The following directories, or symbolic links to directories, are required in \f(CW/var\fP.
.PS
copy "dirgraph.pic"
dir("/var","Variable data")
sub("cache","Application cache data")
sub("lib","Variable state information")
sub("local","Variable data for /usr/local")
sub("lock","Lock files")
sub("log","Log files and directories")
sub("opt","Variable data for /opt")
sub("run","Data relevant to running processes")
sub("spool","Application spool data")
sub("tmp","Temporary files preserved between system reboots")
.PE
.P
Several directories are `reserved' in the sense that they must not be
used arbitrarily by some new application, since they would conflict
with historical and/or local practice.  They are:
.P
.nf
.ft CW
    /var/backups
    /var/cron
    /var/msgs
    /var/preserve
.ft P
.fi
.P
.SS "Specific Options"
The following directories, or symbolic links to directories, must be in \f(CW/var\fP, if the
corresponding subsystem is installed:
.PS
copy "dirgraph.pic"
dir("/var","Variable data")
sub("account","Process accounting logs (optional)")
sub("crash","System crash dumps (optional)")
sub("games","Variable game data (optional)")
sub("mail","User mailbox files (optional)")
sub("yp","Network Information Service (NIS) database files (optional)")
.PE
.\" -------------------------------------------------------------------
.SH "/var/account : Process accounting logs (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
This directory holds the current active process accounting log and the
composite process usage data (as used in some \*(Ux-like systems by
\f(CWlastcomm\fP and \f(CWsa\fP).
.\" -------------------------------------------------------------------
.SH "/var/cache : Application cache data"
.LI
.LE
.P
.SS "Purpose"
\f(CW/var/cache\fP is intended for cached data from applications.  Such
data is locally generated as a result of time-consuming I/O or
calculation.  The application must be able to regenerate or restore the
data.  Unlike \f(CW/var/spool\fP, the cached files can be deleted
without data loss.  The data must remain valid between invocations of
the application and rebooting the system.
.P
Files located under \f(CW/var/cache\fP may be expired in an application
specific manner, by the system administrator, or both.  The application
must always be able to recover from manual deletion of these files
(generally because of a disk space shortage).  No other requirements are
made on the data format of the cache directories.
.P
.\" -------------------------------------------------------------------
.StartRationale
The existence of a separate directory for cached data allows system
administrators to set different disk and backup policies from other
directories in \f(CW/var\fP.
.EndRationale
.\" -------------------------------------------------------------------
.P
.SS "Specific Options"
.PS
copy "dirgraph.pic"
dir("/var/cache","Cache directories")
sub("fonts","Locally-generated fonts (optional)")
sub("man","Locally-formatted manual pages (optional)")
sub("www","WWW proxy or cache data (optional)")
sub("<package>","Package specific cache data (optional)")
.PE
.P
.SH "/var/cache/fonts : Locally-generated fonts (optional)"
.LI
.LE
.P
.SS "Purpose"
.P
The directory \f(CW/var/cache/fonts\fP should be used to store any
dynamically-created fonts.  In particular, all of the fonts which are
automatically generated by \f(CWmktexpk\fP must be located in
appropriately-named subdirectories of \f(CW/var/cache/fonts\fP.\*F
.FS
This standard does not currently incorporate the \*(Tx Directory
Structure (a document that describes the layout \*(Tx files and
directories), but it may be useful reading.  It is located at
\f(CWftp://ctan.tug.org/tex/\fP.
.FE
.SS "Specific Options"
Other dynamically created fonts may also be placed in this tree, under
appropriately-named subdirectories of \f(CW/var/cache/fonts\fP.
.\" -------------------------------------------------------------------
.SH "/var/cache/man : Locally-formatted manual pages (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
This directory provides a standard location for sites that provide a
read-only \f(CW/usr\fP partition, but wish to allow caching of
locally-formatted man pages.  Sites that mount \f(CW/usr\fP as writable
(e.g., single-user installations) may choose not to use
\f(CW/var/cache/man\fP and may write formatted man pages into the
\f(CWcat<section>\fP directories in \f(CW/usr/share/man\fP directly.  We
recommend that most sites use one of the following options instead:
.BL
.LI
Preformat all manual pages alongside the unformatted versions.
.LI
Allow no caching of formatted man pages, and require formatting to be
done each time a man page is brought up.
.LI
Allow local caching of formatted man pages in \f(CW/var/cache/man\fP.
.LE
.P
The structure of \f(CW/var/cache/man\fP needs to reflect both the fact of
multiple man page hierarchies and the possibility of multiple language
support.
.P
Given an unformatted manual page that normally appears in
\f(CW<path>/man/<locale>/man<section>\fP, the directory to place formatted
man pages in is \f(CW/var/cache/man/<catpath>/<locale>/cat<section>\fP,
where \f(CW<catpath>\fP is derived from \f(CW<path>\fP by removing any
leading \f(CWusr\fP and/or trailing \f(CWshare\fP pathname components.\*F
(Note that the \f(CW<locale>\fP component may be missing.)
.\" Note that /usr/local/man and /local/man will conflict, if some
.\" system administrator is flakey enough to use both for different things.
.FS
For example, \f(CW/usr/share/man/man1/ls.1\fP is
formatted into \f(CW/var/cache/man/cat1/ls.1\fP, and
\f(CW/usr/X11R6/man/<locale>/man3/XtClass.3x\fP into
\f(CW/var/cache/man/X11R6/<locale>/cat3/XtClass.3x\fP.
.FE
.P
Man pages written to \f(CW/var/cache/man\fP may eventually be
transferred to the appropriate preformatted directories in the source
\f(CWman\fP hierarchy or expired; likewise
formatted man pages in the source \f(CWman\fP hierarchy may be expired if
they are not accessed for a period of time.
.P
If preformatted manual pages come with a system on read-only media
(a CD-ROM, for instance), they must be installed in the source
\f(CWman\fP hierarchy (e.g. \f(CW/usr/share/man/cat<section>\fP).
\f(CW/var/cache/man\fP is reserved as a writable cache for formatted
manual pages.
.\" -------------------------------------------------------------------
.StartRationale
Release 1.2 of the standard specified \f(CW/var/catman\fP for this
hierarchy.  The path has been moved under \f(CW/var/cache\fP to better
reflect the dynamic nature of the formatted man pages.  The directory
name has been changed to \f(CWman\fP to allow for enhancing the hierarchy
to include post-processed formats other than "cat", such as PostScript,
HTML, or DVI.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/var/crash : System crash dumps (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
This directory holds system crash dumps.  As of the date of this release
of the standard, system crash dumps were not supported under Linux.
.\" -------------------------------------------------------------------
.SH "/var/games : Variable game data (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
Any variable data relating to games in \f(CW/usr\fP should be placed
here.  \f(CW/var/games\fP should hold the variable data previously found
in \f(CW/usr\fP; static data, such as help text, level descriptions, and
so on, must remain elsewhere, such as \f(CW/usr/share/games\fP.
.\" XXX: deprecate /var/games in favor of /var/lib
.\" -------------------------------------------------------------------
.StartRationale
\f(CW/var/games\fP has been given a hierarchy of its own, rather
than leaving it merged in with the old \f(CW/var/lib\fP as in release
1.2.  The separation allows local control of backup strategies,
permissions, and disk usage, as well as allowing inter-host sharing
and reducing clutter in \f(CW/var/lib\fP.  Additionally, \f(CW/var/games\fP
is the path traditionally used by BSD.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/var/lib : Variable state information"
.LI
.LE
.P
.SS "Purpose"
.P
This hierarchy holds state information pertaining to an application or
the system.  State information is data that programs modify while they
run, and that pertains to one specific host.  Users must never need
to modify files in \f(CW/var/lib\fP to configure a package's operation.
.P
State information is generally used to preserve the condition of an
application (or a group of inter-related applications) between
invocations and between different instances of the same application.
State information should generally remain valid after a reboot,
.\" (but note that emacs/lock is an exception to this),
should not be logging output, and should not be spooled data.
.P
An application (or a group of inter-related applications) must
use a subdirectory of \f(CW/var/lib\fP for its data.\*F  There is one
required subdirectory, \f(CW/var/lib/misc\fP, which is intended for
state files that don't need a subdirectory; the other subdirectories
should only be present if the application in question is included in
the distribution.
.FS
An important difference between this version of this standard and
previous ones is that applications are now required to use a
subdirectory of \f(CW/var/lib\fP.
.FE
.P
\f(CW/var/lib/<name>\fP is the location that must be used for all
distribution packaging support.  Different distributions may use
different names, of course.
.P
.SS "Requirements"
The following directories, or symbolic links to directories, are required in \f(CW/var/lib\fP:
.PS
copy "dirgraph.pic"
dir("/var/lib","Variable state information")
sub("misc","Miscellaneous state data")
.PE
.SS "Specific Options"
The following directories, or symbolic links to directories, must be in \f(CW/var/lib\fP, if the
corresponding subsystem is installed:
.PS
copy "dirgraph.pic"
dir("/var/lib","Variable state information")
sub("<editor>","Editor backup files and state (optional)")
sub("<pkgtool>","Packaging support files (optional)")
sub("<package>","State data for packages and subsystems (optional)")
sub("hwclock","State directory for hwclock (optional)")
sub("xdm","X display manager variable data (optional)")
.PE
.\" -------------------------------------------------------------------
.SH "/var/lib/<editor> : Editor backup files and state (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
These directories contain saved files generated by any unexpected
termination of an editor (e.g., elvis, jove, nvi).
.P
Other editors may not require a directory for crash-recovery files, but
may require a well-defined place to store other information while the
editor is running.  This information should be stored in a subdirectory
under \f(CW/var/lib\fP (for example, GNU Emacs would place lock files
in \f(CW/var/lib/emacs/lock\fP).
.P
Future editors may require additional state information beyond
crash-recovery files and lock files \(em this information should also be
placed under \f(CW/var/lib/<editor>\fP.
.\" -------------------------------------------------------------------
.StartRationale
Previous Linux releases, as well as all commercial vendors, use
\f(CW/var/preserve\fP for vi or its clones.  However, each editor uses
its own format for these crash-recovery files, so a separate directory
is needed for each editor.
.P
Editor-specific lock files are usually quite different from the device
or resource lock files that are stored in \f(CW/var/lock\fP and, hence,
are stored under \f(CW/var/lib\fP.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/var/lib/hwclock : State directory for hwclock (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
This directory contains the file \f(CW/var/lib/hwclock/adjtime\fP.
.\" -------------------------------------------------------------------
.StartRationale
In \*(Fs 2.1, this file was \f(CW/etc/adjtime\fP, but as \f(CWhwclock\fP
updates it, that was obviously incorrect.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/var/lib/misc : Miscellaneous variable data"
.LI
.LE
.P
.P
.SS "Purpose"
This directory contains variable data not placed in a subdirectory in
\f(CW/var/lib\fP.  An attempt should be made to use relatively unique
names in this directory to avoid namespace conflicts.\*F
.FS
This hierarchy should contain files stored in \f(CW/var/db\fP
in current BSD releases.  These include \f(CWlocate.database\fP and
\f(CWmountdtab\fP, and the kernel symbol database(s).
.FE
.\" -------------------------------------------------------------------
.SH "/var/lock : Lock files"
.LI
.LE
.P
.P
.SS "Purpose"
Lock files should be stored within the \f(CW/var/lock\fP directory structure.
.P
Lock files for devices and other resources shared by multiple applications, such as the serial device lock files that were
originally found in either \f(CW/usr/spool/locks\fP or
\f(CW/usr/spool/uucp\fP, must now be stored in \f(CW/var/lock\fP.  The
naming convention which must be used is
.ie t \{\
\f(CWLCK..\fP followed by the base name of the device file.  For example, to
lock \f(CW/dev/ttyS0\fP the file \f(CWLCK..ttyS0\fP would be created.
\}
.el \{\
"LCK.." followed by the base name of the device.  For example, to lock
/dev/ttyS0 the file "LCK..ttyS0" would be created.
\}
\*F
.FS
Then, anything wishing to use \f(CW/dev/ttyS0\fP can read the lock file
and act accordingly (all locks in \f(CW/var/lock\fP should be
world-readable).
.FE
.P
The format used for the contents of such lock files must be the HDB UUCP lock
file format.  The HDB format is to store the process identifier (PID) as
a ten byte ASCII decimal number, with a trailing newline.  For
example, if process 1230 holds a lock file, it would contain the eleven
characters: space, space, space, space, space, space, one, two, three,
zero, and newline.
.\" Some versions of UUCP add a second line indicating which program created
.\" the lock (uucp, cu, or getty).
.\" -------------------------------------------------------------------
.SH "/var/log : Log files and directories"
.LI
.LE
.P
.P
.SS "Purpose"
This directory contains miscellaneous log files.  Most logs must be
written to this directory or an appropriate subdirectory.
.SS "Specific Options"
The following files, or symbolic links to files, must be in \f(CW/var/log\fP, if the
corresponding subsystem is installed:
.TS
tab(@);
lfCW l.
lastlog@record of last login of each user
messages@system messages from \f(CWsyslogd\fP
wtmp@record of all logins and logouts
.TE
.\" -------------------------------------------------------------------
.SH "/var/mail : User mailbox files (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
The mail spool must be accessible through \f(CW/var/mail\fP and the mail
spool files must take the form \f(CW<username>\fP.\*F
.FS
Note that \f(CW/var/mail\fP
may be a symbolic link to another directory.
.FE
.P
User mailbox files in this location must be stored in the standard
\*(Ux mailbox format.
.\" -------------------------------------------------------------------
.StartRationale
The logical location for this directory was changed from
\f(CW/var/spool/mail\fP in order to bring \*(Fs in-line with nearly
every \*(Ux implementation.  This change is important for
inter-operability since a single \f(CW/var/mail\fP is often shared
between multiple hosts and multiple \*(Ux implementations (despite NFS
locking issues).
.P
It is important to note that there is no requirement to physically move
the mail spool to this location.  However, programs and header files
must be changed to use \f(CW/var/mail\fP.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/var/opt : Variable data for /opt"
.LI
.LE
.P
.P
.SS "Purpose"
Variable data of the packages in \f(CW/opt\fP must be installed in
\f(CW/var/opt/<package>\fP, where \f(CW<package>\fP is the name of the
subtree in \f(CW/opt\fP where the static data from an add-on software
package is stored, except where superseded by another file in
\f(CW/etc\fP.  No structure is imposed on the internal arrangement of
\f(CW/var/opt/<package>\fP.
.\" -------------------------------------------------------------------
.StartRationale
Refer to the rationale for \f(CW/opt\fP.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/var/run : Run-time variable data"
.LI
.LE
.P
.P
.SS "Purpose"
This directory contains system information data describing the system
since it was booted.  Files under this directory must be cleared
(removed or truncated as appropriate) at the beginning of the boot
process.  Programs may have a subdirectory of \f(CW/var/run\fP; this is
encouraged for programs that use more than one run-time file.\*F
.FS
\f(CW/var/run\fP should be unwritable for unprivileged users (root or
users running daemons); it is a major security problem if any user can
write in this directory.
.FE
Process identifier (PID) files, which were originally placed in
\f(CW/etc\fP, must be placed in \f(CW/var/run\fP.  The naming
convention for PID files is \f(CW<program-name>.pid\fP.  For example,
the \f(CWcrond\fP PID file is named \f(CW/var/run/crond.pid\fP.
.P
.SS "Requirements"
.P
The internal format of PID files remains unchanged.  The file must
consist of the process identifier in ASCII-encoded decimal,
followed by a newline character.  For example, if \f(CWcrond\fP was
process number 25, \f(CW/var/run/crond.pid\fP would contain three
characters: two, five, and newline.
.P
Programs that read PID files should be somewhat flexible in what they
accept; i.e., they should ignore extra whitespace, leading zeroes,
absence of the trailing newline, or additional lines in the PID file.
Programs that create PID files should use the simple specification
located in the above paragraph.
.P
The \f(CWutmp\fP file, which stores information about who is currently
using the system, is located in this directory.
.P
Programs that maintain transient \*(Ux-domain sockets must place them
in this directory.
.\" -------------------------------------------------------------------
.SH "/var/spool : Application spool data"
.LI
.LE
.P
.SS "Purpose"
\f(CW/var/spool\fP contains data which is awaiting some kind of later
processing.  Data in \f(CW/var/spool\fP represents work to be done in
the future (by a program, user, or administrator); often data is deleted
after it has been processed.\*F
.ig
\f(CW/var/spool\fP is intended for `spooled' data from applications.
Such data remains valid even if the application that created it aborts
and restarts.  Some time after being created, the data is automatically
removed, in an application-specific manner; this is typically when some
event occurs (e.g., lpd prints the file, or sendmail sends it) or a time
limit expires (e.g. a news article).  Data in \f(CW/var/spool\fP is
generally of interest to the user in and of itself, unlike data in
\f(CW/var/lib\fP, which is generally of interest only indirectly.
..
.FS
UUCP lock files must be placed in \f(CW/var/lock\fP.  See the above
section on \f(CW/var/lock\fP.
.FE
.SS "Specific Options"
The following directories, or symbolic links to directories, must be in \f(CW/var/spool\fP, if the
corresponding subsystem is installed:
.PS
copy "dirgraph.pic"
dir("/var/spool","Spool directories")
sub("lpd","Printer spool directory (optional)")
sub("mqueue","Outgoing mail queue (optional)")
sub("news","News spool directory (optional)")
sub("rwho","Rwhod files (optional)")
sub("uucp","Spool directory for UUCP (optional)")
.PE
.P
.\" -------------------------------------------------------------------
.SH "/var/spool/lpd : Line-printer daemon print queues (optional)"
.LI
.LE
.P
.SS "Purpose"
.P
The lock file for \f(CWlpd\fP, \f(CWlpd.lock\fP, must be placed in
\f(CW/var/spool/lpd\fP.  It is suggested that the lock file for each
printer be placed in the spool directory for that specific printer and
named \f(CWlock\fP.
.SS "Specific Options"
.PS
copy "dirgraph.pic"
dir("/var/spool/lpd","Printer spool directory")
sub("<printer>","Spools for a specific printer (optional)")
.PE
.\" -------------------------------------------------------------------
.SH "/var/spool/rwho : Rwhod files (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
This directory holds the \f(CWrwhod\fP information for other systems on
the local net.
.\" -------------------------------------------------------------------
.StartRationale
Some BSD releases use \f(CW/var/rwho\fP for this data; given its
historical location in \f(CW/var/spool\fP on other systems and its
approximate fit to the definition of `spooled' data, this location was
deemed more appropriate.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/var/tmp : Temporary files preserved between system reboots"
.LI
.LE
.P
.P
.SS "Purpose"
The \f(CW/var/tmp\fP directory is made available for programs that require
temporary files or directories that are preserved between system reboots.
Therefore, data stored in \f(CW/var/tmp\fP is more persistent than data
in \f(CW/tmp\fP.
.P
Files and directories located in \f(CW/var/tmp\fP must not be deleted
when the system is booted.  Although data stored in \f(CW/var/tmp\fP
is typically deleted in a site-specific manner, it is recommended that
deletions occur at a less frequent interval than \f(CW/tmp\fP.
.ig
A symbolic link \f(CW/var/tmp/vi.recover\fP to \f(CW/var/lib/nvi\fP
is allowed to support versions of nvi compiled without the path name
suggested in the standard.

Programs must not assume that any files or directories are preserved
between invocations of the program.
..
.\" XXX - Why did the second paragraph get commented out?
.\" -------------------------------------------------------------------
.SH "/var/yp : Network Information Service (NIS) database files (optional)"
.LI
.LE
.P
.P
.SS "Purpose"
Variable data for the Network Information Service (NIS), formerly known
as the Sun Yellow Pages (YP), must be placed in this directory.
.\" -------------------------------------------------------------------
.StartRationale
\f(CW/var/yp\fP is the standard directory for NIS (YP) data and is
almost exclusively used in NIS documentation and systems.\*F
.EndRationale
.FS
NIS should not be confused with Sun NIS+, which uses a different
directory, \f(CW/var/nis\fP.
.FE
.\" -------------------------------------------------------------------
.SS "Operating System Specific Annex"
.P
This section is for additional requirements and recommendations that
only apply to a specific operating system.  The material in this section
should never conflict with the base standard.
.\" -------------------------------------------------------------------
.SS "Linux"
.P
This is the annex for the Linux operating system.
.\" -------------------------------------------------------------------
.SH "/ : Root directory"
.LI
.LE
.P
.P
On Linux systems, if the kernel is located in \f(CW/\fP, we recommend
using the names \f(CWvmlinux\fP or \f(CWvmlinuz\fP, which have been used
in recent Linux kernel source packages.
.\" -------------------------------------------------------------------
.SH "/bin : Essential user command binaries (for use by all users)"
.LI
.LE
.P
.P
Linux systems which require them place these additional files into
\f(CW/bin\fP.
.VL 2
.LI "\f(CW{"
setserial }\fP
.LE
.P
.\" -------------------------------------------------------------------
.SH "/dev : Devices and special files"
.LI
.LE
.P
.P
All devices and special files in \f(CW/dev\fP should adhere to the
\fILinux Allocated Devices\fP document, which is available with the
Linux kernel source.  It is maintained by H. Peter Anvin
<hpa@zytor.com>.
.P
Symbolic links in \f(CW/dev\fP should not be distributed with Linux
systems except as provided in the \fILinux Allocated Devices\fP
document.
.\" -------------------------------------------------------------------
.StartRationale
The requirement not to make symlinks promiscuously is made because local
setups will often differ from that on the distributor's development
machine.  Also, if a distribution install script configures the symbolic
links at install time, these symlinks will often not get updated if
local changes are made in hardware.  When used responsibly at a local
level, however, they can be put to good use.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/etc : Host-specific system configuration"
.LI
.LE
.P
.P
Linux systems which require them place these additional files into
\f(CW/etc\fP.
.VL 2
.LI "\f(CW{"
lilo.conf }\fP
.LE
.P
\" -------------------------------------------------------------------
.SH "/proc : Kernel and process information virtual filesystem"
.LI
.LE
.P
.P
The \f(CWproc\fP filesystem is the de-facto standard Linux method for
handling process and system information, rather than \f(CW/dev/kmem\fP
and other similar methods.  We strongly encourage this for the storage
and retrieval of process information as well as other kernel and memory
information.
.\" -------------------------------------------------------------------
.SH "/sbin : Essential system binaries"
.LI
.LE
.P
.P
Linux systems place these additional files into \f(CW/sbin\fP.
.BL
.LI
Second extended filesystem commands (optional):
.VL 2
.LI "\f(CW{"
badblocks, dumpe2fs, e2fsck, mke2fs, mklost+found, tune2fs }\fP
.LE
.LI
Boot-loader map installer (optional):
.VL 2
.LI "\f(CW{"
lilo }\fP
.LE
.\" -------------------------------------------------------------------
.SH "Optional files for /sbin:"
.LI
.LE
.P
.BL
.LI
Static binaries:
.SP
.VL 2
.LI "\f(CW{"
ldconfig, sln, ssync }\fP
.LE
.P
Static \f(CWln\fP (\f(CWsln\fP) and static \f(CWsync\fP (\f(CWssync\fP)
are useful when things go wrong.  The primary use of \f(CWsln\fP (to
repair incorrect symlinks in \f(CW/lib\fP after a poorly orchestrated
upgrade) is no longer a major concern now that the \f(CWldconfig\fP
program (usually located in \f(CW/usr/sbin\fP) exists and can act as a
guiding hand in upgrading the dynamic libraries.  Static \f(CWsync\fP is
useful in some emergency situations.  Note that these need not be
statically linked versions of the standard \f(CWln\fP and \f(CWsync\fP,
but may be.
.P
The \f(CWldconfig\fP binary is optional for \f(CW/sbin\fP since a site
may choose to run \f(CWldconfig\fP at boot time, rather than only when
upgrading the shared libraries.  (It's not clear whether or not it is
advantageous to run \f(CWldconfig\fP on each boot.)  Even so, some
people like \f(CWldconfig\fP around for the following (all too common)
situation:
.LB 8 4 " " 3
.LI
I've just removed \f(CW/lib/<file>\fP.
.LI
I can't find out the name of the library because \f(CWls\fP is
dynamically linked, I'm using a shell that doesn't have \f(CWls\fP
built-in, and I don't know about using "\f(CWecho *\fP" as a
replacement.
.LI
I have a static \f(CWsln\fP, but I don't know what to call the link.
.LE
.LI
Miscellaneous:
.SP
.VL 2
.LI "\f(CW{"
ctrlaltdel, kbdrate }\fP
.LE
.P
So as to cope with the fact that some keyboards come up with such a high
repeat rate as to be unusable, \f(CWkbdrate\fP may be installed in
\f(CW/sbin\fP on some systems.
.\" should we advise installing this?
.P
Since the default action in the kernel for the Ctrl-Alt-Del key
combination is an instant hard reboot, it is generally advisable to
disable the behavior before mounting the root filesystem in read-write
mode.  Some \f(CWinit\fP suites are able to disable Ctrl-Alt-Del, but
others may require the \f(CWctrlaltdel\fP program, which may be
installed in \f(CW/sbin\fP on those systems.
.LE
.\" -------------------------------------------------------------------
.SH "/usr/include : Header files included by C programs"
.LI
.LE
.P
.P
These symbolic links are required if a C or C++ compiler is installed
and only for systems not based on glibc.
.P
.nf
.ft CW
    /usr/include/asm -> /usr/src/linux/include/asm-<arch>
    /usr/include/linux -> /usr/src/linux/include/linux
.ft P
.fi
.\" -------------------------------------------------------------------
.SH "/usr/src : Source code"
.LI
.LE
.P
.P
For systems based on glibc, there are no specific guidelines for this
directory.  For systems based on Linux libc revisions prior to glibc,
the following guidelines and rationale apply:
.P
The only source code that should be placed in a specific location is the
Linux kernel source code.  It is located in \f(CW/usr/src/linux\fP.
.P
If a C or C++ compiler is installed, but the complete Linux kernel
source code is not installed, then the include files from the kernel
source code must be located in these directories:
.P
.nf
.ft CW
    /usr/src/linux/include/asm-<arch>
    /usr/src/linux/include/linux
.ft P
.fi
.P
\f(CW<arch>\fP is the name of the system architecture.
.P
.ft I
Note: \f(CW/usr/src/linux\fP may be a symbolic link to a kernel source
code tree.
.ft P
.\" -------------------------------------------------------------------
.StartRationale
It is important that the kernel include files be located in
\f(CW/usr/src/linux\fP and not in \f(CW/usr/include\fP so there are no
problems when system administrators upgrade their kernel version for the
first time.
.EndRationale
.\" -------------------------------------------------------------------
.SH "/var/spool/cron : cron and at jobs"
.LI
.LE
.P
.P
This directory contains the variable data for the \f(CWcron\fP and
\f(CWat\fP programs.
.SK
.\" -------------------------------------------------------------------
.\" Trailing stuff
.\" -------------------------------------------------------------------
.nr Hu 3
.SH "Appendix"
.LI
.LE
.P
.SS "The \*(Fs mailing list"
.P
The \*(Fs mailing list is located at <fhs-discuss@ucsd.edu>.  To
subscribe to the list send mail to <listserv@ucsd.edu> with body
"\f(CWADD fhs-discuss\fP".
.P
Thanks to Network Operations at the University of California at San
Diego who allowed us to use their excellent mailing list server.
.P
As noted in the introduction, please do not send mail to the mailing
list without first contacting the \*(Fs editor or a listed contributor.
.\" -------------------------------------------------------------------
.SS "Background of the \*(Fs"
.P
The process of developing a standard filesystem hierarchy began in
August 1993 with an effort to restructure the file and directory
structure of Linux.  The FSSTND, a filesystem hierarchy standard
specific to the Linux operating system, was released on February 14,
1994.  Subsequent revisions were released on October 9, 1994 and March
28, 1995.
.P
In early 1995, the goal of developing a more comprehensive version of
FSSTND to address not only Linux, but other \*(Ux-like systems was
adopted with the help of members of the BSD development community.
As a result, a concerted effort was made to focus on issues that were
general to \*(Ux-like systems.  In recognition of this widening of
scope, the name of the standard was changed to Filesystem Hierarchy
Standard or \*(Fs for short.
.P
Volunteers who have contributed extensively to this standard are listed
at the end of this document.  This standard represents a consensus view
of those and other contributors.
.\" -------------------------------------------------------------------
.SS "General Guidelines"
.P
Here are some of the guidelines that have been used in the development
of this standard:
.BL
.LI
Solve technical problems while limiting transitional difficulties.
.LI
Make the specification reasonably stable.
.LI
Gain the approval of distributors, developers, and other decision-makers
in relevant development groups and encourage their participation.
.LI
Provide a standard that is attractive to the implementors of different
\*(Ux-like systems.
.LE
.\" -------------------------------------------------------------------
.\" -------------------------------------------------------------------
.SS "Scope"
.P
This document specifies a standard filesystem hierarchy for \*(Fs
filesystems by specifying the location of files and directories, and the
contents of some system files.
.P
This standard has been designed to be used by system integrators,
package developers, and system administrators in the construction and
maintenance of \*(Fs compliant filesystems.  It is primarily intended to
be a reference and is not a tutorial on how to manage a conforming
filesystem hierarchy.
.P
The \*(Fs grew out of earlier work on FSSTND, a filesystem organization
standard for the Linux operating system.  It builds on FSSTND to address
interoperability issues not just in the Linux community but in a wider
arena including 4.4BSD-based operating systems.  It incorporates lessons
learned in the BSD world and elsewhere about multi-architecture support
and the demands of heterogeneous networking.
.P
Although this standard is more comprehensive than previous attempts at
filesystem hierarchy standardization, periodic updates may become
necessary as requirements change in relation to emerging technology.  It
is also possible that better solutions to the problems addressed here
will be discovered so that our solutions will no longer be the best
possible solutions.  Supplementary drafts may be released in addition to
periodic updates to this document.  However, a specific goal is
backwards compatibility from one release of this document to the next.
.P
Comments related to this standard are welcome.  Any comments or
suggestions for changes may be directed to the \*(Fs editor (Daniel
Quinlan <quinlan@pathname.com>) or the \*(Fs mailing
list.  Typographical or grammatical comments should be directed to the
\*(Fs editor.
.\" In translations, the last sentence should be replaced by something like:
.\" Typographical or grammatical comments should be directed to the
.\" translator or to the \*(Fs editor.
.P
Before sending mail to the mailing list it is requested that you first
contact the \*(Fs editor in order to avoid excessive re-discussion of old
topics.
.P
Questions about how to interpret items in this document may occasionally
arise.  If you have need for a clarification, please contact the \*(Fs
editor.  Since this standard represents a consensus of many
participants, it is important to make certain that any interpretation
also represents their collec
tive opinion.  For this reason it may not be
possible to provide an immediate response unless the inquiry has been
the subject of previous discussion.
.SH AUTHORS
.LI
.LE
.P
.\" -------------------------------------------------------------------
.SS "Acknowledgments"
.P
The developers of the \*(Fs wish to thank the developers, system
administrators, and users whose input was essential to this standard.
We wish to thank each of the contributors who helped to write, compile,
and compose this standard.
.P
The \*(Fs Group also wishes to thank those Linux developers who
supported the FSSTND, the predecessor to this standard.  If they hadn't
demonstrated that the FSSTND was beneficial, the \*(Fs could never have
evolved.
.\" -------------------------------------------------------------------
.SS "Contributors"
.LE
.P
.TS
l l.
Brandon S. Allbery	<bsa@kf8nh.wariat.org>
Keith Bostic	<bostic@cs.berkeley.edu>
Drew Eckhardt	<drew@colorado.edu>
Rik Faith	<faith@cs.unc.edu>
Stephen Harris	<sweh@spuddy.mew.co.uk>
Ian Jackson	<ijackson@cus.cam.ac.uk>
John A. Martin	<jmartin@acm.org>
Ian McCloghrie	<ian@ucsd.edu>
Chris Metcalf	<metcalf@lcs.mit.edu>
Ian Murdock	<imurdock@debian.org>
David C. Niemi	<niemidc@clark.net>
Daniel Quinlan	<quinlan@pathname.com>
Eric S. Raymond	<esr@thyrsus.com>
Rusty Russell	<rusty@rustcorp.com.au>
.TE
.LE
.P
Suggestions for changes may be directed to the \*(Fs editor (Daniel
Quinlan <quinlan@pathname.com>) or the \*(Fs mailing
list.  Typographical or grammatical comments should be directed to the
\*(Fs editor.
.\" In translations, the last sentence should be replaced by something like:
.\" Typographical or grammatical comments should be directed to the
.\" translator or to the \*(Fs editor.
.P
Before sending mail to the mailing list it is requested that you first
contact the \*(Fs editor in order to avoid excessive re-discussion of old
topics.
.P
Questions about how to interpret items in this document may occasionally
arise.  If you have need for a clarification, please contact the \*(Fs
editor.  Since this standard represents a consensus of many
participants, it is important to make certain that any interpretation
also represents their collective opinion.  For this reason it may not be
possible to provide an immediate response unless the inquiry has been
the subject of previous discussion.
.\" -------------------------------------------------------------------
.TC
.\" Local Variables:
.\" fill-column:72
.\" End:
.SH "SEE ALSO"
.LI
.LE
.P
.BR file-hierarchy(7),
