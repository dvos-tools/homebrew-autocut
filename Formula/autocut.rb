class Autocut < Formula
  desc "A background service for running shortcuts on schedule"
  homepage "https://github.com/dvos-tools/autocut"
  version "0.1.5"
  
  url "https://github.com/dvos-tools/autocut/releases/download/v0.1.5/autocut-v0.1.5.tar.gz"
  sha256 "863b41dc26290a2395e7b42737f9d0b213874ceef91e5cec92626c8573efd5fc"
  
  depends_on "node@22"
  depends_on "gum"
  
  def install
    # Install dependencies
    system "npm", "install"
    
    # Build the application
    system "npm", "run", "build"
    
    # Create libexec directory and copy built files
    libexec.install "dist"
    libexec.install "config.yml" if File.exist?("config.yml")
    
    # Create log directory
    (var/"log").mkpath
    
    # Make setup script executable and install it
    chmod 0755, "setup-config.sh"
    bin.install "setup-config.sh" => "autocut-setup"
  end
  
  def post_install
    # Create default config if it doesn't exist
    unless File.exist?("#{libexec}/config.yml")
      system "#{bin}/autocut-setup"
    end
  end
  
  service do
    run ["#{HOMEBREW_PREFIX}/bin/node", opt_libexec/"dist/app.js"]
    working_dir opt_libexec
    log_path var/"log/autocut.log"
    error_log_path var/"log/autocut.error.log"
    environment_variables NODE_ENV: "production"
  end
  
  test do
    system "#{bin}/autocut-setup", "--help"
  end
end
