=========
porticron
=========

:Author: `Benedikt Böhm <bb@xnull.de>`_
:Version: 0.7.1
:Web: http://github.com/gentoo/porticron
:Git: ``git clone https://github.com/gentoo/porticron.git``
:Download: http://github.com/gentoo/porticron/downloads

porticron is a simple shell script for portage similar to apticron for debian.
It is called from cron to sync your portage tree and send any pending upgrade
via email. Additionally it checks for security issues reported by
``glsa-check``.

Installation
============

porticron is available via portage:
::

  emerge porticron

Usage
=====

Since version 0.5 porticron supports various command line arguments to change
operating modes:
::

  Usage: porticron [-hvVn] [-c <file>]
  
    -h         print this help text
    -v         enable verbose output
    -V         print version number
    -n         do not send upgrade mails
    -c <file>  use configuration in <file>


Configuration
=============

The configuration for porticron is located at ``/etc/porticron.conf``. You can
set the following options:

SYNC_CMD
  The command porticron should use to synchronize your portage tree. Defaults
  to ``/usr/bin/emerge --sync``. Set this to ``/bin/true`` if your portage tree
  is mounted read-only (e.g. via nfs).

SYNC_OVERLAYS_CMD
  The command porticron should use to synchronize your overlays. Defaults to
  ``/bin/true``. Set this to ``/usr/bin/layman --sync-all`` to use layman for
  overlay synchronization.

UPGRADE_OPTS
  Command-line options that should be passed to emerge while scanning for
  pending upgrades. Defaults to ``--deep --update``.

RCPT
  Recipient of notification mails. Defaults to ``root@$(hostname -f)``

SENDMAIL
  Path to sendmail binary. Defaults to ``/usr/sbin/sendmail``

Example
=======

A sample of an upgrade notification looks like this:
::

  porticron report [Tue, 09 Dec 2008 05:07:06 +0100]
  ========================================================================

  porticron has detected that some packages need upgrading:

      [ebuild     U ] sys-libs/timezone-data-2008i [2008g-r1]
      [ebuild     U ] sys-apps/man-pages-3.14 [3.12]
      [ebuild     U ] sys-process/htop-0.8.1-r1 [0.8.1]
      [ebuild     U ] sys-apps/util-linux-2.14.1 [2.13.1.1]
      [ebuild     U ] app-portage/elogv-0.7.2 [0.7.1]
      [ebuild     U ] sys-apps/busybox-1.11.3 [1.11.1]
      [ebuild     U ] app-admin/eselect-1.0.11-r1 [1.0.10]

  ========================================================================

  You can perform the upgrade by issuing the command:

      emerge --deep --update world

  as root on foo.example.com

  It is recommended that you pretend the upgrade first to confirm that
  the actions that would be taken are reasonable. The upgrade may be
  pretended by issuing the command:

      emerge --deep --update --pretend world
