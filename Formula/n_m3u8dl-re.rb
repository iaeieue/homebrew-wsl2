class NM3u8dlRe < Formula
  desc "Cross-Platform, modern and powerful stream downloader for MPD/M3U8/ISM"
  homepage "https://github.com/nilaoda/N_m3u8DL-RE"
  url "https://github.com/nilaoda/N_m3u8DL-RE/archive/refs/tags/v0.5.1-beta.tar.gz"
  sha256 "55559fec4deef7e40a4d45eebb699865f01d04f7e72110ce5d11b4ca3e655a93"
  license "MIT"

  depends_on "dotnet" => :build

  def install
    rid = if OS.mac?
      if Hardware::CPU.arm?
        "osx-arm64"
      else
        "osx-x64"
      end
    elsif Hardware::CPU.arm?
      "linux-arm64"
    else
      "linux-x64"
    end

    system "dotnet", "publish", "src/N_m3u8DL-RE",
           "-r", rid,
           "-c", "Release",
           "-o", "artifact"

    bin.install "artifact/N_m3u8DL-RE" => "n_m3u8dl-re"
  end

  test do
    assert_match "N_m3u8DL-RE", shell_output("#{bin}/n_m3u8dl-re --help")
  end
end
