class Vips < Formula
  desc "Image processing library"
  homepage "https://github.com/libvips/libvips"
  url "https://github.com/libvips/libvips/releases/download/v8.9.0/vips-8.9.0.tar.gz"
  sha256 "97334a5e70aff343d2587f23cb8068fc846a58cd937c89a446142ccf00ea0349"

  # This formula is compiled from source, so there are no bottles.
  bottle :unneeded

  depends_on "pkg-config" => :build
  depends_on "fontconfig"
  depends_on "gettext"
  depends_on "giflib"
  depends_on "glib"
  depends_on "jpeg-turbo"
  depends_on "libexif"
  depends_on "libde265"
  depends_on "libgsf"
  depends_on "libheif"
  depends_on "libpng"
  depends_on "librsvg"
  depends_on "libtiff"
  depends_on "little-cms2"
  depends_on "orc"
  depends_on "pango"
  depends_on "webp"

  # vips uses zlib for gzip-compressed SVG files
  uses_from_macos "zlib"

  def install
    # jpeg-turbo needs to appear before libjpeg, otherwise it's not used
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["jpeg-turbo"].opt_lib/"pkgconfig"

    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --without-ppm
      --without-analyze
      --without-radiance
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/vips", "-l"
    cmd = "#{bin}/vipsheader -f width #{test_fixtures("test.png")}"
    assert_equal "8", shell_output(cmd).chomp
  end
end
