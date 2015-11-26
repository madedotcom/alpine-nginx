# Maintainer: Cameron Banta <cbanta@gmail.com>
# Contributor: Jeff Bilyk <jbilyk@gmail.com>
# Contributor: Bartłomiej Piotrowski <nospam@bpiotrowski.pl>

pkgname=nginx
pkgver=1.9.7
pkgrel=0
pkgdesc="lightweight HTTP and reverse proxy server"
url="http://www.nginx.org"
arch="all"
license="custom"
pkgusers="nginx"
pkggroups="nginx"
install=""
# the nginx-initscritps provides openrc script, logrotate and user creation
depends=""
makedepends="pcre-dev openssl-dev zlib-dev linux-headers"
subpackages="$pkgname-doc $pkgname-vim:vim"
source="http://nginx.org/download/$pkgname-$pkgver.tar.gz
    nginx-module-vts.tar.gz::https://github.com/vozlt/nginx-module-vts/archive/v0.1.6.tar.gz    
	ipv6.patch
	"

_builddir="$srcdir"/$pkgname-$pkgver

prepare() {
	cd "$_builddir"
	for i in $source; do
		case $i in
		*.patch) msg $i; patch -p1 -i "$srcdir"/$i || return 1;;
		esac
	done
}

_rundir=/var/run/$pkgname
_logdir=/var/log/$pkgname
_homedir=/var/lib/$pkgname
_tmpdir=$_homedir/tmp
_datadir=/usr/share/$pkgname
_confdir=/etc/$pkgname

build() {
	cd "$_builddir"
	./configure \
		--prefix=$_datadir \
		--sbin-path=/usr/sbin/$pkgname \
		--conf-path=$_confdir/$pkgname.conf \
		--pid-path=$_rundir/$pkgname.pid \
		--lock-path=$_rundir/$pkgname.lock \
		--error-log-path=$_logdir/error.log \
		--http-log-path=$_logdir/access.log \
		--http-client-body-temp-path=$_tmpdir/client_body \
		--http-proxy-temp-path=$_tmpdir/proxy \
		--http-fastcgi-temp-path=$_tmpdir/fastcgi \
		--http-uwsgi-temp-path=$_tmpdir/uwsgi \
		--http-scgi-temp-path=$_tmpdir/scgi \
		--user=nginx \
		--group=nginx \
		--with-ipv6 \
		--with-file-aio \
		--with-pcre-jit \
		--with-http_dav_module \
		--with-http_ssl_module \
		--with-http_stub_status_module \
		--with-http_gzip_static_module \
		--with-http_spdy_module \
		--with-http_auth_request_module \
		--with-mail \
		--with-mail_ssl_module \
		--add-module="$srcdir/nginx-module-vts-0.1.6" \
		|| return 1
	make || return 1
}

package() {
	cd "$_builddir"
	make DESTDIR="$pkgdir" INSTALLDIRS=vendor install || return 1

	install -m644 -D LICENSE "$pkgdir"/usr/share/licenses/$pkgname/LICENSE
	install -m644 -D man/$pkgname.8 "$pkgdir"/usr/share/man/man8/$pkgname.8

	install -d -m0755 "$pkgdir"/$_confdir/conf.d || return 1
	install -d -m0755 "$pkgdir"/$_confdir/default.d || return 1
	install -d -m0755 "$pkgdir"/var/www/localhost/htdocs || return 1
	install -d -m0700 "$pkgdir"/$_homedir || return 1
	install -d -m0700 "$pkgdir"/$_tmpdir || return 1
	install -d -m0700 "$pkgdir"/$_logdir || return 1
}

sha512sums="a3fa097164954b10120a0e7dca4b877da17c237f1e3ca47365aedf55ade2fe55b0f072404dcb909636b3afaa2b51f5c45b002b54424bd6b80ab76b835bbcc7de  nginx-1.9.7.tar.gz
4d8779812db25c2267f354b4d63cdc403162c070a9d3bcdfa535558fd9f69eda447fe3b7cd03e5ab8289e514ba4bc7cf9940132c7e32287ca863eb497bf3fb4e  nginx-module-vts.tar.gz
68d64a84568ec2df0366925ab282a05ebe21a85044b6c7844a47573cfd8cc8ed119cc772358bc3fff36e2d4fdf583a730592825f5f98632993ca86d1f8438d5f  ipv6.patch"
