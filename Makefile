# Generated automatically from Makefile.in by configure.
# Makefile - top-level Makefile
#  
#  This file is
#    Copyright (C) 1997-1999 Ian Jackson <ian@davenant.greenend.org.uk>
#
#  It is part of adns, which is
#    Copyright (C) 1997-1999 Ian Jackson <ian@davenant.greenend.org.uk>
#    Copyright (C) 1999 Tony Finch <dot@dotat.at>
# 
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software Foundation,
#  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. 

DISTVERSION=	0.7
srcdir=		.

SUBDIRS= src dynamic client regress

all install uninstall clean distclean mostlyclean maintainer-clean distprep:
	set -e; for d in $(SUBDIRS); do $(MAKE) -C $$d $@; done
	$(MAKE) $@-here

all-here install-here uninstall-here distprep-here:	README

clean-here mostlyclean-here:
		rm -f *~ ./#*# core *.orig *.rej adns-*.tar.gz
		rm -rf dist_tmp

distclean-here maintainer-clean-here:	clean-here
		rm -f settings.make config.h config.cache config.log config.status

install-strip:
	$(MAKE) INSTALL_PROGRAM_FLAGS=-s

dist_tmp=dist_tmp/adns-$(DISTVERSION)
dist:			distprep
	rm -rf dist_tmp*
	mkdir dist_tmp $(dist_tmp)
	find \( -name CVS -o -name dist_tmp* \) -prune -o -type d -print | \
		sed -e 's#.*#mkdir -p $(dist_tmp)/&#' | sh
	find \( -name CVS -o -name dist_tmp* \) -prune -o -type f -print | \
		sed -e 's#.*#ln & $(dist_tmp)/&#' | sh
	$(MAKE) -C dist_tmp/adns-$(DISTVERSION) distclean
	cd dist_tmp && tar cf ../$(dist_tmp).tar `basename $(dist_tmp)`
	gzip -9 $(dist_tmp).tar
	mv $(dist_tmp).tar.gz .

check:			all
	$(MAKE) -C regress check

README README-update:
	lynx -dump -number_links -cfg=/dev/null \
		http://www.chiark.greenend.org.uk/~ian/adns/ >README.tmp
	mv -f README.tmp README

TAGS info dvi:
	# do nothing
