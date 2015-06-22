# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libcgroup/libcgroup-0.41.ebuild,v 1.5 2015/01/26 10:06:41 ago Exp $

EAPI="5"

AUTOTOOLS_AUTORECONF=1

inherit eutils linux-info pam autotools-utils

DESCRIPTION="Tools and libraries to configure and manage kernel control groups"
HOMEPAGE="http://libcg.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/libcg/${PN}/v${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="+daemon debug pam static-libs +tools debug"

RDEPEND="pam? ( virtual/pam )"

DEPEND="
	${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	"
REQUIRED_USE="daemon? ( tools )"

DOCS=(README_daemon README README_systemd INSTALL)
pkg_setup() {
	local CONFIG_CHECK="~CGROUPS"
	if use daemon; then
		CONFIG_CHECK="${CONFIG_CHECK} ~CONNECTOR ~PROC_EVENTS"
	fi
	linux-info_pkg_setup
}

src_prepare() {

	# Change rules file location
	sed -e 's:/etc/cgrules.conf:/etc/cgroup/cgrules.conf:' \
		-i src/libcgroup-internal.h || die "sed failed"
	sed -e 's:\(pam_cgroup_la_LDFLAGS.*\):\1\ -avoid-version:' \
		-i src/pam/Makefile.am || die "sed failed"
	sed -e 's#/var/run#/run#g' -i configure.in || die "sed failed"

	autotools-utils_src_prepare
}

src_configure() {
	local my_conf

	if use pam; then
		my_conf=" --enable-pam-module-dir=$(getpam_mod_dir) "
	fi

	local myeconfargs=(
		$(use_enable daemon)
		$(use_enable debug)
		$(use_enable pam)
		$(use_enable tools)
		${my_conf}
		)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	prune_libtool_files --all

	insinto /etc/cgroup
	doins samples/*.conf || die

	if use tools; then
		newconfd "${FILESDIR}"/cgconfig.confd cgconfig || die
		newinitd "${FILESDIR}"/cgconfig.initd cgconfig || die
	fi
	if use daemon; then
		newconfd "${FILESDIR}"/cgred.confd cgred || die
		newinitd "${FILESDIR}"/cgred.initd cgred || die
	fi
}
